//
//  LLJWebLinkView.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/26.
//

import UIKit

class LLJWebLinkView: UIView {

    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.contentMode = .scaleAspectFill
        headImageView.layer.masksToBounds = true
        return headImageView
    }()
    
    lazy var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.textColor = LLJBlackColor()
        contentLabel.font = LLJFont(14, "")
        contentLabel.numberOfLines = 2;
        return contentLabel
    }()
    
    lazy var webButton: UIButton = {
        let webButton = UIButton(type: .custom)
        webButton.addTarget(self, action: #selector(webAction), for: .touchUpInside)
        return webButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //UI
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LLJWebLinkView {
    
    private func setUpUI() {
        
        self.backgroundColor = LLJColor(242, 242, 242, 1.0)
        
        self.addSubview(self.headImageView)
        self.addSubview(self.contentLabel)
        self.addSubview(self.webButton)
        
        self.headImageView.frame = CGRect(x: LLJDX(5), y: LLJDX(5), width: LLJDX(40), height: LLJDX(40))
        self.contentLabel.frame = CGRect(x: LLJDX(50), y: LLJDX(5), width: LLJDX(256), height: LLJDX(42))
    }
    
    func setDataSource(sourceModel: LLJCycleMessageModel) {
        self.headImageView.image = UIImage(named: sourceModel.webLinkModel!.webLinkImage!)
        self.contentLabel.text = sourceModel.webLinkModel!.webLinkContent
        self.frame = sourceModel.frameModel.contentLinkFrame
        self.webButton.frame = self.bounds
        self.webButton.setImage(LLJSHelper.getImageByColorAndSize(LLJColor(0, 0, 0, 0.2), self.bounds.size), for: .highlighted)
    }
    
    @objc private func webAction() {
        LLJLog("webAction")
    }
}
