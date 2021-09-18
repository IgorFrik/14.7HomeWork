//
//  CoreDataViewController.swift
//  14.7HomeWork
//
//  Created by Igor Frik on 17.09.2021.
//

import UIKit

class CoreDataViewController: UIViewController {
    
    @IBOutlet weak var toDoTable: UITableView!
    @IBOutlet weak var eButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    var todoList: [String] = []
    var currentCell: Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        toDoTable.reloadData()
    }
    
    func presentNewAlert() {
        let alertController = UIAlertController(title: "Add new element", message: "Please input your ToDo:", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "ToDo"
        }

        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            if let newTodoTextField = alertController.textFields?[0] {
                self.todoList.append(newTodoTextField.text ?? "Error")
                self.toDoTable.reloadData()
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }

        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func newButton(_ sender: Any) {
        presentNewAlert()
        print(currentCell)
    }
    @IBAction func editButton(_ sender: Any) {
    }
    @IBAction func deleteButton(_ sender: Any) {
    }
    
}

extension CoreDataViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell") as! ToDoTableViewCell
        let currentToDo = todoList[indexPath.row]
        cell.toDoLabel.text = currentToDo
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
