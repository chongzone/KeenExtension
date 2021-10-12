//
//  Array+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/6/22.
//

import Foundation

//MARK: - 基础功能
extension Array  {
    
    /// 添加元素
    /// - Parameter elements: 新元素数组
    public mutating func append(_ elements: [Element]) {
        elements.forEach{ self.append($0) }
    }
    
    /// 解析为字符串
    public func toJson() -> String? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        let data = try? JSONSerialization.data(withJSONObject: self, options: [])
        guard let jsonData = data else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
}
