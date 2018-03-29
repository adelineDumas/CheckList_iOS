//
//  ListDetailViewController.swift
//  CheckLists
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 Adeline Dumas. All rights reserved.
//

import UIKit

class ListDetailViewController: UITableViewController, UITextFieldDelegate {
    
    var listToEdit : CheckList!
    var delegate : ListDetailViewControllerDelegate!

    @IBOutlet weak var TextFieldSaisieCheckList: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let edit = listToEdit {
            self.navigationItem.title = "Edit CheckList"
            TextFieldSaisieCheckList.text = edit.name
        }
    }
    
    @IBAction func done() {
        if let item = TextFieldSaisieCheckList.text {
            if (listToEdit) != nil {
                listToEdit.name = item
                delegate.listDetailViewController(self, didFinishEditingItem: listToEdit)
            } else {
                delegate.listDetailViewController(self, didFinishAddingItem: CheckList(pName: item))
            }
        }
    }
    
    @IBAction func cancel() {
        delegate.listDetailViewControllerDidCancel(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        TextFieldSaisieCheckList.delegate = self
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        TextFieldSaisieCheckList.becomeFirstResponder()
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


protocol ListDetailViewControllerDelegate : class {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAddingItem item: CheckList)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem item: CheckList)
    
}
