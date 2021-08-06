//
//  LLJCycleVideoModel+CoreDataProperties.swift
//  
//
//  Created by 刘帅 on 2021/8/3.
//
//

import Foundation
import CoreData


extension LLJCycleVideoModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LLJCycleVideoModel> {
        return NSFetchRequest<LLJCycleVideoModel>(entityName: "LLJCycleVideoModel")
    }

    @NSManaged public var videoImage: String?
    @NSManaged public var videoUrl: String?

}
