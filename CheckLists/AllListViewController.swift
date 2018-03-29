//
//  AllListViewController.swift
//  CheckLists
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 Adeline Dumas. All rights reserved.
//

import UIKit


class AllListViewController: UITableViewController {
    
    var ListCheckList : Array<CheckList> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ListCheckList.append(CheckList(pName: "liste1"))
        ListCheckList.append(CheckList(pName: "liste2"))
        ListCheckList.append(CheckList(pName: "liste3"))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListCheckList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCheckList", for: indexPath)
        cell.textLabel?.text = ListCheckList[indexPath.row].name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCheckList" {
            if let destVC = segue.destination as? CheckListViewController  {
                let cell = sender as! UITableViewCell
                destVC.list = ListCheckList[(tableView.indexPath(for: cell)?.row)!]
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
                destVC.listToEdit = ListCheckList[(tableView.indexPath(for: cell)?.row)!]
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
        ListCheckList.append(item)
        let index = IndexPath(item : ListCheckList.count-1, section : 0)
        tableView.insertRows(at: [index] , with: UITableViewRowAnimation.none)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem item: CheckList) {
        controller.dismiss(animated: true)
        let index = IndexPath(item : ListCheckList.index(where:{ $0 === item })!, section : 0)
        tableView.reloadRows(at: [index] , with: UITableViewRowAnimation.none)
    }
    

    
}
