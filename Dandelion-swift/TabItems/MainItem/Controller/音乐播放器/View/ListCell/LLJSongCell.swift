//
//  LLJSongCell.swift
//  Dandelion-swift
//
//  Created by liushuai on 2023/8/31.
//

import UIKit

class LLJSongCell: UITableViewCell {

    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = LLJFont(16)
        return label
    }()
    
    lazy var coverLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = LLJFont(16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LLJSongCell {
    
    private func setUpUI() {
        self.contentLabel.frame = CGRect(16, 15, SCREEN_WIDTH-32, 20)
        self.contentView.addSubview(self.contentLabel)
        
        self.coverLabel.frame = CGRect(16, 15, 100, 20)
        self.contentView.addSubview(self.coverLabel)
    }
    
    func setDataSource(content: String) {
        self.contentLabel.text = content
        self.coverLabel.text = content
    }
}
