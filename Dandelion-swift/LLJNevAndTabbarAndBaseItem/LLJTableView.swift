//
//  LLJTableView.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/6/1.
//

import UIKit

class LLJTableView: UITableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect, style: UITableView.Style) {
        
        super.init(frame: frame, style: style)
        
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.bounces = false
        self.tableFooterView = UIView(frame: CGRect.zero)
        self.backgroundColor = LLJColor(248, 248, 248, 1)
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
