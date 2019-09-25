//
//  CoreDataProvider.swift
//  CoreDataTestNL
//
//  Created by Nevil Lad on 25/09/19.
//  Copyright © 2019 Nevil Lad. All rights reserved.
//

import Foundation
import CoreData

class CoreDataProvider: NSObject {
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataTestNL")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.shouldDeleteInaccessibleFaults = true
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func addUserInfo(completionHandler: @escaping (Error?) -> Void) {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil
        taskContext.performAndWait {
            guard let userData = NSEntityDescription.insertNewObject(forEntityName: "UserInfo", into: taskContext) as? UserInfo else {
                print("User Data")
                return
            }

            let names = ["Nevil Lad", "Steve Jobs", "Vinayak Khedkar", "Mayank Agarval", "Keyur Patel", "Jishan Ansari", "Snatosh Shahi", "Elon Musk","Vikram Lander" , "Bill Gates", "Steve Jobs"]
            let addresses = ["B1-803, DSK Madhuban, Sakinanka",
                             "1 Apple Park Way in Cupertino, California, United States",
                             "203, Ganesh Gally, Chinchpokli, Mumbai",
                             "B3-504, Gundecha, Marolnaka, Mumbai",
                             "B1-803, DSK Madhuban, Sakinanka",
                             "1 Apple Park Way in Cupertino, California, United States",
                             "203, Ganesh Gally, Chinchpokli, Mumbai",
                             "B3-504, Gundecha, Marolnaka, Mumbai",
                             "Moon",
                             "B3-504, Gundecha, Marolnaka, Mumbai",
                             "1 Apple Park Way in Cupertino, California, United States"
                                ]
            let number = Int.random(in: 0 ..< 10)
            userData.userName = names[number]
            userData.userAddress = addresses[number]
            userData.time = Date()
            if taskContext.hasChanges {
                do {
                    try taskContext.save()
                } catch {
                    print("Error: \(error)\nCould not save Core Data context.")
                    return
                }
                taskContext.reset()
            }
            completionHandler(nil)
        }
        completionHandler(nil)
    }
    
   
    weak var fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate?
       lazy var fetchedResultsController: NSFetchedResultsController<UserInfo> = {
           let fetchRequest = NSFetchRequest<UserInfo>(entityName: "UserInfo")
            let sort = NSSortDescriptor(key: "time", ascending: false)
            fetchRequest.sortDescriptors = [sort]
            fetchRequest.fetchBatchSize = 20

           let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                       managedObjectContext: persistentContainer.viewContext,
                                                       sectionNameKeyPath: nil, cacheName: nil)
           controller.delegate = fetchedResultsControllerDelegate
           do {
               try controller.performFetch()
           } catch {
               fatalError("Unresolved error \(error)")
           }
           return controller
       }()
    
}
