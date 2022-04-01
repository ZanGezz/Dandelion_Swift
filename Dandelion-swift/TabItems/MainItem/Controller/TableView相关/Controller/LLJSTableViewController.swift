//
//  LLJSTableViewController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/2/2.
//

import UIKit

enum LLJCellEditType {
    case delete
    case edit
    case other
}

class LLJSTableViewController: LLJFViewController {

    //数据数组
    lazy var sourceArray:  Array<Any>? = {
        let sourceArray = LLJSCoreDataHelper.helper.getRosource(entityName: "LLJSCommenModel", predicate: "name = 'ZanGezz'")
        return sourceArray
    }()
    
    var editType: LLJCellEditType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setUpUI()
    }
}

//MARK:基础设置
extension LLJSTableViewController {
    
    //设置UI
    func setUpUI() {
        
        //tableview
        self.myTableView.register(LLJSMainCell.self, forCellReuseIdentifier: "MainCell")
        self.myTableView.frame = CGRect(x: 0, y: LLJTopHeight, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - LLJTopHeight)
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.view.addSubview(self.myTableView)
        
        //排序按钮
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setTitleColor(LLJWhiteColor(), for: UIControl.State.normal)
        button.setTitle("排序", for: UIControl.State.normal)
        button.titleLabel!.font = LLJFont(16)
        button.addTarget(self, action: #selector(buttonClick(sender:)), for: UIControl.Event.touchUpInside)
        let right = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = right
    }
    
    //objc 方法 - 排序
    @objc func buttonClick(sender: UIButton) {
        if (!sender.isSelected) {
            self.myTableView.isEditing = true;
        }else{
            self.myTableView.isEditing = false;
        }
        sender.isSelected = !sender.isSelected
        self.myTableView.reloadData();
    }
}

//MARK:TableView代理
extension LLJSTableViewController: UITableViewDelegate,UITableViewDataSource {
    
    //代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourceArray!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LLJDX(60)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell") as! LLJSMainCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let model = self.sourceArray![indexPath.row] as! LLJSCommenModel
        cell.setDataSource(model.name! + "  " + model.sex! + "  " + model.age!)
        cell.setIndictorHidden(true)
        return cell
    }
}

//MARK:TableView排序
extension LLJSTableViewController {
    
    
    //MARK:TableView排序
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    //Cell是否允许移动
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // 移动cell之后更换数据数组里的循序
        if (sourceIndexPath.row > destinationIndexPath.row) {
            var i = sourceIndexPath.row
            while (i > destinationIndexPath.row) {
                self.sourceArray!.swapAt(i, destinationIndexPath.row)
                i -= 1
            }
        }else if (sourceIndexPath.row < destinationIndexPath.row){
            var i = sourceIndexPath.row
            while (i < destinationIndexPath.row) {
                self.sourceArray!.swapAt(i, destinationIndexPath.row)
                i += 1
            }
        }
    }
    
    //MARK:左滑删除编辑功能
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return self.getTableViewRowActions()
    }
    
    //获取 UITableViewRowAction
    private func getTableViewRowActions() -> [UITableViewRowAction]? {
        var array = [UITableViewRowAction]()
        let num = LLJSHelper .arc4random(duration: 2)
        if (num == 0) {
            array.append(self.createTableViewRowAction(title: "删除", type: LLJCellEditType.delete)!)
        } else if (num == 1) {
            array.append(self.createTableViewRowAction(title: "删除", type: LLJCellEditType.delete)!)
            array.append(self.createTableViewRowAction(title: "编辑", type: LLJCellEditType.edit)!)
        }
        return array
    }
    
    private func createTableViewRowAction(title: String, type: LLJCellEditType) -> UITableViewRowAction? {
        let rowAction = UITableViewRowAction(style: UITableViewRowAction.Style.normal, title: title) { [self] (rowAction, indexPath) in
            actionClick(type: type, model: self.sourceArray![indexPath.row] as! LLJSCommenModel, indexPath: indexPath)
        }
        return rowAction
    }
    
    private func actionClick(type: LLJCellEditType, model: LLJSCommenModel, indexPath: IndexPath) {
        
        switch type {
        
            case .delete:
                
                let sucess = LLJSCoreDataHelper().deleteRosource(entityName: "LLJSCommenModel", predicate: "age = " + model.age!)
                if sucess {
                    self.sourceArray?.remove(at: indexPath.row)
                    self.myTableView.reloadData()
                }
                
                break
            case   .edit:
                
                LLJLog("edit")

                break
            default:
                break
        }
    }
}
