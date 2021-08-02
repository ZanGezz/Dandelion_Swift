//
//  LLJImageShowView.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/26.
//

import UIKit

class LLJImageShowView: UIView {

    //collectionView
    lazy var collectionView: UICollectionView = {
        
        let flawLayout = UICollectionViewFlowLayout()
        flawLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        flawLayout.minimumInteritemSpacing = LLJDX(5.0)
        flawLayout.minimumLineSpacing = LLJDX(5.0)
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flawLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.backgroundColor = LLJWhiteColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        return collectionView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private var itemList: [LLJImageShowModel] = []
    private var convertImageFrame: CGRect = CGRect.zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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

//MARK - UICollectionViewDelegate -
extension LLJImageShowView: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.addSubview(self.itemList[indexPath.row] as! UIView)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension LLJImageShowView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
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
        
        self.backgroundColor = LLJColor(0, 0, 0, 0.0)

        UIView.animate(withDuration: 0.25) {
            self.backgroundColor = LLJColor(0, 0, 0, 1.0)
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
        self.imageView.layer.masksToBounds = true
        UIView.animate(withDuration: 0.30) {
            self.backgroundColor = LLJColor(0, 0, 0, 0.0)
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
