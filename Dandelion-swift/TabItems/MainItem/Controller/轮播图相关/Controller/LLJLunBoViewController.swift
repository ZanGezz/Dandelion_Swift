//
//  LLJLunBoViewController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/6/1.
//

import UIKit

class LLJLunBoViewController: LLJFViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = LLJWhiteColor()
        
        let carouselMapView = LLJCarouselMapView.init(frame: CGRect(x: 30, y: 200, width: SCREEN_WIDTH - 60, height: 200), mapViewStyle: .zoom, contentViewStyle: .custom)
        var array: [UIImage] = []
        for _ in stride(from: 0, to: 10, by: 1) {
            let image = LLJSHelper.getImageByColorAndSize(LLJRandomColor(), CGSize(width: SCREEN_WIDTH - 60, height: 200))
            array.append(image)
        }
        carouselMapView.delegate = self
        carouselMapView.iamgeArray = array
        carouselMapView.contentSubViewClass = UILabel.self
        carouselMapView.sourceCount = 10;
        self.view.addSubview(carouselMapView)
    }
}

extension LLJLunBoViewController: LLJCarouselMapViewDelegate {

    func didScorllToView(subView: UIView, index: Int) -> UIView {
        let subView1 = subView as! UILabel
        subView1.backgroundColor = UIColor.black
        subView1.text = String(index)
        subView1.font = LLJFont(22)
        subView1.textColor = LLJWhiteColor()
        subView1.textAlignment = NSTextAlignment.center
        return subView1
    }
}


