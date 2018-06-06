//
//  AddItemTableViewController.swift
//  bucketlistcrud
//
//  Created by Vince Reyes on 3/12/18.
//  Copyright © 2018 VinceReyes. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {

    weak var delegate: AddItemTableViewControllerDelegate?
    var item: String?
    var indexPath: IndexPath?
    
    @IBOutlet weak var itemTextField: UITextField!
    
    
    
    @IBAction func saveb(_ sender: UIBarButtonItem) {
        let text = itemTextField.text!
        if text == "" {
            let alert = UIAlertController(title: "Error!", message: "Textfield cannot be empty.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        } else {
            delegate?.itemSaved(with: text, at: indexPath)
        }
    }
    
    @IBAction func cancelp(_ sender: UIBarButtonItem) {
        delegate?.cancelp(by: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTextField.text = item
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
