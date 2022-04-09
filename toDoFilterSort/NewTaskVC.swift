//
//  NewTaskVC.swift
//  toDoFilterSort
//
//  Created by Mavlon on 18/02/22.
//

import UIKit

protocol NewTaskDelegate {
    func addTaskToData(task: Task)
}

class NewTaskVC: UIViewController {
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    
    var delegate: NewTaskDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        if titleTF.text!.isEmpty {
            titleTF.placeholder = "Title: *Required"
        } else {
        self.dismiss(animated: false, completion: nil)
        delegate?.addTaskToData(task: Task(title: titleTF.text!, description: descriptionTF.text!))
        }
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
