//
//  ViewController.swift
//  Core Data Practice
//
//  Created by Yuan-Ching Chen on 2015/12/20.
//  Copyright © 2015年 Yuan-Ching Chen. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* step 1: get app delegate & context */
        
        // setup a app delegate to connect with core data
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // context is the handler let us access the database
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        /*
        /* step 2: start to save data*/
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context)
        
         newUser.setValue("Ralph", forKey: "username")
        newUser.setValue("pass456", forKey: "password")
        
        // save
        do {
            try context.save()
        } catch {
            print("error occurs in context saving process: save error")
        }
        */
        
        /* step 3: access the data*/
        // request
        let request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        // search, constrain the selection of objects
        request.predicate = NSPredicate(format: "username = %@ && password = %@", "Ralph" , "pass123")
        
        do {
            let results = try context.executeFetchRequest(request)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject]{
                    
                    // delete object
                    //context.deleteObject(result)
                    
                    // update/ adjust Tom's name
                    //result.setValue("Ralph", forKey: "username")
                    
                    do { try context.save() } catch {}
                    
                    // print out the result
                    if let username = result.valueForKey("username") as? String {
                        print(username)
                        //print(result.valueForKey("username")!)
                    }
                    if let password = result.valueForKey("password") as? String {
                        print(password)
                        //print(result.valueForKey("password")!)
                    }
                }
            }
        } catch {
            print("context.executeFetchRequest failed")
        }
    }
}

