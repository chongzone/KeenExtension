//
//  KcPrefixWrapper.swift
//  KeenExtension
//
//  Created by chongzone on 2020/6/15.
//

import Foundation

/// 扩展命名空间
public struct KcPrefixWrapper<Base> {
    
    public let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
}

/// 对象类型
public protocol KcPrefixWrapperCompatible: AnyObject {}

/// 任意类型
public protocol KcPrefixWrapperCompatibleValue {}

extension KcPrefixWrapperCompatible {
    
    public var kc: KcPrefixWrapper<Self> {
        get { return KcPrefixWrapper(self) }
        set { }
    }
    
    public static var kc: KcPrefixWrapper<Self>.Type {
        get { return KcPrefixWrapper<Self>.self }
        set { }
    }
}

extension KcPrefixWrapperCompatibleValue {
    
    public var kc: KcPrefixWrapper<Self> {
        get { return KcPrefixWrapper(self) }
        set { }
    }
    
    public static var kc: KcPrefixWrapper<Self>.Type {
        get { return KcPrefixWrapper<Self>.self }
        set { }
    }
}
