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
    
    func configureCheckmark(for cell: UITableViewCell, withItem item: CheckListItem){
        if item.checked{
            cell.isSelected = true;
        }
        else {
            cell.isSelected = false;
        }
    }
    
    func configureText(for cell:UITableViewCell, withItem item: CheckListItem){
        cell.textLabel?.text = item.text;
    }
    
    
    

    

}

