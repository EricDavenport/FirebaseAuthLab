//
//  ProfileViewController.swift
//  FirebaseAuthLab
//
//  Created by Eric Davenport on 3/11/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit
import FirebaseAuth
import Kingfisher

class ProfileViewController: UIViewController {
  
  @IBOutlet weak var editPhotoButton: UIButton!
  @IBOutlet weak var userPhotoImageView: UIImageView!
  @IBOutlet weak var displayNameTextField: UITextField!
  @IBOutlet weak var displayNameLabel: UILabel!
  @IBOutlet weak var phoneNumberTextField: UITextField!
  @IBOutlet weak var phoneNumberLabel: UILabel!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var emailLabel: UILabel!
  
  private lazy var imagePickerController: UIImagePickerController = {
    let ip = UIImagePickerController()
    ip.delegate = self
    return ip
  }()
  
  private var profileImage : UIImage? {
    didSet {
      userPhotoImageView.image = profileImage
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    displayNameTextField.delegate = self
    phoneNumberTextField.delegate = self
    emailTextField.delegate = self
    updateUI()
  }
  
  private func updateUI() {
    guard let user = Auth.auth().currentUser else { return }
    emailLabel.text = user.email
    phoneNumberLabel.text = user.phoneNumber
    displayNameLabel.text = user.displayName
  }
  
  @IBAction func submitChangeButtonPressed(_ sender: UIButton) {
    
    
  }
  
  
  @IBAction func signOutButtonPressed(_ sender: UIButton) {
    do {
      try Auth.auth().signOut()
      UIViewController.showViewController(storyboardName: "Main", viewControllerID: "LoginViewController")
      print("user signed out")
    } catch {
      print("User signed out")
    }
  }
  
}

extension ProfileViewController : UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}

extension ProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
      return
    }
    profileImage = image
    dismiss(animated: true)
  }
}
