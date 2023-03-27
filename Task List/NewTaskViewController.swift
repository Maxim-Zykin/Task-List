//
//  NewTaskViewController.swift
//  Task List
//
//  Created by Максим Зыкин on 26.03.2023.
//

import UIKit
import CoreData

class NewTaskViewController: UIViewController {

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private lazy var taskTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "New Task"
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Save", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(save), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Cancel", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(taskTextField)
        self.view.addSubview(saveButton)
        self.view.addSubview(cancelButton)
        
        taskTextField.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            taskTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80),
            taskTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            taskTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),
            
            saveButton.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            saveButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),
            
            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            cancelButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),

        ])
    }
    
    @objc private func save() {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        guard let task = NSManagedObject(entity: entityDescription, insertInto: context) as? Task else { return }
        task.name = taskTextField.text
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print(error)
            }
            
            dismiss(animated: true)
        }
    } 
    
    @objc private func cancel(){
      dismiss(animated: true)
    }
}

