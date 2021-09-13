//
//  FirstViewController.swift
//  14.7HomeWork
//
//  Created by Igor Frik on 31.08.2021.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    
    @IBAction func nameTextFieldAction(_ sender: Any) {
        UserDefaultsPersistance.shared.userName = nameTextField.text
    }
    @IBAction func secondNameTextFieldAction(_ sender: Any) {
        UserDefaultsPersistance.shared.userSecondName = secondNameTextField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = UserDefaultsPersistance.shared.userName
        secondNameTextField.text = UserDefaultsPersistance.shared.userSecondName
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

class UserDefaultsPersistance {
    static let shared = UserDefaultsPersistance()
    
    private let kUserNameKey = "FirstViewController.kUserNameKey"
    private let kUserSecondNameKey = "FirstViewController.kUserSecondNameKey"
    
    var userName: String? {
        set { UserDefaults.standard.setValue(newValue, forKey: kUserNameKey) }
        get { return UserDefaults.standard.string(forKey: kUserNameKey) }
    }
    var userSecondName: String? {
        set { UserDefaults.standard.setValue(newValue, forKey: kUserSecondNameKey) }
        get { return UserDefaults.standard.string(forKey: kUserSecondNameKey) }
    }
}
