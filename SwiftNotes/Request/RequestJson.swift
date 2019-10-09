//
//  RequestJson.swift
//  novelCartoon
//
//  Created by TonyReet on 2019/9/5.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import Foundation

extension Data {
    public func toModel<T:Codable>(modelType:T.Type) -> T? {
        do {
            return try JSONDecoder().decode(modelType, from: self)
        } catch {
            print(debug:error.localizedDescription)
            return  nil
        }
    }
    
    public func toDictionary() -> Dictionary<String,Any>? {
        if let dic = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) {
            if let result = dic as? Dictionary<String,Any>{
                return result
            }
        }
        return nil
    }
    public func toArray() -> Array<Any>? {
        if let arr = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) {
            if let result = arr as? Array<Any>{
                return result
            }
        }
        return nil
    }
    public func toString() -> String? {
        return String.init(data: self, encoding: .utf8)
    }
    
}

extension Array : ToDataProtocol {
    func toModel<T:Decodable>(modelType:T.Type) -> [T]? {
        if (!JSONSerialization.isValidJSONObject(self)) {
            print(debug:"is not a valid json object")
            return nil
        }
        
        guard let toData = self.toData() else{
            return nil
        }
        
        guard let modelarray = try? JSONDecoder().decode([T].self, from: toData) else {
            print("JSONDecoder数组转模型失败!")
            return nil
        }
        
        return modelarray
    }
}


extension Dictionary : ToDataProtocol {
    func toModel<T:Decodable>(modelType:T.Type) -> T? {
        if (!JSONSerialization.isValidJSONObject(self)) {
            print(debug:"is not a valid json object")
            return nil
        }

        guard let toData = self.toData() else{
            return nil
        }
        
        guard let model = try? JSONDecoder().decode(modelType, from: toData) else {
            print("JSONDecoder 字典转模型失败!")
            return nil
        }
        
        return model
    }
}

extension String {
    public func toData() -> Data? {
        if (!JSONSerialization.isValidJSONObject(self)) {
            return nil
        }
        return self.data(using: .utf8)
    }
}

protocol ToDataProtocol {
    func toData() -> Data?
}

extension ToDataProtocol {
    func toData() -> Data? {
        if JSONSerialization.isValidJSONObject(self) {
            if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
                return data
            }
        }
        return nil
    }
}
