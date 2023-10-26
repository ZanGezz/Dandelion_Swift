//
//  VideoDetailView.swift
//  Dandelion-swift
//
//  Created by liushuai on 2023/8/7.
//

import UIKit

class VideoDetailView: UIView {
    // 闭包
    typealias callBackBlock = ((NSInteger) -> Void)
    
    lazy var songNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "探清水河"
        label.font = LLJBoldFont(20)
        return label
    }()
    lazy var authorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = LLJColor(162, 167, 180, 1)
        label.text = "威爷"
        label.font = LLJFont(14)
        return label
    }()
    // 返回按钮
    lazy var nextButton: UIButton = {
        let back = UIButton(type: .custom)
        back.setImage(UIImage(named: "wode_next"), for: .normal)
        back.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return back
    }()
    lazy var xieZhen: UIButton = {
        let xieZhen = UIButton(type: .custom)
        xieZhen.setTitle("写真", for: .normal)
        xieZhen.layer.borderWidth = 1.0
        xieZhen.layer.borderColor = LLJColor(162, 167, 180, 1).cgColor
        xieZhen.layer.cornerRadius = 4.0
        xieZhen.titleLabel?.font = LLJFont(10)
        xieZhen.setTitleColor(LLJColor(162, 167, 180, 1), for: .normal)
        xieZhen.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return xieZhen
    }()
    lazy var yinXiao: UIButton = {
        let yinXiao = UIButton(type: .custom)
        yinXiao.setTitle("音效", for: .normal)
        yinXiao.layer.borderWidth = 1.0
        yinXiao.layer.borderColor = LLJColor(162, 167, 180, 1).cgColor
        yinXiao.layer.cornerRadius = 4.0
        yinXiao.titleLabel?.font = LLJFont(10)
        yinXiao.setTitleColor(LLJColor(162, 167, 180, 1), for: .normal)
        yinXiao.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return yinXiao
    }()
    lazy var gaoPin: UIButton = {
        let gaoPin = UIButton(type: .custom)
        gaoPin.setTitle("高品", for: .normal)
        gaoPin.layer.borderWidth = 1.0
        gaoPin.layer.borderColor = LLJColor(162, 167, 180, 1).cgColor
        gaoPin.layer.cornerRadius = 4.0
        gaoPin.titleLabel?.font = LLJFont(10)
        gaoPin.setTitleColor(LLJColor(162, 167, 180, 1), for: .normal)
        gaoPin.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return gaoPin
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "演唱：威爷"
        label.font = LLJBoldFont(22)
        return label
    }()
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = LLJColor(162, 167, 180, 1)
        label.font = LLJBoldFont(16)
        label.text = "作词：老北京小曲"
        return label
    }()
    // 返回按钮
    lazy var songButton: UIButton = {
        let back = UIButton(type: .custom)
        back.setImage(UIImage(named: "maikefeng"), for: .normal)
        back.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return back
    }()
    
    // 回调
    var callBack: callBackBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VideoDetailView {
    // UI
    private func setUpUI() {
        
        self.addSubview(self.songNameLabel)
        self.songNameLabel.snp_makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(LLJDX(22))
            make.top.equalTo(self.snp_top).offset(LLJDX(10))
        }
        
        self.addSubview(self.authorNameLabel)
        self.authorNameLabel.snp_makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(LLJDX(22))
            make.top.equalTo(self.songNameLabel.snp_bottom).offset(LLJDX(6))
        }
        
        self.addSubview(self.nextButton)
        self.nextButton.snp_makeConstraints { make in
            make.left.equalTo(self.authorNameLabel.snp_right).offset(4)
            make.centerY.equalTo(self.authorNameLabel.snp_centerY)
            make.width.equalTo(LLJDX(10))
            make.height.equalTo(LLJDX(10))
        }
        
        self.addSubview(self.xieZhen)
        self.xieZhen.snp_makeConstraints { make in
            make.left.equalTo(self.nextButton.snp_right).offset(4)
            make.centerY.equalTo(self.authorNameLabel.snp_centerY)
            make.width.equalTo(LLJDX(30))
            make.height.equalTo(LLJDX(20))
        }

        self.addSubview(self.yinXiao)
        self.yinXiao.snp_makeConstraints { make in
            make.left.equalTo(self.xieZhen.snp_right).offset(5)
            make.centerY.equalTo(self.authorNameLabel.snp_centerY)
            make.width.equalTo(LLJDX(30))
            make.height.equalTo(LLJDX(20))
        }

        self.addSubview(self.gaoPin)
        self.gaoPin.snp_makeConstraints { make in
            make.left.equalTo(self.yinXiao.snp_right).offset(5)
            make.centerY.equalTo(self.authorNameLabel.snp_centerY)
            make.width.equalTo(LLJDX(30))
            make.height.equalTo(LLJDX(20))        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp_makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(LLJDX(20))
            make.top.equalTo(self.authorNameLabel.snp_bottom).offset(LLJDX(22))
        }
        self.addSubview(self.subTitleLabel)
        self.subTitleLabel.snp_makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(LLJDX(20))
            make.top.equalTo(self.titleLabel.snp_bottom).offset(LLJDX(6))
        }
        self.addSubview(self.songButton)
        self.songButton.snp_makeConstraints { make in
            make.right.equalTo(self.snp_right).offset(-LLJDX(22))
            make.centerY.equalTo(self.subTitleLabel.snp_centerY)
            make.width.equalTo(LLJDX(30))
            make.height.equalTo(LLJDX(30))
        }

    }
    // 返回
    @objc private func buttonAction() {
        LLJLog("back")
        if self.callBack != nil {
            self.callBack!(100100)
        }
    }
}
