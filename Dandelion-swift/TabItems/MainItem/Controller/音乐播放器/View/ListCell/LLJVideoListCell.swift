//
//  LLJVideoListCell.swift
//  Dandelion-swift
//
//  Created by liushuai on 2023/8/1.
//

import UIKit

class LLJVideoListCell: UITableViewCell {
    // 懒加载属性
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 设置UI
        setUpUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// 设置UI
extension LLJVideoListCell {
    // 设置UI
    private func setUpUI() {
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp_makeConstraints { make in
            make.left.equalTo(self.contentView.snp_left)
            make.centerY.equalTo(self.contentView.snp_centerY)
        }
    }
    // 设置数据
    func setDataSource(title: String = "") {
        self.titleLabel.text = title;
    }
}
