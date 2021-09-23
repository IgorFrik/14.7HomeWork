//
//  RealmViewController.swift
//  14.7HomeWork
//
//  Created by Igor Frik on 17.09.2021.
//

import UIKit
import RealmSwift

class RealmToDo: Object {
    @objc dynamic var toDo = ""
}

class RealmViewController: UIViewController {
    
    @IBOutlet weak var toDoTable: UITableView!
    @IBOutlet weak var dButton: UIButton!
    private let realm = try! Realm()
    var currentCell: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
//-------------------------------------------FUNC-------------------------------------------
    func save(toDo: String) {
        let element = RealmToDo()
        element.toDo = toDo
        try! realm.write {
            realm.add(element)
        }
        self.toDoTable.reloadData()
    }
    
    func deleteElement() {
        let element = realm.objects(RealmToDo.self)[currentCell]
        try! realm.write {
            realm.delete(element)
        }
        self.toDoTable.reloadData()
    }
    
    func hideDButton() {
        self.dButton.isHidden = true
        
    }
//-------------------------------------------BUTTONS-------------------------------------------
    @IBAction func newButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Add new element", message: "Please input your ToDo:", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "ToDo"
        }
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            if let newTodoTextField = alertController.textFields?[0] {
                let toDoToSave = newTodoTextField.text!
                self.save(toDo: toDoToSave)
                self.hideDButton()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            self.hideDButton()
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        let currentElement = realm.objects(RealmToDo.self)[currentCell]
        let alertController = UIAlertController(title: "Delete element", message: "Delete \(currentElement.toDo)?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            self.deleteElement()
            self.hideDButton()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            self.hideDButton()
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}



extension RealmViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(RealmToDo.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell") as! ToDoTableViewCell
        let element = realm.objects(RealmToDo.self)[indexPath.row]
        cell.toDoLabel.text = element.toDo
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentCell = indexPath.row
        dButton.isHidden = false
    }
}
