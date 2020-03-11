//
//  StorageServices.swift
//  FirebaseAuthLab
//
//  Created by Eric Davenport on 3/11/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import Foundation
import FirebaseStorage

class StorageService {
  private let storageRef = Storage.storage().reference()
  
  public  func uploadPhoto(userID: String? = nil, image: UIImage, completion: @escaping (Result<URL, Error>) -> ()) {
    guard let imageData = image.jpegData(compressionQuality: 1.0) else {
      return
    }
    
    var photoReference : StorageReference!
    
    if let userID = userID {
      photoReference = storageRef.child("UserProfilePhoto/\(userID).jpg")
    }
    
    let metaData = StorageMetadata()
    metaData.contentType = "image/jpg"
    
    let _ = photoReference.putData(imageData, metadata: metaData) { (metaData, error) in
      if let error = error {
        completion(.failure(error))
      } else if let _ = metaData {
        photoReference.downloadURL { (url, error2) in
          if let error = error2 {
            completion(.failure(error))
          } else if let url = url {
            completion(.success(url))
          }
        }
      }
    }
  }
}
