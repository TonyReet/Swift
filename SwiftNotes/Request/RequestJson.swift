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
    func toModel<T:Codable>(modelType:T.Type) -> [T]? {
        if (!JSONSerialization.isValidJSONObject(self)) {
            print(debug:"is not a valid json object")
            return nil
        }
        
        guard let toData = self.toData() else{
            return nil
        }
        
        var modelArray:[T] = []
        for index in 0...self.count {
            do {
                let model = self[index]
                let testData = try JSONDecoder().decode(modelType, from: model as! Data)
                print(debug: testData)
                modelArray.append(try JSONDecoder().decode(modelType, from: toData))
            } catch {
                print(debug:error.localizedDescription)
            }
        }

        return modelArray
    }
}


extension Dictionary : ToDataProtocol {
    func toModel<T:Codable>(modelType:T.Type) -> T? {
        if (!JSONSerialization.isValidJSONObject(self)) {
            print(debug:"is not a valid json object")
            return nil
        }
        
        guard let toData = self.toData() else{
            return nil
        }
        
        do {
            return try JSONDecoder().decode(modelType, from: toData)
        } catch {
            print(debug:error.localizedDescription)
            return  nil
        }
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
