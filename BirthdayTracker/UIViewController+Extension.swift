//
//  UIViewController+Extension.swift
//  BirthdayTracker
//
//  Created by Еременко Игорь on 18.01.2021.
//

import UIKit

extension UIViewController {
    
    func dismissKey() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

}
