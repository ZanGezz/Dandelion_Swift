//
//  LLJAttributeAction.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/8/11.
//

import UIKit

struct Action {
    
    var highLight: AttributeKey
    var tigger: ActionType
    var callBack: (AttributeResult) -> Void
}
