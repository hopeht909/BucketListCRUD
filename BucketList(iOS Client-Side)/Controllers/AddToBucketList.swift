//
//  AddToBucketList.swift
//  BucketList(iOS Client-Side)
//
//  Created by admin on 19/05/1443 AH.
//

import UIKit

protocol BucketListDelegate: AnyObject{
    
    func itemSaved(with text: String, at indexPath: NSIndexPath?)
}

class AddToBucketList: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: BucketListDelegate?
    var item: String?
    var indexPath: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.text = item
        
    }
    // MARK: - Navigation
    
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        
        if let text = textField.text {
            delegate?.itemSaved(with: text, at: indexPath)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}
