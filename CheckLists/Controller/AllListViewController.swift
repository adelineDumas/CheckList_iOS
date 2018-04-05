//
//  AllListViewController.swift
//  CheckLists
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 Adeline Dumas. All rights reserved.
//

import UIKit


class AllListViewController: UITableViewController {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        DataModel.sharedInstance.loadCheckList()
        DataModel.sharedInstance.sortCheckList()
    }
    
    func configureDetailTitle(_ cell: UITableViewCell, _ item: CheckList){
        if(item.items.count == 0){
            cell.detailTextLabel?.text = "No Item"
        } else if(item.uncheckedItemsCount == 0){
            cell.detailTextLabel?.text = "All Done!"
        } else {
            cell.detailTextLabel?.text = String(item.uncheckedItemsCount) + "/" + String(item.items.count)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.sharedInstance.ListCheckList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCheckList", for: indexPath)
        cell.textLabel?.text = DataModel.sharedInstance.ListCheckList[indexPath.row].name
        configureDetailTitle(cell, DataModel.sharedInstance.ListCheckList[indexPath.row])
        cell.imageView?.image = DataModel.sharedInstance.ListCheckList[indexPath.row].icon.image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        DataModel.sharedInstance.ListCheckList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.none)
        DataModel.sharedInstance.saveCheckList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCheckList" {
            if let destVC = segue.destination as? CheckListViewController  {
                let cell = sender as! UITableViewCell
                destVC.ListCheckItem = DataModel.sharedInstance.ListCheckList[(tableView.indexPath(for: cell)?.row)!]
            }
        }
        else if segue.identifier == "addCheckList" {
            if let navVC = segue.destination as? UINavigationController, let destVC = navVC.topViewController as? ListDetailViewController {
                destVC.delegate = self
            }
        }
        else if segue.identifier == "editCheckList" {
            if let navVC = segue.destination as? UINavigationController, let destVC = navVC.topViewController as? ListDetailViewController {
                let cell = sender as! UITableViewCell
                 destVC.listToEdit = DataModel.sharedInstance.ListCheckList[(tableView.indexPath(for: cell)?.row)!]
                destVC.delegate = self
            }
        }
    }
    
    
}

extension AllListViewController : ListDetailViewControllerDelegate {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        controller.dismiss(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAddingItem item: CheckList) {
        controller.dismiss(animated: true)
        DataModel.sharedInstance.ListCheckList.append(item)
        let index = IndexPath(item : DataModel.sharedInstance.ListCheckList.count-1, section : 0)
        tableView.insertRows(at: [index] , with: UITableViewRowAnimation.none)
        DataModel.sharedInstance.sortCheckList()
        DataModel.sharedInstance.saveCheckList()
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem item: CheckList) {
        controller.dismiss(animated: true)
        let index = IndexPath(item : DataModel.sharedInstance.ListCheckList.index(where:{ $0 === item })!, section : 0)
        tableView.reloadRows(at: [index] , with: UITableViewRowAnimation.none)
        DataModel.sharedInstance.sortCheckList()
        DataModel.sharedInstance.saveCheckList()
    }
    

    
}
