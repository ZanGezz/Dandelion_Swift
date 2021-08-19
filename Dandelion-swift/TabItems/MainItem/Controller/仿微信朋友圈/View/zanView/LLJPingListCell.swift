//
//  LLJPingListCell.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/29.
//

import UIKit

class LLJPingListCell: UITableViewCell {

    lazy var contentLabel: LJLabel = {
        let contentLabel = LJLabel()
        contentLabel.textColor = LLJColor(30, 30, 30, 1.0)
        contentLabel.font = LLJFont(15)
        contentLabel.numberOfLines = 0;
        return contentLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //UI
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UI -
extension LLJPingListCell {
    
    //UI
    private func setUpUI() {
        
        self.backgroundColor = LLJColor(247, 247, 247, 1.0)

        self.contentView.addSubview(self.contentLabel)
        self.contentLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp_left).offset(LLJDX(10))
            make.right.equalTo(self.contentView.snp_right).offset(LLJDX(-10))
            make.top.equalTo(self.contentView.snp_top)
            make.bottom.equalTo(self.contentView.snp_bottom)
        }
    }
    //设置数据
    func setDataSource(content: LLJAttributeString) {
        
        self.contentLabel.attribute = content
    }
}
