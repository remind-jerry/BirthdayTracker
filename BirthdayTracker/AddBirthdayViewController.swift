//
//  ViewController.swift
//  BirthdayTracker
//
//  Created by Еременко Игорь on 09.01.2021.
//

import UIKit

protocol AddBirthdayViewControllerDelegate {
    func addBirthdayViewController(_ addBirthdayViewController: AddBirthdayViewController, didAddBirthday birthday: Birthday)
}

class AddBirthdayViewController: UIViewController {
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var birthdatePicker: UIDatePicker!
    
    private var firstName = ""
    private var lastName = ""
    
    var delegate: AddBirthdayViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        birthdatePicker.maximumDate = Date()
        // Do any additional setup after loading the view.
    }

    @IBAction func saveTapped( _ sender: UIBarButtonItem) {
        print("Нажата кнопка сохранения.")
        firstName = firstNameTextField.text!.count > 0 ? firstNameTextField.text! : "no_name"
        lastName = lastNameTextField.text!.count > 0 ? lastNameTextField.text! : "no_last_name"
//        print("Меня зовут \(firstName), моя фамилия \(lastName).")
        let birthdate = birthdatePicker.date
        let newBirthday = Birthday(firstName: firstName, lastName: lastName, birthdate: birthdate)
        print("Создана запись о днерождения!")
        print("Имя: \(newBirthday.firstName)")
        print("Фамилия: \(newBirthday.lastName)")
        print("День рождения: \(newBirthday.birthdate)")
        delegate?.addBirthdayViewController(self, didAddBirthday: Birthday(firstName: firstName, lastName: lastName, birthdate: birthdatePicker.date))
        dismiss(animated: true)
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
