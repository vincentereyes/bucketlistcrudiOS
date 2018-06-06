//
//  TaskModel.swift
//  bucketlistcrud
//
//  Created by Vince Reyes on 4/30/18.
//  Copyright © 2018 VinceReyes. All rights reserved.
//

import Foundation

class TaskModel {
    static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        let url = URL(string: "http://localhost:8000/tasks")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        task.resume()
    }
    static func addTaskWithTitle(title: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        // Create the url to request
        if let urlToReq = URL(string: "http://localhost:8000/tasks") {
            // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
            var request = URLRequest(url: urlToReq)
            // Set the method to POST
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            // Create some bodyData and attach it to the HTTPBody
            let bodyData = ["title" : title]
            guard let httpBody = try? JSONSerialization.data(withJSONObject: bodyData, options: []) else {
                return
            }
            request.httpBody = httpBody
            
            // Create the session
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
            task.resume()
        }
    }
    static func editTaskWithTitle(title: String, id: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        // Create the url to request
        if let urlToReq = URL(string: "http://localhost:8000/tasks/" + id) {
            // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
            var request = URLRequest(url: urlToReq)
            // Set the method to PUT
            request.httpMethod = "PUT"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            // Create some bodyData and attach it to the HTTPBody
            let bodyData = ["title" : title]
            guard let httpBody = try? JSONSerialization.data(withJSONObject: bodyData, options: []) else {
                return
            }
            request.httpBody = httpBody
            
            // Create the session
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
            task.resume()
        }
    }
    static func deleteTaskWithId(id: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        // Create the url to request
        if let urlToReq = URL(string: "http://localhost:8000/tasks/" + id) {
            // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
            var request = URLRequest(url: urlToReq)
            // Set the method to DELETE
            request.httpMethod = "DELETE"
            
            // Create the session
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
            task.resume()
        }
    }
}
