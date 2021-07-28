//
//  LLJCycleImageView.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/22.
//

import UIKit

class LLJCycleImageView: UIView {

    typealias selectItem = ((String) -> Void)
    
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
        collectionView.register(LLJImageCell.self, forCellWithReuseIdentifier: "LLJImageCell")
        return collectionView
    }()
    
    private var imageList: Array<String> = []
    private var itemSize: CGSize = CGSize.zero
    var selectItemBlock: selectItem?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //UI
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK - UICollectionViewDelegate -
extension LLJCycleImageView: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LLJImageCell", for: indexPath) as! LLJImageCell
        cell.setDataSource(imageName: self.imageList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectItemBlock != nil {
            selectItemBlock!(self.imageList[indexPath.row])
        }
        
        let cell = collectionView.cellForItem(at: indexPath)
        let imageView = LLJImageShowView()
        imageView.imageViewShow(oldImageName: self.imageList[indexPath.row], oldImageView: (cell! as! LLJImageCell).imageView, oldSuperView: cell! as UIView)
    }
}

extension LLJCycleImageView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
}

//MARK - UI -
extension LLJCycleImageView {
    
    //UI
    private func setUpUI() {
        
        self.addSubview(self.collectionView)
    }
    
    //设置数据
    func setDataSource(sourceModel: LLJCycleMessageModel) {
        
        self.collectionView.frame = self.bounds
        self.itemSize = sourceModel.frameModel.contentImageSize
        self.imageList = sourceModel.imageModel?.imageList?.components(separatedBy: ",") ?? []
        self.collectionView.reloadData()
    }
}
