//
//  FileManager+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/7/28.
//

import Foundation

extension FileManager {
    
    /// 内容类型
    public enum ContentType: Int {
        case text
        case image
        case array
        case dictionary
    }
}

//MARK: - 文件路径
extension KcPrefixWrapper where Base: FileManager {
    
    /// Home 路径
    /// - Returns: 路径
    public static func homePath() -> String { NSHomeDirectory() }
    
    /// Documents 路径
    /// Core Data 默认的存储目录 不能存储网络资源 否则审核被拒 iCound 同步会备份 系统不会清理
    /// - Returns: 路径
    public static func documnetsPath() -> String { homePath() + "/Documents" }
    
    /// Library 路径
    /// - Returns: 路径
    public static func libraryPath() -> String { homePath() + "/Library" }
    
    /// /Library/Caches 路径
    /// 存储持久化的数据 iCound 同步不会备份 系统不会自动清理
    /// - Returns: 路径
    public static func cachesPath() -> String { homePath() + "/Library/Caches" }
    
    /// /Library/Preferences 路径
    /// 不应直接创建应用偏好设置文件
    /// - Returns: 路径
    public static func preferencesPath() -> String { homePath() + "/Library/Preferences" }
    
    /// Tmp 路径
    /// 存储临时文件 系统自动清理 重启会清空
    /// - Returns: 路径
    public static func tmpPath() -> String { homePath() + "/tmp" }
    
    /// 拼接到 documents 路径下
    /// - Parameter filePath: 拼接路径
    /// - Returns: 路径
    public static func joinDocumentsPath(to filePath: String) -> String {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory,
            .userDomainMask,
            true
        ).first
        return (path! as NSString).appendingPathComponent((filePath as NSString).lastPathComponent)
    }
    
    /// 拼接到 caches 路径下
    /// - Parameter filePath: 拼接路径
    /// - Returns: 路径
    public static func joinCachesPath(to filePath: String) -> String {
        let path = NSSearchPathForDirectoriesInDomains(
            .cachesDirectory,
            .userDomainMask,
            true
        ).last!
        return (path as NSString).appendingPathComponent((filePath as NSString).lastPathComponent)
    }
    
    /// 拼接到 tmp 路径下
    /// - Parameter filePath: 拼接路径
    /// - Returns: 路径字符串
    public static func joinTmpPath(to filePath: String) -> String {
        let path = NSTemporaryDirectory() as NSString
        return path.appendingPathComponent((filePath as NSString).lastPathComponent)
    }
}

//MARK: - 基础功能
extension KcPrefixWrapper where Base: FileManager {
    
    /// 文件管理
    public static var manager: FileManager { FileManager.default }
    
    /// 文件夹|文件是否存在
    /// - Parameter path: 文件路径
    /// - Returns: Bool 值
    public static func isExist(at path: String) -> Bool {
        return manager.fileExists(atPath: path)
    }
    
    /// 文件夹|文件是否可读
    /// - Parameter path: 路径
    /// - Returns: Bool 值
    public static func isReadable(at path: String) -> Bool {
        return manager.isReadableFile(atPath: path)
    }
    
    /// 文件夹|文件是否可写
    /// - Parameter path: 路径
    /// - Returns: Bool 值
    public static func isWritable(at path: String) -> Bool {
        return manager.isWritableFile(atPath: path)
    }
    
    /// 文件夹|文件是否可读可写
    /// - Parameter path: 路径
    /// - Returns: Bool 值
    public static func isExecutable(at path: String) -> Bool {
        return manager.isExecutableFile(atPath: path)
    }
    
    /// 文件夹|文件是否可删除
    /// - Parameter path: 路径
    /// - Returns: Bool 值
    public static func isDeletable(at path: String) -> Bool {
        return manager.isDeletableFile(atPath: path)
    }
    
    /// 前一个文件路径
    /// - Parameter path: 文件路径
    /// - Returns: 前一个文件路径
    public static func previousPath(at path: String) -> String {
        return (path as NSString).deletingLastPathComponent
    }
    
    /// 文件夹|文件属性
    /// - Parameter path: 路径
    /// - Returns: 属性集合
    @discardableResult
    public static func fileAttributes(at path: String) -> ([FileAttributeKey : Any]?) {
        do {
            return try manager.attributesOfItem(atPath: path)
        } catch _ {
            return nil
        }
    }
    
    /// 文件类型
    /// - Parameter filePath: 文件路径
    /// - Returns: 文件类型
    public static func fileType(at filePath: String) -> String {
        return (filePath as NSString).pathExtension
    }
    
    /// 文件名称
    /// - Parameters:
    ///   - filePath: 文件路径
    ///   - isExtension: 是否要后缀 默认 true
    /// - Returns: 文件名称
    public static func fileName(at filePath: String, isExtension: Bool = true) -> String {
        let fileName = (filePath as NSString).lastPathComponent
        guard isExtension else {
            return (fileName as NSString).deletingPathExtension
        }
        return fileName
    }
    
    /// 搜索文件夹下所有的子文件夹|子文件
    /// - Parameter folderPath: 文件夹
    /// - Returns: 子文件夹集合
    public static func folderSearchAll(at folderPath: String) -> Array<Any>? {
        guard isExist(at: folderPath),
              let arrs = manager.enumerator(atPath: folderPath) else {
            return nil
        }
        return arrs.allObjects
    }
    
    /// 搜索文件夹下的第一级子文件夹|子文件
    /// - Parameter folderPath: 文件夹
    /// - Returns: 子文件夹集合
    public static func folderSearch(at folderPath: String) -> Array<String>? {
        guard let arrs = try? manager.contentsOfDirectory(atPath: folderPath) else {
            return nil
        }
        return arrs
    }
    
    /// 单个文件夹|文件大小 返回字节 byte
    /// - Parameter filePath: 路径
    /// - Returns: 大小
    public static func singleFileSize(at path: String) -> UInt64 {
        guard isExist(at: path) else { return 0 }
        guard let attr = try? manager.attributesOfItem(atPath: path),
              let fileSize = attr[.size] as? UInt64 else {
            return 0
        }
        return fileSize
    }
    
    /// 文件夹|文件大小 返回字节 byte KB MB GB TB 等
    /// - Parameter filePath: 路径
    /// - Returns: 大小
    public static func fileSize(at path: String) -> String {
        guard isExist(at: path) else { return "0MB" }
        var fileSize: UInt64 = 0
        do {
            let files = try manager.contentsOfDirectory(atPath: path)
            for file in files {
                let filePath = path + "/\(file)"
                fileSize = fileSize + singleFileSize(at: filePath)
            }
        } catch {
            fileSize = fileSize + singleFileSize(at: path)
        }
        return calculateFileSize(size: fileSize)
    }
    
    /// 转换文件夹|文件大小
    /// - Parameter size: 大小
    /// - Returns: 大小
    private static func calculateFileSize(size: UInt64) -> String {
        var idx = 0
        var value: Double = Double(size)
        let values = ["bytes", "KB", "MB", "GB", "TB", "PB",  "EB",  "ZB", "YB"]
        while value > 1024 {
            value /= 1024
            idx += 1
        }
        return String(format: "%4.2f %@", value, values[idx])
    }
}

//MARK: - 常见功能
extension KcPrefixWrapper where Base: FileManager {
    
    /// 创建文件
    /// - Parameter filePath: 文件路径
    /// - Returns: Bool 值
    @discardableResult
    public static func createFile(at filePath: String) -> Bool {
        if isExist(at: filePath) { return true }
        return manager.createFile(atPath: filePath, contents: nil, attributes: nil)
    }
    
    /// 创建文件夹
    /// - Parameter folderPath: 文件夹名称
    /// - Returns: Bool 值
    @discardableResult
    public static func createFolder(at folderPath: String) -> Bool {
        if isExist(at: folderPath) { return true }
        do {
            try manager.createDirectory(
                atPath: folderPath,
                withIntermediateDirectories: true,
                attributes: nil
            )
            return true
        } catch _ {
            return false
        }
    }
    
    /// 删除文件
    /// - Parameter filePath: 文件路径
    @discardableResult
    public static func removefile(at filePath: String) -> Bool {
        guard isExist(at: filePath) else { return true }
        do {
            try manager.removeItem(atPath: filePath)
            return true
        } catch _ {
            return false
        }
    }
    
    /// 删除文件夹
    /// - Parameter folderPath: 文件夹路径
    @discardableResult
    public static func removefolder(at folderPath: String) -> Bool {
        guard isExist(at: folderPath) else { return true }
        do {
            try manager.removeItem(atPath: folderPath)
            return true
        } catch _ {
            return false
        }
    }
    
    /// 写内容到文件
    /// - Parameters:
    ///   - content: 写入的内容
    ///   - type: 内容类型
    ///   - filePath: 文件路径(附带文件后缀)
    /// - Returns: Bool 值
    @discardableResult
    public static func write(
        _ content: Any,
        type: FileManager.ContentType,
        filePath: String
    ) -> Bool {
        guard isExist(at: filePath) else { return false }
        switch type {
        case .text:
            let info = "\(content)"
            do {
                try info.write(
                    toFile: filePath,
                    atomically: true,
                    encoding: .utf8
                )
                return true
            } catch _ {
                return false
            }
        case .image:
            let data = content as! Data
            do {
                try data.write(to: URL(fileURLWithPath: filePath))
                return true
            } catch _ {
                return false
            }
        case .array:
            let array = content as! NSArray
            let result = array.write(toFile: filePath, atomically: true)
            if result {
                return true
            }else {
                return false
            }
        case .dictionary:
            let result = (content as! NSDictionary).write(toFile: filePath, atomically: true)
            if result {
                return true
            }else {
                return false
            }
        }
    }
    
    /// 读取内容
    /// - Parameters:
    ///   - type: 内容类型
    ///   - filePath: 文件路径
    /// - Returns: 元组(Bool 值, 读取的内容)
    @discardableResult
    public static func read(
        type: FileManager.ContentType,
        filePath: String
    ) -> (isSuccess: Bool, content: Any?) {
        guard isExist(at: filePath),
              let readHandler = FileHandle(forReadingAtPath: filePath) else {
            return (false, nil)
        }
        let data = readHandler.readDataToEndOfFile()
        switch type {
        case .text:
            let result = String(data: data, encoding: .utf8)
            return (true, result)
        case .image:
            return (true, data)
        case .array:
            guard let result = String(data: data, encoding: .utf8) else {
                return (false, nil)
            }
            return (true, result.kc.toJsons())
        case .dictionary:
            guard let result = String(data: data, encoding: .utf8) else {
                return (false, nil)
            }
            return (true, result.kc.toJson())
        }
    }
    
    /// 复制文件夹|文件
    /// - Parameters:
    ///   - originalPath: 来源路径
    ///   - destinationPath: 目的路径
    ///   - isFolder: 是否文件夹
    ///   - isOverlay: 是否覆盖 默认覆盖
    /// - Returns: Bool 值
    @discardableResult
    public static func copy(
        frome originalPath: String,
        to destinationPath: String,
        isFolder: Bool,
        isOverlay: Bool = true
    ) -> Bool {
        guard isExist(at: originalPath) else { return false }
        let previousFolderPath = previousPath(at: destinationPath)
        if !isExist(at: previousFolderPath) {
            var success: Bool = false
            if isFolder {
                success = createFolder(at: previousFolderPath)
            }else {
                success = createFile(at: destinationPath)
            }
            guard success else {
                return false
            }
        }
        /// 复制内容若存在则先删除 再复制
        if isOverlay, isExist(at: destinationPath) {
            do {
                try manager.removeItem(atPath: destinationPath)
            } catch _ {
                return false
            }
        }
        do {
            try manager.copyItem(atPath: originalPath, toPath: destinationPath)
        } catch _ {
            return false
        }
        return true
    }
    
    /// 移动文件夹|文件
    /// - Parameters:
    ///   - originalPath: 来源路径
    ///   - destinationPath: 目的路径
    ///   - isFolder: 是否为文件夹
    ///   - isOverlay: 是否覆盖 默认覆盖
    /// - Returns: Bool 值
    @discardableResult
    public static func move(
        frome originalPath: String,
        to destinationPath: String,
        isFolder: Bool,
        isOverlay: Bool = true
    ) -> Bool {
        guard isExist(at: originalPath) else { return false }
        let previousFolderPath = previousPath(at: destinationPath)
        if !isExist(at: previousFolderPath) {
            var success: Bool = false
            if isFolder {
                success = createFolder(at: previousFolderPath)
            }else {
                success = createFile(at: destinationPath)
            }
            guard success else {
                return false
            }
        }
        /// 复制内容若存在则先删除 再复制
        if isOverlay, isExist(at: destinationPath) {
            do {
                try manager.removeItem(atPath: destinationPath)
            } catch _ {
                return false
            }
        }
        do {
            try manager.moveItem(atPath: originalPath, toPath: destinationPath)
        } catch _ {
            return false
        }
        return true
    }
}
