//
//  LLJAnimationController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/4/28.
//

import UIKit

class LLJAnimationController: LLJFViewController {

    //collectionView
    lazy var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.minimumLineSpacing = LLJDX(15)
        collectionLayout.minimumInteritemSpacing = LLJDX(15)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - LLJTopHeight), collectionViewLayout: collectionLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = LLJColor(240, 240, 240, 1)
        collectionView.register(LLJAnimationCell.self, forCellWithReuseIdentifier: "AnimationCell")
        return collectionView
    }()
    
    //资源数组
    var dataSource = [LLJAnimationModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UI
        setUpUI()
    }
    
    //dealloc
    deinit {
        LLJLog("没有循环引用")
    }
}

//MARK: - UI -
extension LLJAnimationController {
    //UI
    func setUpUI() {
        
        self.view.backgroundColor = LLJColor(240, 240, 240, 1)
        
        //基础动画
        let model1 = LLJAnimationModel()
        model1.animationName = "基础动画-平移"
        
        let model2 = LLJAnimationModel()
        model2.animationName = "基础动画-缩放"
        
        let model3 = LLJAnimationModel()
        model3.animationName = "基础动画-旋转"
        
        let model4 = LLJAnimationModel()
        model4.animationName = "基础动画-淡出"
        
        let model5 = LLJAnimationModel()
        model5.animationName = "弹性动画-缩放"
        
        let model6 = LLJAnimationModel()
        model6.animationName = "弹性动画-平移"
        
        let model7 = LLJAnimationModel()
        model7.animationName = "弹性动画-旋转"
        
        let model8 = LLJAnimationModel()
        model8.animationName = "粒子发射-烟花"
        
        let model9 = LLJAnimationModel()
        model9.animationName = "粒子发射-雪花"
        
        let model10 = LLJAnimationModel()
        model10.animationName = "粒子发射-细雨"
        
        let model11 = LLJAnimationModel()
        model11.animationName = "粒子发射-点赞"
        
        //添加模型
        self.dataSource.append(model1)
        self.dataSource.append(model2)
        self.dataSource.append(model3)
        self.dataSource.append(model4)
        self.dataSource.append(model5)
        self.dataSource.append(model6)
        self.dataSource.append(model7)
        self.dataSource.append(model8)
        self.dataSource.append(model9)
        self.dataSource.append(model10)
        self.dataSource.append(model11)

        //collectionView
        self.view.addSubview(self.collectionView)
    }
    
    //按钮事件
    @objc func buttonClick() {
        
        self.collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegate -
extension LLJAnimationController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        LLJLog("点击了" + String(indexPath.row))
    }
}

extension LLJAnimationController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (SCREEN_WIDTH - LLJDX(45))/2, height: SCREEN_WIDTH/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: LLJDX(10), left: LLJDX(10), bottom: LLJDX(10), right: LLJDX(10));
    }
}

//MARK: - UICollectionViewDataSource -
extension LLJAnimationController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimationCell", for: indexPath) as! LLJAnimationCell
        cell.setDataSource(model: self.dataSource[indexPath.row])
        return cell
    }
}

