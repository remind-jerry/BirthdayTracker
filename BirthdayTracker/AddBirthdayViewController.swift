//
//  ViewController.swift
//  BirthdayTracker
//
//  Created by Еременко Игорь on 09.01.2021.
//

import UIKit
import CoreData
import UserNotifications

class AddBirthdayViewController: UIViewController {
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var birthdatePicker: UIDatePicker!
    
    private var firstName = ""
    private var lastName = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        birthdatePicker.maximumDate = Date()
        dismissKey() // регистрируем распознаватель жестов, чтобы клавиатура скрывалась
    }

    @IBAction func saveTapped( _ sender: UIBarButtonItem) {
        print("Нажата кнопка сохранения.")
        firstName = firstNameTextField.text!.count > 0 ? firstNameTextField.text! : "no_name"
        lastName = lastNameTextField.text!.count > 0 ? lastNameTextField.text! : "no_last_name"

        let birthdate = birthdatePicker.date
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newBirthday = Birthday(context: context)
        
        newBirthday.firstName = firstName
        newBirthday.lastName = lastName
        newBirthday.birthdate = birthdate as Date?
        newBirthday.birthdayId = UUID().uuidString
        if let uniqueId = newBirthday.birthdayId {
            print("birthdayId: \(uniqueId)")
        }
        do {
            try context.save()
            let message = "Сегодня \(firstName) \(lastName) празднует день рождения!"
            let content = UNMutableNotificationContent()
                content.body = message
                content.sound = UNNotificationSound.default
            var dateComponents = Calendar.current.dateComponents([.month,.day], from: birthdate)
            dateComponents.hour = 8
            let trigger = UNCalendarNotificationTrigger(dateMatching:dateComponents, repeats: true)
            if let identifier = newBirthday.birthdayId {
               let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                   let center = UNUserNotificationCenter.current()
                   center.add(request, withCompletionHandler: nil)
            }
        } catch let error {
            print("Не удалось сохранить из-за ошибки \(error).")
        }
        print("Создана запись о дне рождения!")
        print("Имя: \(newBirthday.firstName ?? "")")
        print("Фамилия: \(newBirthday.lastName ?? "")")
        print("День рождения: \(newBirthday.birthdate ?? Date())")
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

}
