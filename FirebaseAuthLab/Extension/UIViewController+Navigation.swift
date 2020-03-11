//
//  UIViewController+Navigation.swift
//  FirebaseAuthLab
//
//  Created by Eric Davenport on 3/11/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit

extension UIViewController {
  private static func resetWindow(with rootViewController: UIViewController) {
    guard let scene = UIApplication.shared.connectedScenes.first,
      let sceneDelegate = scene.delegate as? SceneDelegate,
      let window = sceneDelegate.window else {
        fatalError("Could not reset window to rootViewController")
    }
    window.rootViewController = rootViewController
  }
  
  public static func showViewController(storyboardName: String, viewControllerID: String) {
    let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
    let newVC = storyboard.instantiateViewController(identifier: viewControllerID)
    resetWindow(with: newVC)
  }
}
