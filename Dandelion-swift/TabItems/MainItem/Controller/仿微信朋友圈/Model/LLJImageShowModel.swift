//
//  LLJImageShowModel.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/8/2.
//

import UIKit

class LLJImageShowModel: NSObject {

    var imageView: UIImageView?
    var oldImageFrame: CGRect = CGRect.zero
    var newImageFrame: CGRect = CGRect.zero
    var oldSuperView: LLJImageCell?
    var convertImageFrame: CGRect = CGRect.zero
}
