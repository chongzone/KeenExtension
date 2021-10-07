//
//  NSObject+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/6/22.
//

import Foundation

extension NSObject: KcPrefixWrapperCompatible {}

//MARK: - 基础功能
extension KcPrefixWrapper where Base: NSObject {
    
    /// 类名
    public var className: String {
        let name = type(of: self.base).description()
        if name.contains(".") {
            return name.kc.split(".").last!
        }else {
            return name
        }
    }
    
    /// 类名
    public static var className: String {
        return String(describing: Base.self)
    }
}

//MARK: - 运行时
extension KcPrefixWrapper where Base: NSObject {
    
    /// 变量列表
    /// - Returns: 变量集合
    public static func ivarList() -> [String] {
        var count: UInt32 = 0
        var ivars = [String]()
        let lists = class_copyIvarList(Base.classForCoder(), &count)
        guard let ivarlists = lists else { return [] }
        for idx in 0..<Int(count) {
            let ivarPointer = ivar_getName(ivarlists[idx])
            let ivarName = String(cString: ivarPointer!, encoding: .utf8)
            ivars.append(ivarName ?? "")
        }
        free(ivarlists)
        return ivars
    }
    
    /// 属性列表
    /// - Returns: 属性集合
    public static func propertyList() -> [String] {
        var count: UInt32 = 0
        var propertys = [String]()
        let lists = class_copyPropertyList(Base.classForCoder(), &count)
        guard let propertylists = lists else { return [] }
        for idx in 0..<Int(count) {
            let property: objc_property_t = propertylists[idx]
            let propertyName = property_getName(property)
            propertys.append(String(cString: propertyName, encoding: .utf8) ?? "")
        }
        free(propertylists)
        return propertys
    }
    
    /// 方法列表
    /// - Returns: 方法集合
    public static func methodList() -> [Selector] {
        var count: UInt32 = 0
        var methods = [Selector]()
        let lists = class_copyMethodList(Base.classForCoder(), &count)
        guard let methodlists = lists else { return [] }
        for idx in 0..<numericCast(count) {
            let method = methodlists[idx]
            let selector = method_getName(method)
            methods.append(selector)
        }
        free(methodlists)
        return methods
    }
    
    /// 交换类方法
    /// - Parameters:
    ///   - originalSelector: 原始的方法
    ///   - replaceSelector: 交换的方法
    /// - Returns: Bool 值
    public static func exchangeClassMethod(
        of originalSelector: Selector,
        with replaceSelector: Selector
    ) -> Bool {
        let cls: AnyClass = Base.classForCoder()
        let origianlClassMethod = class_getClassMethod(cls, originalSelector)
        let replaceClassMethod = class_getClassMethod(cls, replaceSelector)
        guard let oriMethod = origianlClassMethod as Method? else {
            print("原始方法没找到")
            return false
        }
        guard let repMethod = replaceClassMethod as Method? else {
            print("交换的方法没找到")
            return false
        }
        let replaceImp = method_getImplementation(repMethod)
        let replaceTypes = method_getTypeEncoding(repMethod)
        let didAddMethod = class_addMethod(
            cls,
            originalSelector,
            replaceImp,
            replaceTypes
        )
        if didAddMethod {
            let originalImp = method_getImplementation(oriMethod)
            let originalTypes = method_getTypeEncoding(oriMethod)
            class_replaceMethod(cls, replaceSelector, originalImp, originalTypes)
        } else {
            method_exchangeImplementations(oriMethod, repMethod)
        }
        return true
    }
    
    /// 交换实例方法
    /// - Parameters:
    ///   - originalSelector: 原始方法
    ///   - replaceSelector: 交换的方法
    /// - Returns: Bool 值
    public static func exchangeInstanceMethod(
        of originalSelector: Selector,
        with replaceSelector: Selector
    ) -> Bool {
        let cls: AnyClass = Base.classForCoder()
        let origianlInstanceMethod = class_getInstanceMethod(cls, originalSelector)
        let replaceInstanceMethod = class_getInstanceMethod(cls, replaceSelector)
        guard let oriMethod = origianlInstanceMethod as Method? else {
            print("原始方法没找到")
            return false
        }
        guard let repMethod = replaceInstanceMethod as Method? else {
            print("交换的方法没找到")
            return false
        }
        let replaceImp = method_getImplementation(repMethod)
        let replaceTypes = method_getTypeEncoding(repMethod)
        let didAddMethod = class_addMethod(cls, originalSelector, replaceImp, replaceTypes)
        if didAddMethod {
            let originalImp = method_getImplementation(oriMethod)
            let originalTypes = method_getTypeEncoding(oriMethod)
            class_replaceMethod(cls, replaceSelector, originalImp, originalTypes)
        } else {
            method_exchangeImplementations(oriMethod, repMethod)
        }
        return true
    }
}
