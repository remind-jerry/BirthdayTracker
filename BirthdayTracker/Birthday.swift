//
//  Birthday.swift
//  BirthdayTracker
//
//  Created by Еременко Игорь on 12.01.2021.
//

import Foundation
class Birthday {
    let firstName: String
    let lastName: String
    let birthdate: Date
    init(firstName: String, lastName: String, birthdate: Date) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthdate = birthdate
    }
}
