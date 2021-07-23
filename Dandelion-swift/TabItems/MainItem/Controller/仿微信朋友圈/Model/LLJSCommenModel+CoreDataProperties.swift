//
//  LLJSCommenModel+CoreDataProperties.swift
//  
//
//  Created by 刘帅 on 2021/7/23.
//
//

import Foundation
import CoreData


extension LLJSCommenModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LLJSCommenModel> {
        return NSFetchRequest<LLJSCommenModel>(entityName: "LLJSCommenModel")
    }

    @NSManaged public var age: String?
    @NSManaged public var name: String?
    @NSManaged public var sex: String?

}
