//
//  LLJVideoListController.swift
//  Dandelion-swift
//
//  Created by liushuai on 2023/8/1.
//

import UIKit

class LLJVideoController: LLJFViewController {
    
    private var player: LLJPlayerManage?
    var url: String = ""
    private var sourceData: [String] = []
    
    lazy var topView: VideoTopView = {
        let topView = VideoTopView()
        return topView
    }()
    lazy var detailView: VideoDetailView = {
        let detailView = VideoDetailView()
        return detailView
    }()
    
    lazy var bottomView: VideoBottomView = {
        let bottomView = VideoBottomView()
        return bottomView
    }()
    
    lazy var songView: LLJSongView = {
        let songView = LLJSongView(dataSource: [])
        return songView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // UI
        setUpUI()
    }
    
    deinit {
        //player?.releasePlayer()
        LLJLog("LLJVideoController")
    }

}

extension LLJVideoController {
    
    private func buttonAction() {
        weak var weakSelf = self
        self.bottomView.callBack = { (type) in
            switch type {
            case 101010110:
                // 暂停播放
                weakSelf?.player!.changePlayStatus()
            default:
                LLJLog("暂不支持")
            }
        }
        
        self.topView.callBack = { (type) in
            switch type {
            case 1020100:
                // 暂停播放
                weakSelf?.player!.pause()
                weakSelf?.dismiss(animated: true)
            default: break
            }
        }
        
        self.bottomView.sliderMoveCallBack = { (type, value) in
            if type == 101010111 {
                // 拖进度条时，暂停
                weakSelf?.player?.pause()
            } else {
                // 快进
                weakSelf?.player?.llj_seekToTime(time: (weakSelf?.player!.totalTime)!*value, completeHandler: { complete in
                })
            }
        }
        
        self.player?.playStatus = { (totalTime, currentTime, progress, loadProgress, status) in
            // 切换暂停和开始图片
            let play = status == .playing ? true : false
            weakSelf?.bottomView.playStatus = play
            // 设置进度条进度和缓冲进度
            weakSelf?.bottomView.setProgress(progress: progress, loadProgress: loadProgress)
        }
        
    
    }
    
}

// UI
extension LLJVideoController {
    
    private func createPlayer() {
        let path: String = Bundle.main.path(forResource: "ShapofYou.mp3", ofType: "") ?? ""
        sourceData = [path]
        let player = LLJPlayerManage(url: sourceData.first!)
        self.player = player
    }
    
    private func setUpUI() {
        
        self.view.backgroundColor = LLJColor(25, 37, 78, 1)
        //修改状态栏样式
        self.statusBarStyle = UIStatusBarStyle.lightContent
        
        self.view.addSubview(self.topView)
        self.topView.snp_makeConstraints { make in
            make.left.equalTo(self.view.snp_left)
            make.top.equalTo(self.view.snp_top).offset(LLJStatusBarHeight+12)
            make.right.equalTo(self.view.snp_right)
            make.height.equalTo(LLJDX(55))
        }
        
        self.view.addSubview(self.detailView)
        self.detailView.snp_makeConstraints { make in
            make.left.equalTo(self.view.snp_left)
            make.bottom.equalTo(self.view.snp_bottom).offset(LLJDX(-210))
            make.right.equalTo(self.view.snp_right)
            make.height.equalTo(LLJDX(150))
        }
        
        self.view.addSubview(self.bottomView)
        self.bottomView.snp_makeConstraints { make in
            make.left.equalTo(self.view.snp_left)
            make.top.equalTo(self.detailView.snp_bottom).offset(LLJDX(10))
            make.right.equalTo(self.view.snp_right)
            make.height.equalTo(LLJDX(200))
        }
        
        self.view.addSubview(self.songView)
        self.songView.snp_makeConstraints { make in
            make.left.equalTo(self.view.snp_left).offset(60)
            make.top.equalTo(self.topView.snp_bottom).offset(LLJDX(10))
            make.right.equalTo(self.view.snp_right).offset(-60)
            make.bottom.equalTo(self.bottomView.snp_top).offset(-10)
        }
        // 创建播放器
        createPlayer()
        // 创建各种回调block
        buttonAction()
    }
}
