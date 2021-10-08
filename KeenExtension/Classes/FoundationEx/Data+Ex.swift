//
//  Data+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/8/16.
//

import Foundation

extension Data {
    
    /// 图片类型
    public enum ImageType: Int {
        case unknow
        case jpg
        case png
        case gif
        case tiff
        case webp
        case heic
        case heif
    }
}

//MARK: - 基础功能
extension Data: KcPrefixWrapperCompatibleValue {}

extension KcPrefixWrapper where Base == Data {
    
    /// 获取图片类型
    /// - Returns: 具体的图片类型
    public func imageType() -> Data.ImageType  {
        var buffer = [UInt8](repeating: 0, count: 1)
        base.copyBytes(to: &buffer, count: 1)
        switch buffer {
        case [0xFF]: return .jpg
        case [0x89]: return .png
        case [0x47]: return .gif
        case [0x49], [0x4D]: return .tiff
        case [0x52] where base.count >= 12:
            if let str = String(
                data: base[0...11],
                encoding: .ascii
            ), str.hasPrefix("RIFF"), str.hasSuffix("WEBP") {
                return .webp
            }
        case [0x00] where base.count >= 12:
            if let str = String(
                data: base[8...11],
                encoding: .ascii
            ) {
                let maps = Set(["heic", "heis", "heix", "hevc", "hevx"])
                if maps.contains(str) {
                    return .heic
                }
                let bitmaps = Set(["mif1", "msf1"])
                if bitmaps.contains(str) {
                    return .heif
                }
            }
        default: break
        }
        return .unknow
    }
}
