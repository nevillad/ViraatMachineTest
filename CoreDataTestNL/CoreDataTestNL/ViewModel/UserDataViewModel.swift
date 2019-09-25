//
//  UserDataViewModel.swift
//  CoreDataTestNL
//
//  Created by Nevil Lad on 25/09/19.
//  Copyright © 2019 Nevil Lad. All rights reserved.
//

import UIKit

class UserDataViewModel: NSObject {
    private let userInfo: UserInfo
    
    init(userInfo: UserInfo) {
        self.userInfo = userInfo
        super.init()
    }
    
    func getUserName() -> String {
        return "Name: \(userInfo.userName ?? "Not Availabel")"
    }
    
    func getUserAddress() -> String {
        return "Address: \(userInfo.userAddress ?? "Not Availabel")"
    }
}
