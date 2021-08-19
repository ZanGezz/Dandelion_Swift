//
//  LLJZanListCell.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/29.
//

import UIKit

class LLJZanListCell: UITableViewCell {
    
    lazy var xinImageView: UIImageView = {
        let xinImageView = UIImageView()
        xinImageView.image = UIImage(named: "xin")
        return xinImageView
    }()
    
    lazy var contentLabel: LJLabel = {
        let contentLabel = LJLabel()
        contentLabel.textColor = LLJColor(10, 10, 10, 1.0)
        contentLabel.font = LLJBoldFont(15)
        contentLabel.numberOfLines = 0;
        return contentLabel
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = LLJColor(230, 230, 230, 1.0)
        return lineView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //UI
        setUpUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 基础UI 布局 设置数据 -
extension LLJZanListCell {
    
    //UI
    private func setUpUI() {
        
        self.backgroundColor = LLJColor(247, 247, 247, 1.0)

        self.contentView.addSubview(self.contentLabel)
        self.contentView.addSubview(self.xinImageView)
        self.contentView.addSubview(self.lineView)
        
        self.contentLabel.snp_makeConstraints { (make) in
            make.width.equalTo(LLJDX(304))
            make.top.equalTo(self.contentView.snp_top).offset(LLJDX(4))
            make.centerX.equalTo(self.contentView.snp_centerX)
            make.bottom.equalTo(self.contentView.snp_bottom).offset(LLJDX(-4))
        }
        
        self.xinImageView.frame = CGRect(x: LLJDX(10), y: LLJDX(6), width: LLJDX(14), height: LLJDX(14))
        
        self.lineView.snp_makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp_left)
            make.bottom.equalTo(self.contentView.snp_bottom)
            make.right.equalTo(self.contentView.snp_right)
            make.height.equalTo(0.5)
        }
    }
    
    //赋值
    func setDataSource(content: LLJAttributeString, bottomLineHidden: Bool) {
        
        self.lineView.isHidden = bottomLineHidden
        self.contentLabel.attribute = content
    }
}
