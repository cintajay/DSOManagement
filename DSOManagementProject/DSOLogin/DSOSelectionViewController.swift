//
//  DSOSelectionViewController.swift
//  DSOManagementProject
//
//  Created by user193960 on 11/17/22.
//

import UIKit

class DSOSelectionViewController: UIViewController {
    var list = ["DSO1","DSO2","Abc"]
    @IBOutlet weak var dsoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        dsoTableView.dataSource = self
        
    }
}

extension DSOSelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DSOSelectionTableViewCell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
}

extension DSOSelectionViewController: UISearchBarDelegate {
    
}

