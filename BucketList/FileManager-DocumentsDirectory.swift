//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Sergey Shcheglov on 16.02.2022.
//

import Foundation

extension FileManager {
    static var documentDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
