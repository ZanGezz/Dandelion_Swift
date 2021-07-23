//
//  LLJFContentController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/5/31.
//

import UIKit

class LLJFContentController: LLJFViewController {

    var name: String?
    var nestView: LLJNestTableView?
    var style: LLJSegmentViewBottomLineScorllStyle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
}

extension LLJFContentController {
    
    func setUpUI() {
        
        self.view.backgroundColor = LLJWhiteColor()
        
        let nest = LLJNestTableView(frame: self.view.bounds)
        nestView = nest
        
        let segmentView = LLJSegmentView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40))
        segmentView.itemTitles = ["关注","头条","抗疫","视频","周边","娱乐","体育","新时代","财经","科技","北京","公开课","汽车","直播","图片","NBA"]
        segmentView.selectItemTitleColor = LLJRandomColor()
        segmentView.itemTitleColor = LLJRandomColor()
        segmentView.itemFont = LLJFont(16)
        segmentView.selectItemFont = LLJBoldFont(18)
        segmentView.itemSpace = LLJDX(22)
        segmentView.firstItemLeftOffSet = LLJDX(11)
        segmentView.currentSelectItem = 5
        segmentView.delegate = self
        segmentView.lineStyle = self.style!
        nest.segmentView = segmentView
        
        
        let sepView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 10))
        sepView.backgroundColor = LLJRandomColor()
        nest.separatorView = sepView
        
        let contentView = LLJContentView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 500))
        var viewList: [UIView] = []
        for _ in stride(from: 0, to: segmentView.itemTitles.count, by: 1) {
            let view = UIView()
            view.backgroundColor = LLJRandomColor()
            viewList.append(view)
        }
        contentView.delegate = self
        contentView.viewList = viewList
        contentView.currentItemIndex = 5
        nest.contentView = contentView
        
        let head = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 100))
        head.backgroundColor = LLJRandomColor()
        nest.headView = head
        
        let foot = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 60))
        foot.backgroundColor = LLJRandomColor()
        nest.footerView = foot
        
        self.view.addSubview(nest)
    }
}

extension LLJFContentController: LLJSegmentViewDelegate {
    
    func didSelectItem(index: Int) {
        let contenteView = nestView?.contentView as! LLJContentView
        contenteView.scrollToItem(index: index, animated: true)
    }
}

extension LLJFContentController: LLJContentViewDelegate {
    
    func didScrollToItem(index: Int, percentage: CGFloat, isDraging: Bool) {
        let segmentView = nestView?.segmentView as! LLJSegmentView
        segmentView.bottomLineScrollToItem(index: index, percentage: percentage, isDraging: isDraging, itemSelected: false)
    }

    func scrollingToItem(index: Int, percentage: CGFloat, isDraging: Bool) {
        let segmentView = nestView?.segmentView as! LLJSegmentView
        segmentView.bottomLineScrollToItem(index: index, percentage: percentage, isDraging: isDraging, itemSelected: false)
    }
}
