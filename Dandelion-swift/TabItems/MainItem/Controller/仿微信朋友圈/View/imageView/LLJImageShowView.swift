//
//  LLJImageShowView.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/26.
//

import UIKit

class LLJImageShowView: UIView {

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    private var convertImageFrame: CGRect = CGRect.zero
    private var oldImageFrame: CGRect = CGRect.zero
    private var newImageFrame: CGRect = CGRect.zero
    private var oldSuperView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = LLJColor(0, 0, 0, 1.0)
        //UI
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        LLJLog("LLJImageShowView")
    }
}

extension LLJImageShowView {
    
    func imageViewShow(oldImageName: String, oldImageView: UIImageView, oldSuperView: UIView) {
        
        kRootView.addSubview(self)
        self.frame = kRootView.bounds
        self.addSubview(oldImageView)
        
        self.imageView = oldImageView
        self.oldSuperView = oldSuperView
        
        self.oldImageFrame = oldImageView.frame
        self.convertImageFrame = oldSuperView.convert(oldImageView.frame, to: kRootView)
        self.imageView.frame = self.convertImageFrame
        
        setIamgeSize(oldImageName: oldImageName)
        
        UIView.animate(withDuration: 0.25) {
            self.imageView.frame = self.newImageFrame
        }
    }
    
    private func setIamgeSize(oldImageName: String) {
        let image = UIImage(named: oldImageName)
        
        var X: CGFloat = 0.0
        var Y: CGFloat = 0.0
        var W: CGFloat = 0.0
        var H: CGFloat = 0.0
        if image!.size.width >= image!.size.height {
            X = 0.0
            W = SCREEN_WIDTH
            H = (W/image!.size.width)*image!.size.height
            Y = (SCREEN_HEIGHT - H)/2.0

        } else {
            Y = 0.0
            H = SCREEN_HEIGHT
            W = (H/image!.size.height)*image!.size.width
            X = (SCREEN_WIDTH - W)/2.0
        }
        self.newImageFrame = CGRect(x: X, y: Y, width: W, height: H)
    }
}

extension LLJImageShowView {
    
    private func setUpUI() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.addGestureRecognizer(tap)
    }
    
    @objc func tapAction() {
        self.backgroundColor = LLJColor(0, 0, 0, 0.0)
        self.imageView.layer.masksToBounds = true
        UIView.animate(withDuration: 0.30) {
            self.imageView.frame = self.convertImageFrame
        } completion: { (com) in
            self.imageView.frame = self.oldImageFrame
            self.oldSuperView?.addSubview(self.imageView)
            self.removeFromSuperview()
        }
    }
    
    @objc private func updateContentModel() {
    }
}
