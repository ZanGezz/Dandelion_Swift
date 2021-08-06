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
        flawLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        flawLayout.minimumLineSpacing = LLJDX(0)
        flawLayout.minimumInteritemSpacing = LLJDX(0)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH+LLJDX(15), height: SCREEN_HEIGHT), collectionViewLayout: flawLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.backgroundColor = LLJWhiteColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        return collectionView
    }()
    
    private var imageView: UIImageView?
    private var itemList: [LLJImageShowModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        cell.backgroundColor = UIColor.clear
        let model = self.itemList[indexPath.row]
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        model.imageView!.frame = model.newImageFrame
        cell.contentView.layer.masksToBounds = true
        cell.contentView.addSubview(model.imageView!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.tapAction(index: indexPath.row)
    }
}

extension LLJImageShowView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH+LLJDX(15), height: SCREEN_HEIGHT)
    }
}

extension LLJImageShowView {
    
    func imageViewShow(selectIndex: Int, allImageName: [String], allSuperView: [LLJImageCell]) {
        //首先显示点击图片
        kRootView.addSubview(self)
        self.frame = kRootView.bounds
        self.backgroundColor = LLJColor(0, 0, 0, 0.0)
        
        //处理所有图片显示
        self.itemList.removeAll()
        for i in stride(from: 0, to: allImageName.count, by: 1) {
            let cell = allSuperView[i]
            let imageName = allImageName[i]
            
            let model = LLJImageShowModel()
            model.oldSuperView = cell
            model.imageView = cell.imageView
            model.oldImageFrame = cell.imageView.frame
            model.newImageFrame = setIamgeSize(oldImageName: imageName)
            model.convertImageFrame = cell.convert(cell.imageView.frame, to: kRootView)
            self.itemList.append(model)
        }
        
        let model = self.itemList[selectIndex]
        model.imageView!.frame = model.convertImageFrame
        self.addSubview(model.imageView!)

        UIView.animate(withDuration: 0.35) {
            self.backgroundColor = LLJColor(0, 0, 0, 1.0)
            model.imageView!.frame = model.newImageFrame
        } completion: { (bool) in
            self.addSubview(self.collectionView)
            self.collectionView.setContentOffset(CGPoint(x: (SCREEN_WIDTH+LLJDX(15))*CGFloat(selectIndex), y: 0), animated: false)
        }
    }
    
    private func setIamgeSize(oldImageName: String) -> CGRect {
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
            if image!.size.height < SCREEN_HEIGHT {
                H = image!.size.height
                Y = (SCREEN_HEIGHT - H)/2.0
                W = (H/image!.size.height)*image!.size.width > SCREEN_WIDTH ? SCREEN_WIDTH : (H/image!.size.height)*image!.size.width
                X = (SCREEN_WIDTH - W)/2.0
            } else {
                Y = 0.0
                H = SCREEN_HEIGHT
                W = (H/image!.size.height)*image!.size.width
                X = (SCREEN_WIDTH - W)/2.0
            }
        }
        return CGRect(x: X, y: Y, width: W, height: H)
    }
}

extension LLJImageShowView {
    
    private func tapAction(index: Int) {
        
        for i in stride(from: 0, to: self.itemList.count, by: 1) {
            
            if i != index {
                let model = self.itemList[i]
                model.imageView!.frame = model.oldImageFrame
                model.oldSuperView!.addSubview(model.imageView!)
            }
        }
        
        let model = self.itemList[index]
        UIView.animate(withDuration: 0.30) {
            self.backgroundColor = LLJColor(0, 0, 0, 0.0)
            model.imageView!.frame = model.convertImageFrame
        } completion: { (com) in
            model.imageView!.frame = model.oldImageFrame
            model.oldSuperView!.addSubview(model.imageView!)
            self.removeFromSuperview()
        }
    }
}
