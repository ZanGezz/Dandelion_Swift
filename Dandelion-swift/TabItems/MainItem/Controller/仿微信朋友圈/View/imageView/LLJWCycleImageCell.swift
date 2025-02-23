//
//  LLJWCycleImageCell.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/22.
//

import UIKit

class LLJWCycleImageCell: LLJWCommenCell {

    lazy var cycleImageView: LLJCycleImageView = {
        let cycleImageView = LLJCycleImageView()
        return cycleImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //UI
        setSubUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UI -
extension LLJWCycleImageCell {
    
    //UI
    private func setSubUpUI() {
        
        self.contentView.addSubview(self.cycleImageView)
    }
    
    private func layoutSubview(frameModel: LLJCycleFrameModel) {
        
        self.cycleImageView.frame = frameModel.contentImageFrame
    }
}

//MARK: - 数据处理 -
extension LLJWCycleImageCell {
    
    //设置数据
    func setSubDataSource(sourceModel: LLJCycleMessageModel) {
        
        //布局
        layoutSubview(frameModel: sourceModel.frameModel)
        //设置父数据
        setDataSource(sourceModel: sourceModel)
        //设置数据
        self.cycleImageView.setDataSource(sourceModel: sourceModel)
    }
}
