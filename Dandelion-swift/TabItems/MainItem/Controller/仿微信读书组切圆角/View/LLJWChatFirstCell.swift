//
//  LLJWChatFirstCell.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/5/14.
//

import UIKit

class LLJWChatFirstCell: UITableViewCell {

    //懒加载属性
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView(image: UIImage(named: "head"))
        headImageView.bounds = CGRect(x: 0, y: 0, width: LLJDX(64), height: LLJDX(64))
        LLJSUIKitHelper.LLJCView(subView: headImageView, cornerRadius: 32)
        return headImageView
    }()
    
    lazy var name: UILabel = {
        let name = UILabel()
        name.textColor = LLJBlackColor()
        name.font = LLJMediumFont(20)
        return name
    }()
    
    lazy var content: UILabel = {
        let content = UILabel()
        content.textColor = LLJColor(170, 170, 170, 1)
        content.font = LLJFont(12)
        return content
    }()
    
    lazy var arrowContent: UILabel = {
        let arrowContent = UILabel()
        arrowContent.textColor = LLJColor(170, 170, 170, 1)
        arrowContent.font = LLJFont(12)
        arrowContent.textAlignment = NSTextAlignment.right
        return arrowContent
    }()
    
    lazy var arrow: UIImageView = {
        let arrow = UIImageView(image: UIImage(named: "wode_next"))
        return arrow
    }()
    
    var dataSource: [LLJWChatModel] = []
        
    //初始化
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setDataSource()
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LLJWChatFirstCell {
    
    func setUpUI() {
        
        self.backgroundColor = LLJColor(238, 238, 238, 1)
        
        self.contentView.addSubview(self.headImageView)
        self.headImageView.snp_makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp_left)
            make.top.equalTo(self.contentView.snp_top).offset(LLJDX(20))
            make.width.equalTo(LLJDX(64))
            make.height.equalTo(LLJDX(64))
        }
        
        self.contentView.addSubview(self.name)
        self.name.snp_makeConstraints { (make) in
            make.left.equalTo(self.headImageView.snp_right).offset(15)
            make.top.equalTo(self.headImageView.snp_top).offset(LLJDX(10))
            make.height.equalTo(17)
        }
        
        self.contentView.addSubview(self.content)
        self.content.snp_makeConstraints { (make) in
            make.left.equalTo(self.name.snp_left)
            make.top.equalTo(self.name.snp_bottom).offset(LLJDX(12))
            make.height.equalTo(LLJDX(13))
        }
        
        self.contentView.addSubview(self.arrow)
        self.arrow.snp_makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp_right)
            make.centerY.equalTo(self.name.snp_centerY)
            make.height.equalTo(LLJDX(8))
            make.width.equalTo(LLJDX(4))
        }
        
        self.contentView.addSubview(self.arrowContent)
        self.arrowContent.snp_makeConstraints { (make) in
            make.right.equalTo(self.arrow.snp_left).offset(-3)
            make.centerY.equalTo(self.arrow.snp_centerY)
        }
        
        for i in stride(from: 0, to: dataSource.count, by: 1) {
            
            let W: CGFloat = (SCREEN_WIDTH - 45)/2.0
            let H: CGFloat = LLJDX(72)
            let model = dataSource[i]
            let subView = LLJWChatSubView()
            subView.frame = CGRect(x: CGFloat(i%2) * (W + 15), y: CGFloat((i/2))*(LLJDX(87)) + LLJDX(105), width: W, height: H)
            subView.setDataSource(title: model.title!, subTitle: model.subContent!)
            self.contentView.addSubview(subView)
        }
        
        self.name.text = "赞歌"
        self.content.text = "编辑个人资料"
        self.arrowContent.text = "主页"
    }
    
    func setDataSource() {
        
        var model1 = LLJWChatModel()
        model1.title = "账户"
        model1.subContent = "余额 43.52"
        
        var model2 = LLJWChatModel()
        model2.title = "免费无限卡"
        model2.subContent = "2 天"
        
        var model3 = LLJWChatModel()
        model3.title = "购物车"
        model3.subContent = "添加商品"
        
        var model4 = LLJWChatModel()
        model4.title = "订单"
        model4.subContent = "管理订单"
        
        dataSource.append(model1)
        dataSource.append(model2)
        dataSource.append(model3)
        dataSource.append(model4)
    }
}

extension LLJWChatFirstCell {
    
    override var frame:CGRect {
        didSet {
            var newFrame = frame
            newFrame.origin.x += 15
            newFrame.size.width -= 30
            super.frame = newFrame
        }
    }

}
