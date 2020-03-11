//
//  AuthenticationSession.swift
//  FirebaseAuthLab
//
//  Created by Eric Davenport on 3/11/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthenticationSession {
  
  public func createNewUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> ()) {
    Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
      if let appError = error {
        completion(.failure(appError))
      } else if let result = authDataResult {
        completion(.success(result))
      }
    }
  }
  
  public func signInExistingUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> ()) {
    Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
      if let error = error {
        completion(.failure(error))
      } else if let result = authDataResult {
        completion(.success(result))
      }
    }
  }
  
}
