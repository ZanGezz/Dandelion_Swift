//
//  LLJBaseVideoPlayer.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/8/5.
//

import UIKit
import AVFoundation

class LLJBaseVideoPlayer: UIView {

    var asset: AVURLAsset?
    var playerItem: AVPlayerItem?
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var url: URL?
    
    init(frame: CGRect, url: String) {
        super.init(frame: frame)
        
        self.url = URL(fileURLWithPath: url)
        //UI
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension LLJBaseVideoPlayer {
    
    private func setUpUI() {
        
        self.backgroundColor = UIColor.black
        
        asset = AVURLAsset(url: self.url!)
        playerItem = AVPlayerItem(asset: asset!)
        player = AVPlayer(playerItem: playerItem!)
        playerLayer = AVPlayerLayer(player: player!)
        
        playerLayer?.frame = self.bounds
        self.layer.masksToBounds = true
        self.layer.insertSublayer(playerLayer!, at: 0)
        
        //AVAudioSession.sharedInstance().setCategory(.playback)
    }
    
    func play() {
        player?.play()
    }
    
    func playerRelease() {
        
        player?.pause()
        
        asset = nil
        playerItem = nil
        player = nil
        playerLayer = nil
        
        self.removeFromSuperview()
    }
}
