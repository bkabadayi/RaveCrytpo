//
//  LocalFileManager.swift
//  RaveCrypto
//
//  Created by Berkin Kabadayı on 9.07.2023.
//

import Foundation

class LocalFileManager {
    static let standard = LocalFileManager()
    let fileManager = FileManager.default
    
    private init() { }
    
    func saveImage(imageData: Data?, imageName: String, folderName: String) {
        createFolderIfNeeded(folderName: folderName)
        
        guard let data = imageData, let url = getUrlForImage(imageName: imageName, folderName: folderName) else { return }
        
        do {
            try data.write(to: url)
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    func getImageData(imageName: String, folderName: String) -> Data? {
        guard let url = getUrlForImage(imageName: imageName, folderName: folderName),
              fileManager.fileExists(atPath: url.path()) else { return nil }
        
        return try? Data(contentsOf: url)
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let folderUrl = getUrlForFolder(name: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: folderUrl.path()) {
            do {
                try fileManager.createDirectory(at: folderUrl, withIntermediateDirectories: true)
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
    }
    
    private func getUrlForImage(imageName: String, folderName: String) -> URL? {
        guard let folderUrl = getUrlForFolder(name: folderName) else { return nil }
        
        return folderUrl.appendingPathExtension(imageName + ".png")
    }
    
    private func getUrlForFolder(name: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        
        return url.appendingPathExtension(name)
    }
}
