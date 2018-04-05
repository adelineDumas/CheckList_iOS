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
    var icon: IconAsset = IconAsset.Folder

    @IBOutlet weak var TextFieldSaisieCheckList: UITextField!
    @IBOutlet weak var imageViewIcon: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       imageViewIcon.image = icon.image
        
        if let edit = listToEdit {
            self.navigationItem.title = "Edit CheckList"
            TextFieldSaisieCheckList.text = edit.name
            imageViewIcon.image = edit.icon.image
            self.icon = edit.icon
        }
    }
    
    @IBAction func done() {
        if let item = TextFieldSaisieCheckList.text {
            if (listToEdit) != nil {
                listToEdit.name = item
                listToEdit.icon = self.icon
                delegate.listDetailViewController(self, didFinishEditingItem: listToEdit)
            } else {
                delegate.listDetailViewController(self, didFinishAddingItem: CheckList(pName: item, icon : icon))
            }
        }
    }
    
    @IBAction func cancel() {
        delegate.listDetailViewControllerDidCancel(self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editIcon" {
            if let dest = segue.destination as? IconPickerViewController{
                dest.delegate = self;
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        TextFieldSaisieCheckList.delegate = self
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        TextFieldSaisieCheckList.becomeFirstResponder()
        if let edit = listToEdit, edit.icon != self.icon {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }else if !((TextFieldSaisieCheckList.text?.isEmpty)!) && listToEdit == nil {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let oldString = textField.text {
            let newString = oldString.replacingCharacters(in: Range(range, in: oldString)!, with: string)
            if newString.isEmpty{
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            } else if let edit = listToEdit, newString == edit.name {
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            }
            else {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
            return true
        }
        return false
    }
    
    func iconChange(newIcon: IconAsset){
        if let edit = listToEdit, edit.icon != newIcon {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            
        }
        self.icon = newIcon
        self.imageViewIcon.image = self.icon.image
    }
    
}


protocol ListDetailViewControllerDelegate : class {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAddingItem item: CheckList)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem item: CheckList)
    
}
