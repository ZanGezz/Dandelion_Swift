//
//  LLJWebLinkCell.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/26.
//

import UIKit

class LLJWebLinkCell: LLJWCommenCell {

    lazy var webLinkView: LLJWebLinkView = {
        let webLinkView = LLJWebLinkView()
        return webLinkView
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
extension LLJWebLinkCell {
    
    //UI
    private func setSubUpUI() {
        
        self.contentView.addSubview(self.webLinkView)
    }
    
    private func layoutSubview(frameModel: LLJCycleFrameModel) {
        
        self.webLinkView.frame = frameModel.contentVideoFrame
    }
}

//MARK: - 数据处理 -
extension LLJWebLinkCell {
    
    //设置数据
    func setSubDataSource(sourceModel: LLJCycleMessageModel) {
        
        //布局
        layoutSubview(frameModel: sourceModel.frameModel)
        //设置父数据
        setDataSource(sourceModel: sourceModel)
        //设置数据
        self.webLinkView.setDataSource(sourceModel: sourceModel)
    }
}
