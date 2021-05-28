//
//  LLJBezierPathController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/4/16.
//

import UIKit

class LLJBezierPathController: LLJFViewController {

    //collectionView
    lazy var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.minimumLineSpacing = LLJDX(15)
        collectionLayout.minimumInteritemSpacing = LLJDX(15)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - LLJTopHeight), collectionViewLayout: collectionLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = LLJColor(240, 240, 240, 1)
        collectionView.register(LLJBezierPathCell.self, forCellWithReuseIdentifier: "BezierPathCell")
        return collectionView
    }()
    
    //资源数组
    var dataSource = [LLJBezierPathModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //UI
        setUpUI()
    }
}

//MARK: - UI -
extension LLJBezierPathController {
    //UI
    func setUpUI() {
        
        self.view.backgroundColor = LLJColor(240, 240, 240, 1)
        
        //按钮
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setTitle("刷新", for: UIControl.State.normal)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.titleLabel?.font = LLJFont(16)
        button.setTitleColor(LLJWhiteColor(), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(buttonClick), for: UIControl.Event.touchUpInside)
        let rightItem = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = rightItem
        
        //collectionView
        self.view.addSubview(self.collectionView)
        
        //圆
        let model1 = LLJBezierPathModel()
        model1.title = "圆"
        model1.strokeColor = LLJPurpleColor()
        model1.fillColor = LLJBlackColor()
        model1.lineWidth = 2.0
        
        //椭圆
        let model2 = LLJBezierPathModel()
        model2.title = "椭圆"
        model2.strokeColor = LLJPurpleColor()
        model2.fillColor = LLJBlackColor()
        model2.lineWidth = 2.0
        
        //多边形
        let model3 = LLJBezierPathModel()
        model3.title = "多边形"
        model3.strokeColor = LLJPurpleColor()
        model3.fillColor = LLJBlackColor()
        model3.lineWidth = 2.0
        model3.closePath = true
        model3.pointArray = [CGPoint(x: 10, y: 0),CGPoint(x: 50, y: 80),CGPoint(x: 90, y: 0)]
        
        //折线
        let model4 = LLJBezierPathModel()
        model4.title = "折线"
        model4.strokeColor = LLJPurpleColor()
        model4.closePath = false
        model4.lineWidth = 2.0
        model4.pointArray = [CGPoint(x: 10, y: 0),CGPoint(x: 30, y: 80),CGPoint(x: 50, y: 0),CGPoint(x: 70, y: 80),CGPoint(x: 90, y: 0)]
        
        //矩形
        let model5 = LLJBezierPathModel()
        model5.title = "矩形"
        
        //矩形
        let model6 = LLJBezierPathModel()
        model6.title = "圆(一)"
        
        //虚线
        let model7 = LLJBezierPathModel()
        model7.title = "虚线"
        
        //切圆角
        let model8 = LLJBezierPathModel()
        model8.title = "切圆角"
        
        //单曲线
        let model9 = LLJBezierPathModel()
        model9.title = "单曲线"
        
        //双曲线
        let model10 = LLJBezierPathModel()
        model10.title = "双曲线"
        
        //正弦曲线
        let model11 = LLJBezierPathModel()
        model11.title = "正弦曲线"
        
        //正切函数
        let model12 = LLJBezierPathModel()
        model12.title = "正切函数"
        
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
        self.dataSource.append(model12)

        self.collectionView.reloadData()
    }
    
    //按钮事件
    @objc func buttonClick() {
        
        
    }
}

//MARK: - UICollectionViewDelegate -
extension LLJBezierPathController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        LLJLog("点击了" + String(indexPath.row))
    }
}

extension LLJBezierPathController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: LLJDX(100), height: LLJDX(140))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10);
    }
}

//MARK: - UICollectionViewDataSource -
extension LLJBezierPathController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BezierPathCell", for: indexPath) as! LLJBezierPathCell
        cell.setDataSource(model: self.dataSource[indexPath.row])
        return cell
    }
}
