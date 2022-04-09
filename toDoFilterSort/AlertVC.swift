//
//  AlertVC.swift
//  toDoFilterSort
//
//  Created by Mavlon on 23/02/22.
//

import UIKit

class AlertVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func alertTapped(_ sender: Any) {
        showAlert()
    }
    

}

extension AlertVC {
    
    func showAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Fix your problem", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            // print("Ok tapped")
        }
        
        let deleteAction = UIAlertAction(title: "Cancel", style: .destructive) { _ in
            // print("Delete tapped")
        }
        
        alertVC.addAction(okAction)
        alertVC.addAction(deleteAction)
        
        present(alertVC, animated: true, completion: nil)
    }
    
}
