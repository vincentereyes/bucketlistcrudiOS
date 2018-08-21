//
//  ViewController.swift
//  bucketlistcrud
//
//  Created by Vince Reyes on 3/12/18.
//  Copyright © 2018 VinceReyes. All rights reserved.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {
    func itemSaved(with: String, at: IndexPath?) {
        if let ip = at{
            if let task = tasks![ip.row] as? AnyObject {
                if let id = task["_id"] as? String {
                    TaskModel.editTaskWithTitle(title: with, id: id, completionHandler:  {
                        data, response, error in
                        if let response = response {
                            print(response)
                        }
                        if let data = data {
                            do {
                                let json = try JSONSerialization.jsonObject(with: data, options: [])
                                if let jsonObject = json as? AnyObject {
                                    if let message = jsonObject["message"] as? String{
                                        if message == "Success" {
                                            self.dismiss(animated: true, completion: nil)
                                        }
                                        else {
                                            print(jsonObject)
                                        }
                                    }
                                }
                            } catch {
                                
                                print(error)
                            }
                        }
                    })
                }
            }
        } else {
            TaskModel.addTaskWithTitle(title: with, completionHandler: {
                data, response, error in
                if let response = response {
                    print(response)
                }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let jsonObject = json as? AnyObject {
                            if let message = jsonObject["message"] as? String{
                                if message == "Success" {
                                    self.dismiss(animated: true, completion: nil)
                                }
                                else {
                                    print(jsonObject)
                                }
                            }
                        }
                    } catch {
                        
                        print(error)
                    }
                }
            })
        }
        
        
    }
    

    
    
    let managedObjectContent = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    var tasks: NSArray?
    
    override func viewDidLoad() {
        getTasks()
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        getTasks()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let num = tasks?.count{
            return num
        } else {
            return 0
        }
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
        if let taskTitle = (tasks![indexPath.row] as? AnyObject) {
            if let title = taskTitle["title"]!! as? String{
                cell.textLabel?.text = title
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let navigationController = segue.destination as! UINavigationController
            let addItemTableController = navigationController.topViewController as! AddItemTableViewController
            addItemTableController.delegate = self
            
        if let indexPath = sender as? IndexPath {
            if let task = tasks![indexPath.row] as? AnyObject {
                if let title = task["title"] as? String {
                    addItemTableController.item = title
                    addItemTableController.indexPath = indexPath
                }
            }
        }
    }
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        getTasks()
    }
    
    
    func getTasks(){
        TaskModel.getAllTasks() {
            data, response, error in
            do {
                if let tasks = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let data = tasks["data"]{
                        if let taskArray = data as? NSArray {
                            self.tasks = taskArray
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            } catch {
                print("Something went wrong")
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if let task = tasks![indexPath.row] as? AnyObject {
            if let id = task["_id"] as? String {
                TaskModel.deleteTaskWithId(id: id, completionHandler: {
                    data, response, error in
                    if let response = response {
                        print(response)
                    }
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            if let jsonObject = json as? AnyObject {
                                if let message = jsonObject["message"] as? String{
                                    if message == "success" {
                                        self.viewDidLoad()
                                    }
                                    else {
                                        print(jsonObject)
                                    }
                                }
                            }
                        } catch {
                            
                            print(error)
                        }
                    }
                })
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "AddItemSegue", sender: indexPath)
    }
    
    
    func cancelp(by controller: AddItemTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}

