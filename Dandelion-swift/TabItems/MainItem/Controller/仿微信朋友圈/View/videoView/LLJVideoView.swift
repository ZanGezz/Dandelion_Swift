//
//  LLJVideoView.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/24.
//

import UIKit

class LLJVideoView: UIView {

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var videoStart: UIButton = {
        let videoStart = UIButton(type: .custom)
        videoStart.setImage(UIImage(named: "kaishi"), for: .normal)
        videoStart.addTarget(self, action: #selector(videoStartAction), for: .touchUpInside)
        return videoStart
    }()
    
    var videoPlaying: Bool = false
    
    var videoPlayer: LLJBaseVideoPlayer?
    var model: LLJCycleMessageModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //UI
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LLJVideoView {
    
    private func setUpUI() {
        
        self.addSubview(self.imageView)
        self.addSubview(self.videoStart)
    }
    
    func setDataSource(sourceModel: LLJCycleMessageModel) {
        
        self.model = sourceModel

        if !self.videoPlaying {
            self.videoPlayer?.removeFromSuperview()
        }
                
        self.imageView.image = UIImage(named: sourceModel.videoModel!.videoImage!)
        self.frame = sourceModel.frameModel.contentVideoFrame
        self.imageView.frame = self.bounds
        self.videoStart.frame = self.bounds
    }
    
    @objc private func videoStartAction() {
        videoPlay()
    }
    
    func videoPlay() {
        
        self.videoPlaying = true
                
        let videoPlayer = LLJBaseVideoPlayer(frame: self.bounds, url: Bundle.main.path(forResource: self.model?.videoModel?.videoUrl, ofType: "") ?? "")
        self.videoStart.addSubview(videoPlayer)
        videoPlayer.play()
        
        self.videoPlayer = videoPlayer
    }
    
    func videoRelease() {
        self.videoPlaying = false
        self.videoPlayer?.playerRelease()
    }
}
