//
//  AlertManager.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 21.03.24.
//

import UIKit

class AlertManager {
    public static func showAlert(on vc: UIViewController, title: String, message: String? ) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay!", style: .default))
            vc.present(alert, animated: true)
        }
    }
}
