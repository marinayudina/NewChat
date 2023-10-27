//
//  StorageManager.swift
//  newChat
//
//  Created by Марина on 20.10.2023.
//

import Foundation

import FirebaseStorage

class StorageManager {
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    ///upload picture to firebase; completion String = URL of image
    public func uploadProfilePicture(with data: Data, fileName: String, completion: @escaping(Result<String, Error>) -> Void) {
        //// Upload the file to the path "images/fileName"
        let ref = storage.child("images/\(fileName)")
        ref.putData(data,metadata: nil) { metadata, error in
            guard error == nil else {
                print("failed to upload picture to firebase")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            ref.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    print("failed  to get download url")
                    completion(.failure(StorageErrors.failedToGetDowloadURL))
                    return
                }
                
                let urlString = downloadURL.absoluteString
                print("download url - \(urlString)")
                completion(.success(urlString))
            }
        }
    }
    
    public enum StorageErrors: Error {
        case failedToUpload
        case failedToGetDowloadURL
    }
    
    public func downloadURL(for path: String, completion: @escaping (Result<URL, Error>) -> Void ) {
        let ref = storage.child(path)
        
        ref.downloadURL { url, error in
            guard let url = url,
                   error == nil else {
                completion(.failure(StorageErrors.failedToGetDowloadURL))
                return
            }
            completion(.success(url))
        }
    }
}
