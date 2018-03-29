//
//  AddItemViewController.swift
//  CheckLists
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 Adeline Dumas. All rights reserved.
//

import UIKit

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    
    var delegate: ItemDetailViewControllerDelegate!
    var itemToEdit : CheckListItem!
    
    @IBOutlet weak var TextFieldSaisieItem: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let edit = itemToEdit {
            self.navigationItem.title = "Edit Item"
            TextFieldSaisieItem.text = edit.text
        }
    }
    
    @IBAction func done() {
        if let item = TextFieldSaisieItem.text {
        if let edit = itemToEdit {
            itemToEdit.text = item
            delegate.itemDetailViewController(self, didFinishEditingItem: itemToEdit)
        } else {
            delegate.itemDetailViewController(self, didFinishAddingItem: CheckListItem(pText: item))
            }
        }
    }
    
    @IBAction func cancel() {
        delegate.itemDetailViewControllerDidCancel(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        TextFieldSaisieItem.delegate = self
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        TextFieldSaisieItem.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let oldString = textField.text {
            let newString = oldString.replacingCharacters(in: Range(range, in: oldString)!, with: string)
            if newString.isEmpty{
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            }
            else {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
            return true
        }
        return false
    }
    
}

func == (lhs: CheckListItem, rhs: CheckListItem) -> Bool {
    return (lhs.text == rhs.text)
}
    
protocol ItemDetailViewControllerDelegate : class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: CheckListItem)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: CheckListItem)

}

