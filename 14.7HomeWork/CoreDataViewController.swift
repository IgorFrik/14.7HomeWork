//
//  CoreDataViewController.swift
//  14.7HomeWork
//
//  Created by Igor Frik on 17.09.2021.
//

import UIKit

class CoreDataViewController: UIViewController {
    
    @IBOutlet weak var toDoTable: UITableView!
    var todoList: [String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        toDoTable.reloadData()
    }
    
    @IBAction func newButton(_ sender: Any) {
        todoList.append(" ")
        toDoTable.reloadData()
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

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        idToPerson = categories[indexPath.row].id
    }
    
}
