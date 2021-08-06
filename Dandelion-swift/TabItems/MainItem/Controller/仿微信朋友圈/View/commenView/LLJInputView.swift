//
//  LLJInputView.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/31.
//

import UIKit

class LLJInputView: UIView {

    typealias inputViewCompleteBlock = ((String) -> Void)
    
    lazy var textField: UITextView = {
        let textField = UITextView()
        textField.font = LLJFont(16, "")
        textField.tintColor = LLJColor(32, 191, 100, 1.0)
        textField.textColor = LLJBlackColor()
        textField.returnKeyType = .send
        textField.delegate = self
        textField.bounces = false
        textField.showsVerticalScrollIndicator = false
        textField.showsHorizontalScrollIndicator = false
        return textField
    }()
    
    lazy var textView: UIView = {
        let textView = UIView()
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 4.0
        textView.backgroundColor = LLJWhiteColor()
        return textView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "biaoqing"))
        return imageView
    }()
    
    lazy var holdLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.textColor = LLJColor(169, 169, 169, 1.0)
        contentLabel.font = LLJFont(16, "")
        contentLabel.text = "评论"
        return contentLabel
    }()
    
    private var keyBoardHeight: CGFloat = 0.0
    var inputComplete: inputViewCompleteBlock?
    var tableView: UITableView?
    var index: Int = 0
    var sourceList: [Any] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //UI
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LLJInputView: UITextViewDelegate {
    
    private func setUpUI() {
        
        self.backgroundColor = LLJColor(245, 245, 245, 1.0)
        self.frame = CGRect(x: 0, y: SCREEN_HEIGHT - LLJDX(56), width: SCREEN_WIDTH, height: LLJDX(56))

        self.addSubview(self.textView)
        self.textView.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(LLJDX(10))
            make.top.equalTo(self.snp_top).offset(LLJDX(6))
            make.bottom.equalTo(self.snp_bottom).offset(LLJDX(-6))
            make.right.equalTo(self.snp_right).offset(LLJDX(-48))
        }
                
        self.textView.addSubview(self.textField)
        self.textField.frame = CGRect(x: LLJDX(10), y: LLJDX(2), width: LLJDX(334), height: 38.6)
        
        self.textField.addSubview(self.holdLabel)
        self.holdLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.textField.snp_left).offset(LLJDX(10))
            make.top.equalTo(self.textField.snp_top).offset(LLJDX(7))
        }
        
        self.addSubview(self.imageView)
        self.imageView.snp_makeConstraints { (make) in
            make.height.equalTo(LLJDX(30))
            make.width.equalTo(LLJDX(30))
            make.bottom.equalTo(self.snp_bottom).offset(LLJDX(-10))
            make.right.equalTo(self.snp_right).offset(LLJDX(-13))
        }
                
        //键盘弹出
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardShow(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        //键盘收起
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardHidden(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.textField.becomeFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            
            textView.resignFirstResponder()

            if self.inputComplete != nil {
                self.inputComplete!(textView.text)
            }
        }
        return true
    }
    //textView代理
    func textViewDidChange(_ textView: UITextView) {
        
        self.holdLabel.isHidden = textView.hasText
        //计算高度
        textChanged(textField: textView)
    }
    
    //计算高度
    func textChanged(textField: UITextView) {
        
        let textViewFrame = textField.frame
        let constrainSize = CGSize(width:textViewFrame.size.width,height:CGFloat(MAXFLOAT))
        let textSize = textField.sizeThatFits(constrainSize)
        textField.isScrollEnabled = false
        textField.frame.size.height = textSize.height
        let H = LLJDX(17.4) + textSize.height
        let Y = SCREEN_HEIGHT - self.keyBoardHeight - H
        self.frame = CGRect(x: 0, y: Y, width: SCREEN_WIDTH, height: H)
    }
    //键盘弹出
    @objc func keyBoardShow(noti: NSNotification) {
        
        let userInfo = noti.userInfo as NSDictionary?;
        let keyBoardFrame: CGRect = userInfo?.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! CGRect
        keyBoardHeight = keyBoardFrame.size.height
        
        var contentOffset_y: CGFloat = 0.0
        for i in stride(from: 0, to: self.index + 1, by: 1) {
            let item = self.sourceList[i] as! LLJCycleMessageModel
            contentOffset_y += item.frameModel.rowHeight
        }
        
        contentOffset_y = contentOffset_y + LLJDX(260) + LLJTopHeight - SCREEN_HEIGHT + keyBoardHeight + LLJDX(56)
        self.tableView?.setContentOffset(CGPoint(x: 0, y: contentOffset_y), animated: true)
        UIView.animate(withDuration: 0.35) {
            self.frame = CGRect(x: 0, y: SCREEN_HEIGHT - self.keyBoardHeight  - LLJDX(56), width: SCREEN_WIDTH, height: LLJDX(56))
        }
        
        UserDefaults.standard.set(true, forKey: "keyBoardStatus")
        UserDefaults.standard.synchronize()
    }
    //键盘隐藏
    @objc func keyBoardHidden(noti: NSNotification) {

        UIView.animate(withDuration: 0.35) {
            self.frame = CGRect(x: 0, y: SCREEN_HEIGHT - LLJDX(55), width: SCREEN_WIDTH, height: LLJDX(55))
        } completion: { (bool) in
            self.removeFromSuperview()
            
            if self.tableView!.contentSize.height < SCREEN_HEIGHT {
                self.tableView!.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
            }
        }
        UserDefaults.standard.set(false, forKey: "keyBoardStatus")
        UserDefaults.standard.synchronize()
    }
}
