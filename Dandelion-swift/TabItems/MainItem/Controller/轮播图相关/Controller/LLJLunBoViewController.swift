//
//  LLJLunBoViewController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/6/1.
//

import UIKit

class LLJLunBoViewController: LLJFViewController {
    
    var name: String = ""
    var mapViewStyle: LLJCarouselMapViewStyle = .commen
    var contentViewStyle: LLJCarouselMapContentViewStyle = .image
    var rollDirection: LLJCarouselMapViewRollDirection = .right

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = LLJWhiteColor()
        
        setUpUI()
    }
}

//MARK: - UI -
extension LLJLunBoViewController {
    
    private func setUpUI() {
        
        var array: [UIImage] = []
        for _ in stride(from: 0, to: 10, by: 1) {
            let image = LLJSHelper.getImageByColorAndSize(LLJRandomColor(), CGSize(width: SCREEN_WIDTH - 60, height: 200))
            array.append(image)
        }
        
        /*
         *  delegate: 代理 点击事件和自定义view时，设置view数据使用
         *  imageArray: 图片数组(图片支持：httpURL网络图片；fileURL本地图片；UIImage类型图片)
         *  largeSize: 大view Size
         *  smallSize: 小View Size
         *  itemSpace: 缩放类型时大view和小view的间距
         *  contentSubViewClass: 自定义view类型
         *  sourceCount: 自定义view时 资源个数
         *  autoScorllSpaceTime: 自动轮播时间间隔
         */
        let carouselMapViewZoom = LLJCarouselMapView.init(frame: CGRect(x: 30, y: 150, width: SCREEN_WIDTH - 60, height: (SCREEN_WIDTH - 60)*0.618), mapViewStyle: self.mapViewStyle, contentViewStyle: self.contentViewStyle, rollDirection: self.rollDirection)
        carouselMapViewZoom.delegate = self
        carouselMapViewZoom.imageArray = array
        carouselMapViewZoom.largeSize = CGSize(width: 280, height: 280*0.618)
        carouselMapViewZoom.smallSize = CGSize(width: 240, height: 240*0.618)
        carouselMapViewZoom.itemSpace = 10
        carouselMapViewZoom.contentSubViewClass = UILabel.self
        carouselMapViewZoom.sourceCount = 10;
        carouselMapViewZoom.autoScorllSpaceTime = 3.0
        carouselMapViewZoom.viewTag = 1111;
        carouselMapViewZoom.contentViewCornerRadius = 12.0
        self.view.addSubview(carouselMapViewZoom)
        
        /*
         *  delegate: 代理 点击事件和自定义view时，设置view数据使用
         *  imageArray: 图片数组(图片支持：httpURL网络图片；fileURL本地图片；UIImage类型图片)
         *  largeSize: 大view Size
         *  smallSize: 小View Size
         *  itemSpace: 缩放类型时大view和小view的间距
         *  contentSubViewClass: 自定义view类型
         *  sourceCount: 自定义view时 资源个数
         */
        let carouselMapViewZoom1 = LLJCarouselMapView.init(frame: CGRect(x: 30, y: 500, width: SCREEN_WIDTH - 60, height: 30), mapViewStyle: .commen, contentViewStyle: .custom, rollDirection: .top)
        carouselMapViewZoom1.delegate = self
        carouselMapViewZoom1.imageArray = array
        carouselMapViewZoom1.largeSize = CGSize(width: 280, height: 280*0.618)
        carouselMapViewZoom1.smallSize = CGSize(width: 240, height: 240*0.618)
        carouselMapViewZoom1.itemSpace = 10
        carouselMapViewZoom1.contentSubViewClass = UILabel.self
        carouselMapViewZoom1.sourceCount = 10;
        carouselMapViewZoom1.autoScorllSpaceTime = 3.0
        carouselMapViewZoom1.viewTag = 1112;
        self.view.addSubview(carouselMapViewZoom1)
    }
}

//MARK: - 代理 -
extension LLJLunBoViewController: LLJCarouselMapViewDelegate {
    
    func didSelectItem(superView: UIView, subView: UIView?, currentIndex: Int) {
        LLJLog(currentIndex)
        let subView1 = subView as? UILabel
        subView1?.text = "haha"
    }
    
    func didScorllToView(superView: UIView, subView: UIView, index: Int, currentIndex: Int) -> UIView {
        
        let subView1 = subView as! UILabel
        let superView = superView as! LLJCarouselMapView
        subView1.backgroundColor = UIColor.black
        if superView.viewTag == 1111 {
            subView1.text = "第" + String(index) + "张"
        } else {
            subView1.text = "通知：放假了！！！！！！！"
        }
        subView1.font = LLJFont(16)
        subView1.textColor = LLJWhiteColor()
        subView1.textAlignment = NSTextAlignment.center
        return subView1
    }
}


