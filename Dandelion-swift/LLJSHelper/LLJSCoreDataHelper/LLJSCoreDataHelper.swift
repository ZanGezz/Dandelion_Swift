//
//  LLJSCoreDataHelper.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/1/20.
//

import UIKit
import CoreData

class LLJSCoreDataHelper: NSObject {
    
    var context: NSManagedObjectContext?
    
    //MARK:单例初始化
    static let helper = LLJSCoreDataHelper()

    //重写初始化
    override init() {
        super.init()
        //初始化CoreData数据库
        initCoreData()
    }
}

extension LLJSCoreDataHelper {
    //初始化CoreData数据库
    private func initCoreData() {
        //获取模型路径
        let coreDataUrl = Bundle.main.url(forResource: "LLJSCoreData", withExtension: "momd")
        //根据模型文件创建模型对象
        let model = NSManagedObjectModel.init(contentsOf: coreDataUrl!)
        //2、创建持久化存储助理：数据库
        //利用模型对象创建助理对象
        let store = NSPersistentStoreCoordinator.init(managedObjectModel: model!)
        //数据库的名称和路径
        let sqlPath = (LLJ_CoreData_Path() as NSString).appendingPathComponent("LLJSCoreData.sqlite")
        let sqlUrl  = URL(fileURLWithPath: sqlPath)
        
        //设置数据库相关信息 添加一个持久化存储库并设置存储类型和路径，NSSQLiteStoreType：SQLite作为存储库
        try! store.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: sqlUrl, options: nil)
        //3、创建上下文 保存信息 操作数据库
        let context = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        //关联持久化助理
        context.persistentStoreCoordinator = store
        self.context = context
    }
}
//coreData-增-删-改-查-
extension LLJSCoreDataHelper {
    /**
     * 根据实体名称创建存储数据model
     */
    func createCoreDataModel(entityName: String) -> AnyObject {
        return NSEntityDescription .insertNewObject(forEntityName: entityName, into: self.context!)
    }
    /**
     * 根据条件从本地取出一个数据模型model
     */
    func getModel(entityName: String, predicate: String) -> AnyObject {
        
        let array = self.getRosource(entityName: entityName, predicate: predicate)
        return array.first as AnyObject
    }
    /**
     * 增 * 根据模型名称和查询条件插入数据 *
     */
    func insertRosource() -> Bool {
        
        do {
            try self.context?.save()
        } catch {
            LLJLog("coreDataSaveError")
            return false
        }
        return true
    }
    /**
     * 删 * 根据模型名称和查询条件删除数据 *
     */
    func deleteRosource(entityName: String, predicate: String) -> Bool {
        
        let array = self.getRosource(entityName: entityName, predicate: predicate)
        for object in array {
            self.context?.delete(object as! NSManagedObject)
        }
        do {
            try self.context?.save()
        } catch {
            LLJLog("coreDataSaveError")
            return false
        }
        return true
    }
    /**
     * 改 * 根据模型名称和查询条件修改数据 *
     */
    func updateRosource() -> Bool {
        do {
            try self.context?.save()
        } catch {
            LLJLog("coreDataSaveError")
            return false
        }
        return true
    }
    /**
     * 查 * 根据模型名称和查询条件查询数据 *
     */
    func getRosource(entityName: String, predicate: String) -> Array<Any> {
        let req = NSFetchRequest<NSFetchRequestResult>.init(entityName: entityName)
        if predicate.count > 0 {
            req.predicate = NSPredicate.init(format: predicate)
        }
        let array = try! self.context!.fetch(req)
        return array
    }
}
