//
//  UserDataViewModel.swift
//  CoreDataTestNL
//
//  Created by Nevil Lad on 25/09/19.
//  Copyright © 2019 Nevil Lad. All rights reserved.
//

import UIKit
import CoreData

class UserDataListViewModel: NSObject {
    
    private lazy var foodDataProvider: CoreDataProvider = {
           let provider = CoreDataProvider()
           provider.fetchedResultsControllerDelegate = self
           return provider
       }()
    
    var userDataViewModelList: [UserDataViewModel]?
    
    override init() {
        super.init()
    }
    
    func numberOfUserData() -> Int {
        return self.userDataViewModelList?.count ?? 0
    }
    
    func userInfoViewModelForIndex(index: NSInteger)  ->  UserDataViewModel?{
        return self.userDataViewModelList?[index] ?? nil
    }
    
    func addDataRecord() {
        var userInfo = UserInfo()
        userInfo.userAddress = "Nevil's Address"
        userInfo.userName = "Nevil"
        let array = [userInfo]
        
    
    }
}

extension UserDataListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("data updated")
    }
}
