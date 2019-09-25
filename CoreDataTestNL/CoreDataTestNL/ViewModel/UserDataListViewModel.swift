//
//  UserDataViewModel.swift
//  CoreDataTestNL
//
//  Created by Nevil Lad on 25/09/19.
//  Copyright © 2019 Nevil Lad. All rights reserved.
//

import UIKit
import CoreData

protocol UserDataListViewModelDelegate:NSObjectProtocol {
    func reloadData()
}

class UserDataListViewModel: NSObject {
    weak private var delegate: UserDataListViewModelDelegate?
    private lazy var dataProvider: CoreDataProvider = {
           let provider = CoreDataProvider()
           provider.fetchedResultsControllerDelegate = self
           return provider
       }()
    
    init(delegate:UserDataListViewModelDelegate) {
        self.delegate = delegate
        super.init()
      }
    
    func numberOfUserData() -> Int {
        return dataProvider.fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func userInfoViewModelForIndex(index: NSInteger)  ->  UserDataViewModel?{
        guard let userInfo = dataProvider.fetchedResultsController.fetchedObjects?[index] else { return nil }
        return UserDataViewModel(userInfo: userInfo)
    }
    
    func addDataRecord() {
        self.dataProvider.addUserInfo { error in
            //Show Error
        }
    }
    
//    func addDataInBulk() {
//    //    self.dataProvider.importDataFromJson()
//    }
}

extension UserDataListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.delegate?.reloadData()
    }
}

