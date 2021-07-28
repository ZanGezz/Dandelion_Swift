//
//  LLJCycleWebLinkModel+CoreDataProperties.swift
//  
//
//  Created by 刘帅 on 2021/7/27.
//
//

import Foundation
import CoreData


extension LLJCycleWebLinkModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LLJCycleWebLinkModel> {
        return NSFetchRequest<LLJCycleWebLinkModel>(entityName: "LLJCycleWebLinkModel")
    }

    @NSManaged public var webLinkContent: String?
    @NSManaged public var webLinkImage: String?
    @NSManaged public var webLinkUrl: String?

}
