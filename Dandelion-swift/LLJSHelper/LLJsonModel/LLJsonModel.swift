//
//  LLJsonModel.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/4/20.
//

import UIKit

class LLJsonModel {

    /*
     * 字典转模型
     * type: 模型类; value: 字典对象
     */
    class func toModel<T>(_ type: T.Type, value: Any) -> T? where T : Decodable {
        
        guard let data = try? JSONSerialization.data(withJSONObject: value) else { return nil }
        let decoder = JSONDecoder()
        decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+Infinity", negativeInfinity: "-Infinity", nan: "NaN")
        return try? decoder.decode(type, from: data)
    }
    
}
