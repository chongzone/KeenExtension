//
//  Log.swift
//  KeenExtension
//
//  Created by chongzone on 2020/12/19.
//

import Foundation

/// log 日志 利用 assert 特性 不再需外部配置
public func kclog(
    _ msg: Any...,
    file: NSString = #file,
    line: Int = #line,
    fn: String = #function
) {
    let logMsg = {
        var str: String = ""
        msg.forEach { str += "\($0)" + " " }
        let date = Date.kc.dateToString(Date())
        let fnPath = file.lastPathComponent.kc.split(".").first! + ":\(fn):\(line)"
        print(date, fnPath, str)
    }
    assert({ logMsg(); return true }(), "")
}
