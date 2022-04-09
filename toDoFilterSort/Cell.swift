//
//  Cell.swift
//  toDoFilterSort
//
//  Created by Mavlon on 18/02/22.
//

import UIKit

class Cell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(task: Task) {
        titleLbl.text = task.title
        descriptionLbl.text = task.description
    }
    
}
