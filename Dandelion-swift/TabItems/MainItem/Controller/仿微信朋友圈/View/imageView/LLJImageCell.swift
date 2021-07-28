//
//  LLJImageCell.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/22.
//

import UIKit

class LLJImageCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        //UI
        setUpUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 基础UI 布局 设置数据 -
extension LLJImageCell {
    
    //UI
    private func setUpUI() {
        
        self.contentView.addSubview(self.imageView)
    }
    
    //赋值
    func setDataSource(imageName: String) {
        imageView.frame = self.bounds
        self.imageView.image = UIImage(named: imageName)
    }
}
