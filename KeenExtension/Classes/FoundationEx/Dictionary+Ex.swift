//
//  Dictionary+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/6/25.
//

import Foundation

//MARK: - 索引扩展 
extension Dictionary {
    
    /// 键值 key 的读写
    public subscript<T>(key: Key) -> T? {
        get {
            return self[key] as? T
        }
        set {
            self[key] = newValue as? Value
        }
    }
    
    /// 根据 keys 集合取对应的 values 集合
    public subscript<Keys: Sequence>(keys: Keys) -> [Value] where Keys.Iterator.Element == Key {
        var values: [Value] = []
        keys.forEach { key in
            if let value = self[key] {
                values.append(value)
            }
        }
        return values
    }
}

//MARK: - 基础功能
extension Dictionary {
    
    /// 是否为空
    public var isEmpty: Bool { keys.count == 0 }
    
    /// 所有的 key 组成的新数组
    public func allKeys() -> [Key] { keys.shuffled() }
    
    /// 所有的 value 组成的新数组
    public func allValues() -> [Value] { values.shuffled() }
    
    /// 是否包含某个 key
    public func contains(_ key: Key) -> Bool { index(forKey: key) != nil }
    
    /// key & value 组成的的新数组
    public func toArray<T>(_ map: (Key, Value) -> T) -> [T] { self.map(map) }
    
    /// Json 解析为字符串
    public func toJson() -> String? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        let data = try? JSONSerialization.data(withJSONObject: self, options: [])
        guard let jsonData = data else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
}
