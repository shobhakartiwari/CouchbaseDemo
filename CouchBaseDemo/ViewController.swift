//
//  ViewController.swift
//  CouchBaseDemo
//
//  Created by Shobhakar Tiwari on 10/11/17.
//  Copyright © 2017 Shobhakar. All rights reserved.
//




    //lllll

import UIKit

class ViewController: UIViewController {
    //Edit by latest shubh_tiwari
    
    
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create a manager
        let manager = CBLManager.sharedInstance()
        
        
        
        let database: CBLDatabase
        do {
            // Create or open the database named app
            database = try manager.databaseNamed("app")
        } catch {
            print("Database creation or opening failed")
            return
        }
        
        // The properties that will be saved on the document
        let properties = ["title": "Couchbase Mobile", "sdk": "iOS"]
        // Create a new document
        let document: CBLDocument = database.createDocument()
        
        do {
            // Save the document to the database
            try document.putProperties(properties)
        } catch {
            print("Can't save document in database")
            return
        }
        
        // Log the document ID (generated by the database)
        // and properties
        print("Document ID :: \(document.documentID)")
        print("Learning \(document.property(forKey: "sdk")!)")
        
        // Create replicators to push & pull changes to & from Sync Gateway
        let url = URL(string: "http://localhost:4984/hello")!
        let push = database.createPushReplication(url)
        let pull = database.createPullReplication(url)
        push.continuous = true
        pull.continuous = true
        
        // Start replicators
        push.start()
        pull.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

