//
//  AddItemViewController.swift
//  CheckLists
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 Adeline Dumas. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    
    var delegate: AddItemViewControllerDelegate!
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
            delegate.addItemViewController(self, didFinishEditingItem: itemToEdit)
        } else {
            delegate.addItemViewController(self, didFinishAddingItem: CheckListItem(pText: item))
            }
        }
    }
    
    @IBAction func cancel() {
        delegate.addItemViewControllerDidCancel(self)
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
    
protocol AddItemViewControllerDelegate : class {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: CheckListItem)
    func addItemViewController(_ controller: AddItemViewController, didFinishEditingItem item: CheckListItem)

}

