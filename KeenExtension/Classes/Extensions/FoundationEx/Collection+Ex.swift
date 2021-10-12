//
//  Collection+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/6/25.
//

import Foundation

//MARK: - 索引扩展 
extension Collection {
    
    /// 取出指定索引值 越界处理
    public subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
