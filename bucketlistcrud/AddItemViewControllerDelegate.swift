//
//  SaveButtonDelegate.swift
//  bucketlistcrud
//
//  Created by Vince Reyes on 3/12/18.
//  Copyright © 2018 VinceReyes. All rights reserved.
//

import Foundation
protocol AddItemTableViewControllerDelegate: class {
    func cancelp(by controller: AddItemTableViewController)
    func itemSaved(with: String, at: IndexPath?)
}
