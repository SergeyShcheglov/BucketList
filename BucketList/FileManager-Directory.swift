//
//  FileManager-Directory.swift
//  BucketList
//
//  Created by Sergey Shcheglov on 15.02.2022.
//

import Foundation

extension FileManager {
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
