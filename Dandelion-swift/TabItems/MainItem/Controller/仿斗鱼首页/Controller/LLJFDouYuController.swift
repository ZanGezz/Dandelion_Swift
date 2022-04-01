//
//  LLJFDouYuController.swift
//  Dandelion-swift
//
//  Created by liushuai on 2021/12/27.
//

import UIKit

class LLJFDouYuController: LLJFViewController {
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: LLJTopHeight, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - LLJTopHeight), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "kkk")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        //UI
        setUpUI()
    }
}

//MARK: - 代理 -
extension LLJFDouYuController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

//MARK: - UI -
extension LLJFDouYuController {
    //UI
    private func setUpUI() {
        
        self.view.backgroundColor = UIColor.white
        
    }
}
