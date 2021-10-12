//
//  UserDefaults+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/7/23.
//

import UIKit

//MARK: - 系统对象增删改查
/**
 * UserDefaults 类:  存储轻量级的本地数据 其最终数据保存到 .plist 文件
 * 不建议存储大文件(程序启动自动加载 UserDefaults 存储的所有数据 若文件太大就会造成启动缓慢 影响性能)
 * 1. 系统对象: 通过 archivedData 转换成 Data 进行存储
 * 2. 自定义对象: 该对象需遵守 Codable 协议进行归档和反归档再进行存储
 */
extension KcPrefixWrapper where Base: UserDefaults {
    
    /// 存值
    /// - Parameters:
    ///   - value: 存储的值
    ///   - key: 键值
    /// - Returns: Bool 值
    @discardableResult
    public static func set(_ value: Any?, key: String) -> Bool {
        assert(value != nil, "value 不能为空")
        if value is UIImage {
            let img = value as! UIImage
            let image = UIImage(
                cgImage: img.cgImage!,
                scale: img.scale,
                orientation: img.imageOrientation
            )
            let data = NSKeyedArchiver.archivedData(withRootObject: image)
            Base.standard.set(data, forKey: key)
        }else {
            Base.standard.set(value, forKey: key)
        }
        /// 参考官方注释 存储已经不需这个 API 未来也会被弃用
//        Base.standard.synchronize()
        return true
    }
    
    /// 取值
    /// - Parameter key: 键值
    /// - Returns: 值
    public static func get(key: String) -> Any? {
        guard let value = Base.standard.object(forKey: key) else { return nil }
        return value
    }
    
    /// 取出当前存储的所有数据
    /// - Returns: 数据
    public static func getAll() -> [String : Any] {
        return Base.standard.dictionaryRepresentation()
    }
    
    /// 删值 对象不存在不会报错
    /// - Parameter key: 键值
    public static func remove(key: String) {
        Base.standard.removeObject(forKey: key)
    }
    
    /// 删除所有的值
    public static func removeAll() {
        if let appDomain = Bundle.main.bundleIdentifier {
            Base.standard.removePersistentDomain(forName: appDomain)
        }
    }
    
    /// 重置
    public static func reset() {
        Base.resetStandardUserDefaults()
    }
}

//MARK: - 自定义对象存取
extension KcPrefixWrapper where Base: UserDefaults {
    
    /// 存自定义对象
    /// - Parameters:
    ///   - value: 自定义对象
    ///   - key: 键值
    public static func set<T>(_ value: T, key: String) where T: Codable {
        guard let encoded = try? JSONEncoder().encode(value) else {
            return
        }
        Base.standard.set(encoded, forKey: key)
    }
    
    /// 取出自定义对象
    /// - Parameters:
    ///   - type: 自定义对象类型
    ///   - key: 键值
    /// - Returns: 自定义对象
    public func get<T>(_ type: T.Type, key: String) -> T? where T: Codable {
        guard let data = Base.standard.data(forKey: key) else { return nil }
        guard let value = try? JSONDecoder().decode(type, from: data) else {
            return nil
        }
        return value
    }
}

