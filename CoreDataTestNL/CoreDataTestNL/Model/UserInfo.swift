//
//  UserInfo+CoreDataClass.swift
//  CoreDataTestNL
//
//  Created by Nevil Lad on 25/09/19.
//  Copyright © 2019 Nevil Lad. All rights reserved.
//
//

import Foundation
import CoreData


@objc(UserInfo)

public class UserInfo: NSManagedObject {
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
           super.init(entity: entity, insertInto: context)
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }
    @NSManaged public var userName: String?
    @NSManaged public var userAddress: String?
    @NSManaged public var time: Date?
}



struct UserInfoProperties: Codable {
    let userName, userAddress: String?
}




