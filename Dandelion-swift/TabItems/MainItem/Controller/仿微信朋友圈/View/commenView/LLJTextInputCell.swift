//
//  LLJTextInputCell.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/23.
//

import UIKit

class LLJTextInputCell: UITableViewCell {
    
    typealias textChangeBlock = ((String) -> Void)
    
    lazy var textInputView: UITextView = {
        let textInputView = UITextView()
        textInputView.font = LLJFont(18, "")
        textInputView.textColor = LLJBlackColor()
        textInputView.tintColor = LLJColor(46, 201, 114, 1)
        textInputView.delegate = self
        return textInputView
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = LLJColor(241, 241, 241, 1)
        return lineView
    }()
    
    var textChange: textChangeBlock?

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

extension LLJTextInputCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textChange != nil {
            textChange!(textView.text)
        }
    }
}

extension LLJTextInputCell {
    
    private func setSubUpUI() {
        self.contentView.addSubview(self.textInputView)
        self.contentView.addSubview(self.lineView)
        
        self.textInputView.snp_makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp_top).offset(LLJDX(20))
            make.left.equalTo(self.contentView.snp_left).offset(LLJDX(30))
            make.right.equalTo(self.contentView.snp_right).offset(LLJDX(-30))
            make.bottom.equalTo(self.contentView.snp_bottom).offset(LLJDX(-16))
        }
        
        self.lineView.snp_makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.left.equalTo(self.contentView.snp_left).offset(LLJDX(30))
            make.right.equalTo(self.contentView.snp_right)
            make.bottom.equalTo(self.contentView.snp_bottom)
        }
    }
}
