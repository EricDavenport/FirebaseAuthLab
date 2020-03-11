//
//  ViewController.swift
//  FirebaseAuthLab
//
//  Created by Eric Davenport on 3/10/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit
import FirebaseAuth

enum AccountState {
  case existingUser
  case newUser
}

class LoginViewController: UIViewController {
  
  @IBOutlet weak var firebaseImageView: UIImageView!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginLabel: UILabel!
  @IBOutlet weak var accountStateButton: UIButton!
  @IBOutlet weak var accountStateStackView: UIStackView!
  @IBOutlet weak var loginButton: UIButton!
  
  private var accountState : AccountState = .existingUser
  private var authSession = AuthenticationSession()
  
  

  override func viewDidLoad() {
    super.viewDidLoad()
    passwordTextField.delegate = self
    emailTextField.delegate = self
  }

  @IBAction func loginButtonPressed(_ sender: UIButton) {
    guard let email = emailTextField.text,
      !email.isEmpty,
      let password = passwordTextField.text,
      !password.isEmpty else {
        print("Missing Fields")
        return
    }
    loginFlow(email: email, passowrd: password)
  }
  
  
  
  @IBAction func toggleAccountState(_ sender: UIButton) {
    accountState = accountState == .existingUser ? .newUser : .existingUser
    
    let duration : TimeInterval = 5.0
    
    if accountState == .existingUser {
      UIView.transition(with: accountStateStackView, duration: duration, options: [.transitionCrossDissolve], animations: {
        self.loginLabel.text = "New user?"
        self.accountStateButton.setTitle("Create Account", for: .normal)
        self.loginButton.setTitle("LOGIN", for: .normal)
      }, completion: nil)
    } else {
      UIView.transition(with: accountStateStackView, duration: duration, options: [.transitionCrossDissolve], animations: {
        self.loginLabel.text = "Already have an account?"
        self.accountStateButton.setTitle("Log in", for: .normal)
        self.loginButton.setTitle("Create Account", for: .normal)
      }, completion: nil)
    }
    
  }
  
  private func navigateToProfileview() {
    UIViewController.showViewController(storyboardName: "Profile", viewControllerID: "ProfileViewController")
  }
  
  private func loginFlow(email: String, passowrd: String) {
    if accountState == .existingUser {
      authSession.signInExistingUser(email: email, password: passowrd) { (result) in
        switch result {
        case .failure(let error):
          print("Error: \(error.localizedDescription)")
        case .success(let result):
          print("welcome back \(result.user.email ?? "no email")")
        }
      }
    } else {
      authSession.createNewUser(email: email, password: passowrd) { (result) in
        switch result {
        case .failure(let error):
          print("Error \(error.localizedDescription)")
        case .success(let result):
          print("welcome New User \(result.user.email ?? "no email")")
        }
      }
    }
  }
  
  
  
}

extension LoginViewController : UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
