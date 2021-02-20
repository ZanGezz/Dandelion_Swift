//
//  LLJMainReq.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/2/20.
//

import Foundation
import Moya

enum  LLJMainReq {
    //首页列表
    case mainList
}

// 补全【MoyaConfig 3：配置TargetType协议可以一次性处理的参数】中没有处理的参数
extension LLJMainReq: TargetType {
    
    //1. 每个接口的相对路径
    //请求时的绝对路径是   baseURL + path
    var path: String {
        switch self {
        case .mainList:
            return ""
        }
    }

    //2. 每个接口要使用的请求方式
    var method: Moya.Method {
        switch self {
        case .mainList:
            return .post
        }
    }

    //3. Task是一个枚举值，根据后台需要的数据，选择不同的http task。
    var task: Task {
        switch self {
        case .mainList:
            return .requestPlain
        }
    }
}
