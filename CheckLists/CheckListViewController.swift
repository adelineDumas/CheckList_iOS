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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath)
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
    
    func configureCheckmark(for cell: UITableViewCell, withItem item: CheckListItem){
        if item.checked{
            cell.accessoryType = UITableViewCellAccessoryType.checkmark;
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryType.none;
        }
    }
    
    func configureText(for cell:UITableViewCell, withItem item: CheckListItem){
        cell.textLabel?.text = item.text;
    }
    
    
    @IBAction func addDummyTodo(_ sender: Any) {
        ListCheckItem.append(CheckListItem(pText : "Faire le ménage"))
        let index = IndexPath(item : ListCheckItem.count-1, section : 0)
        tableView.insertRows(at: [index] , with: UITableViewRowAnimation.none)
    }
    

    

}

