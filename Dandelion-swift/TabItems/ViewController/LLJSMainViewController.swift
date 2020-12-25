//
//  LLJSMainViewController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2020/12/18.
//

import UIKit

class LLJSMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        let titleLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 20))
        titleLabel.text = "Swift"
        titleLabel.textColor = UIColor.black
        titleLabel.backgroundColor = UIColor.orange
        self.view.addSubview(titleLabel)
    }

}
