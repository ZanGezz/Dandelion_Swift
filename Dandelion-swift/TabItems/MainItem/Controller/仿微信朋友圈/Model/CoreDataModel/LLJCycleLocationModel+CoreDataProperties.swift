//
//  LLJCycleLocationModel+CoreDataProperties.swift
//  
//
//  Created by 刘帅 on 2021/8/3.
//
//

import Foundation
import CoreData


extension LLJCycleLocationModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LLJCycleLocationModel> {
        return NSFetchRequest<LLJCycleLocationModel>(entityName: "LLJCycleLocationModel")
    }

    @NSManaged public var location: String?
    @NSManaged public var name: String?

}
