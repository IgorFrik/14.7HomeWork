//
//  CoreDataViewController.swift
//  14.7HomeWork
//
//  Created by Igor Frik on 17.09.2021.
//

import UIKit
import CoreData

class CoreDataViewController: UIViewController {
    
    @IBOutlet weak var toDoTable: UITableView!
    @IBOutlet weak var dButton: UIButton!
    var currentCell: Int = 0
    var todoList: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
      let managedContext = appDelegate.persistentContainer.viewContext
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ToDoCoreData")
      do {
        todoList = try managedContext.fetch(fetchRequest)
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
    
    func save(toDo: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ToDoCoreData", in: managedContext)!
        let element = NSManagedObject(entity: entity, insertInto: managedContext)
        element.setValue(toDo, forKey: "toDo")
        do {
            try managedContext.save()
            todoList.append(element)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            
        }
    }
    
    func deleteElement(toDo: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ToDoCoreData", in: managedContext)!
        let element = NSManagedObject(entity: entity, insertInto: managedContext)
        element.setValue(toDo, forKey: "toDo")
        managedContext.delete(element)
        todoList.remove(at: currentCell)
    }
    
    @IBAction func newButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Add new element", message: "Please input your ToDo:", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "ToDo"
        }
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            if let newTodoTextField = alertController.textFields?[0] {
                let toDoToSave = newTodoTextField.text!
                self.save(toDo: toDoToSave)
                self.toDoTable.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        dButton.isHidden = true
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Delete element", message: "Delete \(todoList[currentCell])?:", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            self.toDoTable.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        self.dButton.isHidden = true
    }
}

extension CoreDataViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell") as! ToDoTableViewCell
        let currentToDo = todoList[indexPath.row]
        cell.toDoLabel.text = currentToDo.value(forKey: "toDo") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentCell = indexPath.row
        dButton.isHidden = false
    }
}
