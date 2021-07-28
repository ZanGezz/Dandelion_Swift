//
//  LLJLocationCell.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/23.
//

import UIKit

class LLJLocationCell: UITableViewCell {
    
    lazy var logoImage: UIImageView = {
        let logoImage = UIImageView()
        return logoImage
    }()
    
    lazy var directImage: UIImageView = {
        let directImage = UIImageView()
        directImage.image = UIImage(named: "wode_next")
        return directImage
    }()
    
    lazy var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.textColor = LLJBlackColor()
        contentLabel.font = LLJFont(17, "")
        contentLabel.numberOfLines = 0;
        return contentLabel
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = LLJColor(241, 241, 241, 1)
        return lineView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        //UI
        setSubUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LLJLocationCell {
    
    private func setSubUpUI() {
        
        self.contentView.addSubview(self.logoImage)
        self.contentView.addSubview(self.contentLabel)
        self.contentView.addSubview(self.directImage)
        self.contentView.addSubview(self.lineView)
        
        self.logoImage.snp_makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp_left).offset(LLJDX(38))
            make.centerY.equalTo(self.contentView.snp_centerY)
            make.height.equalTo(LLJDX(22))
            make.width.equalTo(LLJDX(22))
        }
        
        self.contentLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp_left).offset(LLJDX(77))
            make.centerY.equalTo(self.contentView.snp_centerY)
        }
        
        self.directImage.snp_makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp_right).offset(LLJDX(-45))
            make.centerY.equalTo(self.contentView.snp_centerY)
        }
        
        self.lineView.snp_makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.left.equalTo(self.contentView.snp_left).offset(LLJDX(30))
            make.right.equalTo(self.contentView.snp_right)
            make.bottom.equalTo(self.contentView.snp_bottom)
        }
    }
    //设置数据
    func setDataSource(content: String, image: String) {
        self.contentLabel.text = content
        self.logoImage.image = UIImage(named: image)
    }
}

