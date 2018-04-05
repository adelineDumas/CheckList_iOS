//
//  ViewController.swift
//  CheckLists
//
//  Created by iem on 01/03/2018.
//  Copyright © 2018 Adeline Dumas. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController {
    
    //var ListCheckItem : Array<CheckListItem> = []

    var ListCheckItem : CheckList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = ListCheckItem.name
        self.view.tintColor = UIColor.gray
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListCheckItem.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath) as! CheckListItemCell
        configureCheckmark(for: cell, withItem: self.ListCheckItem.items[indexPath.row])
        configureText(for: cell, withItem: self.ListCheckItem.items[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        ListCheckItem.items[indexPath.row].toggleChecked()
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        ListCheckItem.items.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.none)
    }
    
    func configureCheckmark(for cell: CheckListItemCell, withItem item: CheckListItem){
        if item.checked{
            cell.LabelCheck.isHidden = false
        }
        else {
            cell.LabelCheck.isHidden = true;
        }
    }
    
    func configureText(for cell:CheckListItemCell, withItem item: CheckListItem){
        cell.LabelItem.text = item.text;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem"{
            if let navVC = segue.destination as? UINavigationController, let destVC = navVC.topViewController as? ItemDetailViewController {
                destVC.delegate = self
            }
        }
        else if segue.identifier == "editItem"{
            if let navVC = segue.destination as? UINavigationController, let destVC = navVC.topViewController as? ItemDetailViewController {
                let cell = sender as! CheckListItemCell
                destVC.itemToEdit = ListCheckItem.items[(tableView.indexPath(for: cell)?.row)!]
                destVC.delegate = self
            }
        }
    }
    }


extension CheckListViewController : ItemDetailViewControllerDelegate {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        controller.dismiss(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: CheckListItem) {
        controller.dismiss(animated: true)
        ListCheckItem.items.append(item)
        let index = IndexPath(item : ListCheckItem.items.count-1, section : 0)
        tableView.insertRows(at: [index] , with: UITableViewRowAnimation.none)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: CheckListItem) {
        controller.dismiss(animated: true)
        let index = IndexPath(item : ListCheckItem.items.index(where:{ $0 === item })!, section : 0)
        tableView.reloadRows(at: [index] , with: UITableViewRowAnimation.none)
    }
    
    
}

