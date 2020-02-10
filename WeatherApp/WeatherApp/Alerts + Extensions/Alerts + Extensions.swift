//
//  Alerts + Extensions.swift
//  WeatherApp
//
//  Created by Tiffany Obi on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
  func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: completion)
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
}
