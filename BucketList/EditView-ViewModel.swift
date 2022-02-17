//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Sergey Shcheglov on 16.02.2022.
//

import Foundation
import CoreLocation

extension EditView {
    @MainActor class EditViewModel: ObservableObject {
        enum LoadingState {
            case loading, loaded, failed
        }
        
        @Published var location: Location
        
        @Published var name: String
        @Published var description: String
        
        @Published var loadingState = LoadingState.loading
        @Published var pages = [Page]()
        
        var onSave: (Location) -> Void

        
        init(location: Location, onSave: @escaping (Location) -> Void) {
            self.location = location
            self.onSave = onSave
            
            _name = Published(initialValue: location.name)
            _description = Published(initialValue: location.description)
        }
        
        func save() {
            var newLocation = location
            newLocation.name = name
            newLocation.id = UUID()
            newLocation.description = description
            onSave(newLocation)
        }
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            
            guard let url = URL(string: urlString) else {
                print("Bad url \(urlString)")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let items = try JSONDecoder().decode(Result.self, from: data)
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
            } catch {
                loadingState = .failed
            }
            
        }
    }
}
