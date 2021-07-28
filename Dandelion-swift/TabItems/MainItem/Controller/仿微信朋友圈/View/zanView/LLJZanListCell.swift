//
//  LLJZanListCell.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/27.
//

import UIKit

class LLJZanListCell: UITableViewCell {

    lazy var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.textColor = LLJColor(68, 86, 130, 1.0)
        contentLabel.font = LLJFont(14, "")
        contentLabel.numberOfLines = 0;
        return contentLabel
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = LLJColor(235, 235, 235, 1.0)
        lineView.isHidden = true
        return lineView
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
extension LLJZanListCell {
    
    //UI
    private func setUpUI() {
        self.contentView.addSubview(self.contentLabel)
        self.contentLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp_left).offset(LLJDX(10))
            make.right.equalTo(self.contentView.snp_right).offset(LLJDX(-10))
            make.centerY.equalTo(self.contentView.snp_centerY)
        }
        self.contentView.addSubview(self.lineView)
        self.lineView.snp_makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp_left)
            make.right.equalTo(self.contentView.snp_right)
            make.bottom.equalTo(self.contentView.snp_bottom)
            make.height.equalTo(0.5)
        }
    }
    //设置数据
    func setDataSource(sourceModel: LLJWeChatCycleModel, frameModel: LLJCycleFrameModel) {
        
        let content = ASAttributedString(string: sourceModel.content!)
        self.contentLabel.attributed.text = content
    }
}
