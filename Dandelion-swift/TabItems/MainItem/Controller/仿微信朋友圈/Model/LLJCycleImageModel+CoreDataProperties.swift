//
//  LLJCycleImageModel+CoreDataProperties.swift
//  
//
//  Created by 刘帅 on 2021/7/31.
//
//

import Foundation
import CoreData


extension LLJCycleImageModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LLJCycleImageModel> {
        return NSFetchRequest<LLJCycleImageModel>(entityName: "LLJCycleImageModel")
    }

    @NSManaged public var imageList: String?

}
