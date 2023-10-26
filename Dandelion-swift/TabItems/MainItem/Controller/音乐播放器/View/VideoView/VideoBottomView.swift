//
//  VideoBottomView.swift
//  Dandelion-swift
//
//  Created by liushuai on 2023/8/8.
//

import UIKit

class VideoBottomView: UIView {
    // 闭包
    typealias callBackBlock = ((NSInteger) -> Void)
    typealias sliderMoveBlock = ((NSInteger,Float) -> Void)

    lazy var shoucang: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 101010100
        button.setImage(UIImage(named: "shoucang"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    lazy var xiazai: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 101010101
        button.setImage(UIImage(named: "xiazai"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    lazy var dongxiao: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 101010102
        button.setImage(UIImage(named: "dongxiao"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    lazy var pinglun: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 101010103
        button.setImage(UIImage(named: "pinglun"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    lazy var more: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 101010104
        button.setImage(UIImage(named: "gengduo"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    lazy var time: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "dingshi"), for: .normal)
        button.tag = 101010105
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    lazy var rate: UIButton = {
        let rate = UIButton(type: .custom)
        rate.setTitle("倍速", for: .normal)
        rate.titleLabel?.font = LLJFont(10)
        rate.layer.cornerRadius = LLJDX(10)
        rate.backgroundColor = LLJColor(66, 66, 66, 1)
        rate.setTitleColor(LLJColor(162, 167, 180, 1), for: .normal)
        rate.tag = 101010106
        rate.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return rate
    }()
    lazy var xunhuan: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "danquxunhuan"), for: .normal)
        button.tag = 101010107
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    lazy var kuaitui: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "shangyishou"), for: .normal)
        button.tag = 101010108
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    lazy var kuaijin: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "xiayishou"), for: .normal)
        button.tag = 101010109
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    lazy var zanting: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "zanting"), for: .normal)
        button.tag = 101010110
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    lazy var list: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "liebiao"), for: .normal)
        button.tag = 101010111
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var sliderView: LLJSilderView = {
        let sliderView = LLJSilderView()
        sliderView.maximumTrackTintColor = .white
        sliderView.minimumTrackTintColor = .orange
        sliderView.setThumbImage(UIImage(named: "yuandian"), for: .normal)
        sliderView.addTarget(self, action: #selector(sliderMove), for: .valueChanged)
        sliderView.addTarget(self, action: #selector(sliderEnded), for: UIControl.Event(rawValue: UIControl.Event.touchUpInside.rawValue | UIControl.Event.touchUpOutside.rawValue | UIControl.Event.touchCancel.rawValue))
        return sliderView
    }()
    
    // 回调
    var callBack: callBackBlock?
    var sliderMoveCallBack: sliderMoveBlock?
    private var _playStatus: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VideoBottomView {
    
    var playStatus: Bool {
        set {
            
            if _playStatus == newValue {
                return
            }
            _playStatus = newValue
            
            if newValue {
                self.zanting.setImage(UIImage(named: "zanting"), for: .normal)
            } else {
                self.zanting.setImage(UIImage(named: "kaishi"), for: .normal)
            }
        }
        get {
            return _playStatus
        }
    }
    
    func setProgress(progress:Float, loadProgress: Float) {
        self.sliderView.value = progress;
        self.sliderView.progressValue = CGFloat(loadProgress)
    }
}

extension VideoBottomView {
    // UI
    private func setUpUI() {
        
        let offset: CGFloat = (SCREEN_WIDTH - LLJDX(44) - LLJDX(26)*5)/4.0
        
        self.addSubview(self.shoucang)
        self.shoucang.snp_makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(LLJDX(22))
            make.top.equalTo(self.snp_top).offset(LLJDX(10))
            make.width.equalTo(LLJDX(26))
            make.height.equalTo(LLJDX(26))
        }
        
        self.addSubview(self.xiazai)
        self.xiazai.snp_makeConstraints { make in
            make.left.equalTo(self.shoucang.snp_right).offset(offset)
            make.centerY.equalTo(self.shoucang.snp_centerY)
            make.width.equalTo(LLJDX(26))
            make.height.equalTo(LLJDX(26))
        }
        
        self.addSubview(self.dongxiao)
        self.dongxiao.snp_makeConstraints { make in
            make.left.equalTo(self.xiazai.snp_right).offset(offset)
            make.centerY.equalTo(self.shoucang.snp_centerY)
            make.width.equalTo(LLJDX(26))
            make.height.equalTo(LLJDX(26))
        }
        
        self.addSubview(self.pinglun)
        self.pinglun.snp_makeConstraints { make in
            make.left.equalTo(self.dongxiao.snp_right).offset(offset)
            make.centerY.equalTo(self.shoucang.snp_centerY)
            make.width.equalTo(LLJDX(26))
            make.height.equalTo(LLJDX(26))
        }

        self.addSubview(self.more)
        self.more.snp_makeConstraints { make in
            make.left.equalTo(self.pinglun.snp_right).offset(offset)
            make.centerY.equalTo(self.shoucang.snp_centerY)
            make.width.equalTo(LLJDX(26))
            make.height.equalTo(LLJDX(26))
        }

        self.addSubview(self.time)
        self.time.snp_makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(LLJDX(22))
            make.top.equalTo(self.shoucang.snp_bottom).offset(LLJDX(24))
            make.width.equalTo(LLJDX(26))
            make.height.equalTo(LLJDX(26))
        }
        
        self.addSubview(self.rate)
        self.rate.snp_makeConstraints { make in
            make.right.equalTo(self.snp_right).offset(LLJDX(-22))
            make.centerY.equalTo(self.time.snp_centerY)
            make.width.equalTo(LLJDX(40))
            make.height.equalTo(LLJDX(20))
        }
        
        self.addSubview(self.sliderView)
        self.sliderView.snp_makeConstraints { make in
            make.left.equalTo(self.time.snp_right).offset(LLJDX(10))
            make.centerY.equalTo(self.time.snp_centerY)
            make.right.equalTo(self.rate.snp_left).offset(LLJDX(-10))
            make.height.equalTo(LLJDX(30))
        }
        
        self.addSubview(self.xunhuan)
        self.xunhuan.snp_makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(LLJDX(22))
            make.top.equalTo(self.time.snp_bottom).offset(LLJDX(24))
            make.width.equalTo(LLJDX(26))
            make.height.equalTo(LLJDX(26))
        }
        self.addSubview(self.kuaitui)
        self.kuaitui.snp_makeConstraints { make in
            make.left.equalTo(self.xunhuan.snp_right).offset(offset)
            make.centerY.equalTo(self.xunhuan.snp_centerY)
            make.width.equalTo(LLJDX(26))
            make.height.equalTo(LLJDX(26))
        }
        self.addSubview(self.zanting)
        self.zanting.snp_makeConstraints { make in
            make.left.equalTo(self.kuaitui.snp_right).offset(offset-10)
            make.centerY.equalTo(self.xunhuan.snp_centerY)
            make.width.equalTo(LLJDX(46))
            make.height.equalTo(LLJDX(46))
        }
        self.addSubview(self.kuaijin)
        self.kuaijin.snp_makeConstraints { make in
            make.left.equalTo(self.zanting.snp_right).offset(offset-10)
            make.centerY.equalTo(self.xunhuan.snp_centerY)
            make.width.equalTo(LLJDX(26))
            make.height.equalTo(LLJDX(26))
        }
        self.addSubview(self.list)
        self.list.snp_makeConstraints { make in
            make.left.equalTo(self.kuaijin.snp_right).offset(offset)
            make.centerY.equalTo(self.xunhuan.snp_centerY)
            make.width.equalTo(LLJDX(26))
            make.height.equalTo(LLJDX(26))
        }

    }
    // 返回
    @objc private func buttonAction(sender: UIButton) {
        LLJLog("back")
        if self.callBack != nil {
            self.callBack!(sender.tag)
        }
    }
    @objc private func sliderMove(slider: LLJSilderView) {
        if self.sliderMoveCallBack != nil {
            self.sliderMoveCallBack!(101010111,slider.value)
        }
    }
    @objc private func sliderEnded(slider: LLJSilderView) {
        if self.sliderMoveCallBack != nil {
            self.sliderMoveCallBack!(101010112,slider.value)
        }
    }
}
