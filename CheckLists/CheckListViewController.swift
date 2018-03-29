//
//  ViewController.swift
//  CheckLists
//
//  Created by iem on 01/03/2018.
//  Copyright © 2018 Adeline Dumas. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController {
    
    var ListCheckItem : Array<CheckListItem> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ListCheckItem.append(CheckListItem(pText : "Finir le cours d'iOS"))
        ListCheckItem.append(CheckListItem(pText : "Mettre à jour XCode"))
        ListCheckItem.append(CheckListItem(pText : "Finir PokeCard"))
        ListCheckItem.append(CheckListItem(pText : "Faire le droit"))

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListCheckItem.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath) as! CheckListItemCell
        configureCheckmark(for: cell, withItem: self.ListCheckItem[indexPath.row])
        configureText(for: cell, withItem: self.ListCheckItem[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        ListCheckItem[indexPath.row].toggleChecked()
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        ListCheckItem.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.none)
    }
    
    func configureCheckmark(for cell: CheckListItemCell, withItem item: CheckListItem){
        if item.checked{
            cell.LabelCheck.isHidden = true
        }
        else {
            cell.LabelCheck.isHidden = false;
        }
    }
    
    func configureText(for cell:CheckListItemCell, withItem item: CheckListItem){
        cell.LabelItem.text = item.text;
    }
    
    
    /*@IBAction func addDummyTodo(_ sender: Any) {
        ListCheckItem.append(CheckListItem(pText : "Faire le ménage"))
        let index = IndexPath(item : ListCheckItem.count-1, section : 0)
        tableView.insertRows(at: [index] , with: UITableViewRowAnimation.none)
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem"{
            if let navVC = segue.destination as? UINavigationController, let destVC = navVC.topViewController as? AddItemViewController {
                destVC.delegate = self
            }
        }
        else if segue.identifier == "editItem"{
            if let navVC = segue.destination as? UINavigationController, let destVC = navVC.topViewController as? AddItemViewController {
                let cell = sender as! CheckListItemCell
                destVC.itemToEdit = ListCheckItem[(tableView.indexPath(for: cell)?.row)!]
                destVC.delegate = self
            }
        }
    }

}


extension CheckListViewController : AddItemViewControllerDelegate {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        controller.dismiss(animated: true)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: CheckListItem) {
        controller.dismiss(animated: true)
        ListCheckItem.append(item)
        let index = IndexPath(item : ListCheckItem.count-1, section : 0)
        tableView.insertRows(at: [index] , with: UITableViewRowAnimation.none)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishEditingItem item: CheckListItem) {
        controller.dismiss(animated: true)
        let index = IndexPath(item : ListCheckItem.index(where:{ $0 === item })!, section : 0)
        tableView.reloadRows(at: [index] , with: UITableViewRowAnimation.none)
    }
    
    
}

