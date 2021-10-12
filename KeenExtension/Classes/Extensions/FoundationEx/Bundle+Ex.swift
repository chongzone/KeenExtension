//
//  Bundle+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/7/29.
//

import Foundation

extension Bundle {
    
    /// 常见的程序 App 信息
    fileprivate enum AppInfoPlist: String {
        /// 显示名称
        case displayName = "CFBundleDisplayName"
        /// 版本号(对内)
        case buildId = "CFBundleVersion"
        /// 版本号(对外)
        case version = "CFBundleShortVersionString"
        /// 标识符
        case identifier = "CFBundleIdentifier"
        /// 安装包的名称
        case executableName = "CFBundleExecutable"
        /// 安装包的类型
        case packageType = "CFBundlePackageType"
        /// 本地化相关
        case developmentRegion = "CFBundleDevelopmentRegion"
    }
}

//MARK: - 基础 App 信息
extension KcPrefixWrapper where Base: Bundle {
    
    /// app 显示名称
    public static var displayName: String? {
        guard let dic = Base.main.infoDictionary else {
            return nil
        }
        return dic[Base.AppInfoPlist.displayName.rawValue] as? String
    }
    
    /// app 版本号 对内
    public static var buildId: String? {
        guard let dic = Base.main.infoDictionary else {
            return nil
        }
        return dic[Base.AppInfoPlist.buildId.rawValue] as? String
    }
    
    /// app 版本号 对外
    public static var version: String? {
        guard let dic = Base.main.infoDictionary else {
            return nil
        }
        return dic[Base.AppInfoPlist.version.rawValue] as? String
    }
    
    /// app BundleID 标识符
    public static var identifier: String? {
        guard let dic = Base.main.infoDictionary else {
            return nil
        }
        return dic[Base.AppInfoPlist.identifier.rawValue] as? String
    }
    
    /// app 安装包的名称
    public static var executableName: String? {
        guard let dic = Base.main.infoDictionary else {
            return nil
        }
        return dic[Base.AppInfoPlist.executableName.rawValue] as? String
    }
    
    /// 包的类型 程序是 APPL 框架是 FMWK 可装载的是 BND
    public static var packageType: String? {
        guard let dic = Base.main.infoDictionary else {
            return nil
        }
        return dic[Base.AppInfoPlist.packageType.rawValue] as? String
    }
    
    /// 本地化相关
    public static var developmentRegion: String? {
        guard let dic = Base.main.infoDictionary else {
            return nil
        }
        return dic[Base.AppInfoPlist.developmentRegion.rawValue] as? String
    }
}
