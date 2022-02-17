//
//  EditView.swift
//  BucketList
//
//  Created by Sergey Shcheglov on 15.02.2022.
//

import SwiftUI

struct EditView: View {
    @StateObject var editViewModel: EditViewModel
    @Environment(\.dismiss) var dismiss
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        _editViewModel = StateObject(wrappedValue: EditViewModel(location: location, onSave: onSave))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $editViewModel.name)
                    TextField("Place description", text: $editViewModel.description)
                }
                Section("Nearby") {
                    switch editViewModel.loadingState {
                    case .loading:
                        Text("loading..")
                    case .loaded:
                        ForEach(editViewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    editViewModel.save()
                    dismiss()
                }
            }
            .task {
                await editViewModel.fetchNearbyPlaces()
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { _ in }
    }
}
