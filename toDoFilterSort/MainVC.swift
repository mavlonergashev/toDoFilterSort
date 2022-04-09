//
//  MainVC.swift
//  toDoFilterSort
//
//  Created by Mavlon on 18/02/22.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var noTaskLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortBtn: UIButton!
    
    var searchActive = false
    var data: [Task] = []
    var filteredData: [Task] = []
    var sortedData: [Task] = []
    var isSorted = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        navigationItem.title = "My To Do List"
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = UIColor.yellow
        navigationController?.navigationBar.tintColor = UIColor.red
        navigationController?.navigationBar.barStyle = .default
        
        let add = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(newTaskBtnPressed))
        navigationItem.rightBarButtonItem = add
    }
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBAction func sortBtnPressed(_ sender: Any) {
        searchbar.endEditing(true)
        
        if isSorted {
            sortBtn.setImage(UIImage(systemName: "line.3.horizontal.decrease"), for: .normal)
        } else {
            sortBtn.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        }
        
        sortedData = data.sorted { task1, task2 in
            return task1.title + task1.description < task2.title + task2.description
        }
        isSorted = !isSorted
        tableView.reloadData()
    }
    
    @objc func newTaskBtnPressed() {
        searchbar.endEditing(true)
        
        let vc = NewTaskVC(nibName: "NewTaskVC", bundle: nil)
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        self.present(vc, animated: false, completion: nil)
    }
    
}


//MARK: - SearchBar Delegate -
extension MainVC: UISearchBarDelegate {
   
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        searchbar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        searchbar.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
        searchbar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = data.filter { task in
            return task.title.lowercased().hasPrefix(searchText.lowercased())
        }
        tableView.reloadData()
    }

}

//MARK: - NewTask Delegate -
extension MainVC: NewTaskDelegate {
    
    func addTaskToData(task: Task) {
        data.append(task)
        tableView.reloadData()
    }
}

//MARK: - Table View -
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ -> UIMenu? in
            let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
                // print("shareTapped")
                self.shareTapped()
            }
            let editAction = UIAction(title: "Edit", image: UIImage(systemName: "square.and.pencil")) { _ in
                // print("editTapped")
            }
            let deleteAction = UIAction(title: "Delete ", image: UIImage(systemName: "trash")) { _ in
                // print("deleteTapped")
            }
            return UIMenu(title: "Options", children: [shareAction,editAction,deleteAction])
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchActive {
            if filteredData.count == 0 {
                noTaskLbl.text = "Could not find"
                return 0
            } else {
                noTaskLbl.text = "Results:"
                return filteredData.count
            }
        } else {
            if isSorted {
                if sortedData.count == 0 {
                    noTaskLbl.text = "There are no tasks yet..."
                    return 0
                } else {
                    noTaskLbl.text = "Tasks:"
                    return sortedData.count
                }
            } else {
                if data.count == 0 {
                    noTaskLbl.text = "There are no tasks yet..."
                    return 0
                } else {
                    noTaskLbl.text = "Tasks:"
                    return data.count
                }
            }
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        
        if searchActive {
            cell.updateCell(task: filteredData[indexPath.row])
        } else {
            if isSorted {
                cell.updateCell(task: sortedData[indexPath.row])
            } else {
                cell.updateCell(task: data[indexPath.row])
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction: UIContextualAction = UIContextualAction.init(style: .destructive, title: "Delete") { _, _, _ in
            
            if self.searchActive {
                self.filteredData.remove(at: indexPath.row)
                self.tableView.reloadData()
            } else {
                if self.isSorted {
                    self.sortedData.remove(at: indexPath.row)
                    self.tableView.reloadData()
                } else {
                    self.data.remove(at: indexPath.row)
                    self.tableView.reloadData()
                }
            }
            
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return configuration
    }
    
}

//MARK: - Alert -

extension MainVC {
    
    func showAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Fix your problem", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            // print("Ok tapped")
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            // print("Delete tapped")
        }
        
        alertVC.addAction(okAction)
        alertVC.addAction(deleteAction)
        
        present(alertVC, animated: true, completion: nil)
    }
    
    func shareTapped() {
        let link = URL(string: "https://www.apple.com/")
        let objectsToShare: [Any] = [link as Any]
        
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop,UIActivity.ActivityType.addToReadingList,UIActivity.ActivityType.copyToPasteboard]
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
}
