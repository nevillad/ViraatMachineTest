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
    
    
    func addUserData(from userInfoList:Array<Any>) throws {
        let taskContext = persistentContainer.newBackgroundContext()
              taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
              taskContext.undoManager = nil
              let batchSize = 256
              let count = userInfoList.count
              var numBatches = count / batchSize
              numBatches += count % batchSize > 0 ? 1 : 0
              for batchNumber in 0 ..< numBatches {
                  let batchStart = batchNumber * batchSize
                  let batchEnd = batchStart + min(batchSize, count - batchNumber * batchSize)
                  let range = batchStart..<batchEnd
                  let foodsBatch = Array(userInfoList[range])
                  if !importOneBatch(foodsBatch, taskContext: taskContext) {
                      return
                  }
              }
    }
    
    private func importOneBatch(_ userInfoList: [Any], taskContext: NSManagedObjectContext) -> Bool {
        var success = false
        taskContext.performAndWait {
            for dict in userInfoList {
                guard let userData = NSEntityDescription.insertNewObject(forEntityName: "UserInfo", into: taskContext) as? UserInfo else {
                    print("User Data")
                    return
                }
                userData.userName = "Nevil"
                userData.userAddress = "Address  sadaada "
            }
 
            
            if taskContext.hasChanges {
                do {
                    try taskContext.save()
                } catch {
                    print("Error: \(error)\nCould not save Core Data context.")
                    return
                }
                taskContext.reset()
            }
            success = true
        }
        return success
    }
    
    func fetchUserData() {
        
    }
    
    
    weak var fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate?
       lazy var fetchedResultsController: NSFetchedResultsController<UserInfo> = {
           let fetchRequest = NSFetchRequest<UserInfo>(entityName: "UserInfo")
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
