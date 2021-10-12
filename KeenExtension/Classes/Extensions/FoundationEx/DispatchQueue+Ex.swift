//
//  DispatchQueue+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/8/18.
//

import Foundation

//MARK: - 基础功能
extension KcPrefixWrapper where Base: DispatchQueue {
    
    /// 异步延迟执行事件 & 可回到主线程执行另外事件 延迟默认 0s
    /// - Parameters:
    ///   - delay: 延迟时间
    ///   - subBlock: 子线程事件
    ///   - mainBlock: 主线程事件
    public static func async(
        _ delay: TimeInterval = 0,
        subBlock: @escaping () -> Void,
        mainBlock: (() -> Void)?
    ) {
        let item = DispatchWorkItem(block: subBlock)
        DispatchQueue.global().asyncAfter(
            deadline: .now() + delay,
            execute: subBlock
        )
        if let main = mainBlock {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
    }
}

