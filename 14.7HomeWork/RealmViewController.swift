//
//  RealmViewController.swift
//  14.7HomeWork
//
//  Created by Igor Frik on 17.09.2021.
//

import UIKit
import CoreData

class RealmViewController: UIViewController {
    
    @IBOutlet weak var toDoTable: UITableView!
    @IBOutlet weak var dButton: UIButton!
    var currentCell: Int = 0
    var todoList: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
    }
//-------------------------------------------FUNC-------------------------------------------
    func save(toDo: String) {

    }
    
    func deleteElement() {

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
        let alertController = UIAlertController(title: "Delete element", message: "Delete \(self.todoList[currentCell].value(forKey: "toDo") ?? "This element")?", preferredStyle: .alert)
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
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell") as! ToDoTableViewCell
//        let currentToDo = todoList[indexPath.row]
//        cell.toDoLabel.text = currentToDo.value(forKey: "toDo") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentCell = indexPath.row
        dButton.isHidden = false
    }
}
