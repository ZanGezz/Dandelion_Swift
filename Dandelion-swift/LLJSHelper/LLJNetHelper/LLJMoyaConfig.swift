//
//  LLJMoyaConfig.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/2/19.
//

import Foundation
import Moya


//baseURL
let baseUrl: String = "https://www.baidu.com"

/**
 * 配置TargetType协议可以一次性处理的参数
 */
public extension TargetType {
    //配置baseURL
    var baseURL: URL {
        return URL(string: baseUrl)!
    }

    var headers: [String : String]? {
        return nil
    }

    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
}

/**
   2.公共参数
 - 配置公共参数，例如所有接口都需要传token，version，time等，就可以在这里统一处理
 - Note: 接口传参时可以覆盖公共参数。下面的代码只需要更改 【private var commonParams: [String: Any]?】
 */
extension URLRequest {
    //TODO：处理公共参数
    private var commonParams: [String: Any]? {
        //所有接口的公共参数添加在这里例如：
        //        return ["token": "",
        //                "version": "ios 1.0.0"
        //        ]
        return nil
    }
}

//下面的代码不更改
class RequestHandlingPlugin: PluginType {
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var mutateableRequest = request
        return mutateableRequest.appendCommonParams();
    }
}

//下面的代码不更改
extension URLRequest {
    mutating func appendCommonParams() -> URLRequest {
        let request = try? encoded(parameters: commonParams, parameterEncoding: URLEncoding(destination: .queryString))
        assert(request != nil, "append common params failed, please check common params value")
        return request!
    }

    func encoded(parameters: [String: Any]?, parameterEncoding: ParameterEncoding) throws -> URLRequest {
        do {
            return try parameterEncoding.encode(self, with: parameters)
        } catch {
            throw MoyaError.parameterEncoding(error)
        }
    }
}
