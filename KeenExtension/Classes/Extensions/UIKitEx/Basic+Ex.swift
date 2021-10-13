//
//  Basic+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/6/15.
//

import UIKit

//MARK: - UIWindow 扩展
extension KcPrefixWrapper where Base: UIWindow {
    
    /// 屏幕宽度
    public var window_width: CGFloat {
        let orientation = UIDevice.current.orientation
        switch orientation {
        case .landscapeLeft, .landscapeRight:
            return max(base.kc.width, base.kc.height)
        case .portrait, .portraitUpsideDown:
            return min(base.kc.width, base.kc.height)
        default:
            return base.kc.width
        }
    }
    
    /// 屏幕高度
    public var window_height: CGFloat {
        let orientation = UIDevice.current.orientation
        switch orientation {
        case .landscapeLeft, .landscapeRight:
            return min(base.kc.width, base.kc.height)
        case .portrait, .portraitUpsideDown:
            return max(base.kc.width, base.kc.height)
        default:
            return base.kc.height
        }
    }
}

//MARK: - CGPoint 扩展
extension CGPoint: KcPrefixWrapperCompatibleValue {}

extension KcPrefixWrapper where Base == CGPoint {
    
    /// 两点间的中心 X
    public func midX(_ pointX: CGFloat) -> CGFloat { (base.x + pointX) * 0.5 }
    /// 两点间的中心 Y
    public func midY(_ pointY: CGFloat) -> CGFloat { (base.y + pointY) * 0.5 }
    /// 两点间的中心 Point
    public func mid(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: midX(point.x), y: midY(point.y))
    }
}

//MARK: - UIEdgeInsets 扩展
extension UIEdgeInsets {
    
    /// 初始化
    /// - Parameters:
    ///   - tb: 上下边距
    ///   - lr: 左右边距
    public init(tb: (CGFloat, CGFloat), lr: (CGFloat, CGFloat)) {
        self.init(top: tb.0, left: lr.0, bottom: tb.1, right: lr.1)
    }
}

//MARK: - NSNumber 扩展
extension KcPrefixWrapper where Base: NSNumber {
    
    /// 转 Bool
    public var toBool: Bool { base.boolValue }
    /// 转 Int
    public var toInt: Int { base.intValue }
    /// 转 Double
    public var toDouble: Double { base.doubleValue }
    /// 转 Float
    public var toFloat: Float { base.floatValue }
    /// 转 CGFloat
    public var toCGFloat: CGFloat { CGFloat(base.floatValue) }
    /// 转字符串
    public var toString: String { base.stringValue }
    /// 是否为偶数
    public var isEvenNum: Bool { base.int64Value % 2 == 0 }
    /// 是否 Null
    public var isNaN: Bool { toDouble.isNaN }
}

//MARK: - NSDecimalNumber 扩展
extension KcPrefixWrapper where Base: NSDecimalNumber {
    
    /// 数字字符串的小数位处理 默认四舍五入
    /// - Parameters:
    ///   - aString: 数字字符串
    ///   - decimal: 小数位
    ///   - isRound: 是否四舍五入
    ///   1. plain(四舍五入) | down(向下取整) | up(向上取整)
    /// - Returns: DecimalNumber
    public static func decimalNumber(
        _ aString: String,
        decimal: Int,
        isRound: Bool = true
    ) -> NSDecimalNumber {
        let number = NSDecimalNumber(string: aString)
        let numberHandler = NSDecimalNumberHandler(
            roundingMode: isRound ? .plain : (number.compare(NSDecimalNumber.zero) != ComparisonResult.orderedAscending ? .down : .up),
            scale: Int16(decimal),
            raiseOnExactness: false,
            raiseOnOverflow: false,
            raiseOnUnderflow: false,
            raiseOnDivideByZero: true
        )
        return number.rounding(accordingToBehavior: numberHandler)
    }
}

//MARK: - Bool 扩展
extension Bool: KcPrefixWrapperCompatibleValue {}

extension KcPrefixWrapper where Base == Bool {
    
    /// 转 Int
    public var toInt: Int { base ? 1 : 0 }
    /// 转 Number
    public var toNumber: NSNumber { NSNumber(value: base) }
}

//MARK: - Int 扩展
extension Int: KcPrefixWrapperCompatibleValue {}

extension KcPrefixWrapper where Base == Int {
    
    /// 转 Bool
    public var toBool: Bool { base == 0 ? false : true }
    /// 转 Double
    public var toDouble: Double { Double(base) }
    /// 转 Float
    public var toFloat: Float { Float(base) }
    /// 转 CGFloat
    public var toCGFloat: CGFloat { CGFloat(base) }
    /// 转 Number
    public var toNumber: NSNumber { NSNumber(value: base) }
    /// 转字符串
    public var toString: String { String(base) }
    /// 是否为偶数
    public var isEvenNum: Bool { base % 2 == 0 }
    /// 十六进制整型转十六进制字符串
    public var toHexString: String { String(base, radix: 16, uppercase: true) }
}

//MARK: - Double 扩展
extension Double: KcPrefixWrapperCompatibleValue {}

extension KcPrefixWrapper where Base == Double {
    
    /// 转 Int
    public var toInt: Int { Int(base) }
    /// 转 Float
    public var toFloat: Float { Float(base) }
    /// 转 CGFloat
    public var toCGFloat: CGFloat { CGFloat(base) }
    /// 转 Number
    public var toNumber: NSNumber { NSNumber(value: base) }
    /// 转字符串
    public var toString: String { String(base) }
    /// 是否为偶数
    public var isEvenNum: Bool { base.truncatingRemainder(dividingBy: 2.0) == 0 }
    /// 取余
    public func remainder(by value: Double) -> Double {
        return base.truncatingRemainder(dividingBy: value)
    }
    /// 取中心点
    public func mid(_ value: Double) -> Double { (base + value) * 0.5 }
}

//MARK: - Double 扩展
extension Float: KcPrefixWrapperCompatibleValue {}

extension KcPrefixWrapper where Base == Float {
    
    /// 转 Int
    public var toInt: Int { Int(base) }
    /// 转 Double
    public var toDouble: Double { Double(base) }
    /// 转 CGFloat
    public var toCGFloat: CGFloat { CGFloat(base) }
    /// 转 Number
    public var toNumber: NSNumber { NSNumber(value: base) }
    /// 转字符串
    public var toString: String { String(base) }
    /// 是否为偶数
    public var isEvenNum: Bool { base.truncatingRemainder(dividingBy: 2.0) == 0 }
    /// 取余
    public func remainder(by value: Float) -> Float {
        return base.truncatingRemainder(dividingBy: value)
    }
    /// 取中心点
    public func mid(_ value: Float) -> Float { (base + value) * 0.5 }
}

//MARK: - CGFloat 扩展
extension CGFloat: KcPrefixWrapperCompatibleValue {}

extension KcPrefixWrapper where Base == CGFloat {
    
    /// 转 Int
    public var toInt: Int { Int(base) }
    /// 转 Float
    public var toFloat: Float { Float(base) }
    /// 转 Double
    public var toDouble: Double { Double(base) }
    /// 转 Number
    public var toNumber: NSNumber { NSNumber(value: base.kc.toDouble) }
    /// 转字符串
    public var toString: String { String(base.kc.toDouble) }
    /// 角度转弧度 角度范围(0-360)
    public var toRadians: CGFloat { (.pi * base) / 180.0 }
    /// 弧度转角度 弧度范围(0-2π)
    public var toAngle: CGFloat { (base * 180.0) / .pi }
    /// 是否为偶数
    public var isEvenNum: Bool { base.truncatingRemainder(dividingBy: 2.0) == 0 }
    /// 取余
    public func remainder(by value: CGFloat) -> CGFloat {
        return base.truncatingRemainder(dividingBy: value)
    }
    /// 取中心点
    public func mid(_ value: CGFloat) -> CGFloat { (base + value) * 0.5 }
}

//MARK: - 视觉大小适配
extension CGFloat {
    
    /// 1 像素的线宽
    public static var onePixel: CGFloat { 1 / UIScreen.main.scale }
    /// 1 像素的线宽偏移量
    /// 对于奇数像素的宽度, 若线落在行|列的中间, 则会得到 2 个像素宽的线
    /// 对于偶数像素的线因其会在其行|列内则不存在线宽偏移量
    public static var onePixelOffset: CGFloat { 1 / UIScreen.main.scale / 2 }
    
    /// 状态栏宽度
    public static var statusBarWidth: CGFloat {
        if #available(iOS 13.0, *) {
            let window: UIWindow? = UIApplication.shared.windows.first
            return (window?.windowScene?.statusBarManager?.statusBarFrame.width)!
        }else {
            return UIApplication.shared.statusBarFrame.width
        }
    }
    /// 状态栏高度
    public static var statusBarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            let window: UIWindow? = UIApplication.shared.windows.first
            return (window?.windowScene?.statusBarManager?.statusBarFrame.height)!
        }else {
            return UIApplication.shared.statusBarFrame.height
        }
    }
    /// 状态栏大小
    public static var statusBarSize: CGSize {
        return CGSize(width: statusBarWidth, height: statusBarHeight)
    }
    
    /// 屏幕比
    public static var screenScale: CGFloat { UIScreen.main.scale }
    /// 屏幕宽度
    public static var screenWidth: CGFloat { UIScreen.main.bounds.size.width }
    /// 屏幕高度
    public static var screenHeight: CGFloat { UIScreen.main.bounds.size.height }
    /// 屏幕最小宽度
    public static var screenMinWidth: CGFloat { Swift.min(screenWidth, screenHeight) }
    /// 屏幕最大高度
    public static var screenMaxHeight: CGFloat { Swift.max(screenWidth, screenHeight) }
    
    /// 安全区域导航栏高度
    public static var safeAreaNavBarHeight: CGFloat { statusBarHeight + 44.0 }
    /// 安全区域顶部高度
    public static var safeAreaTopHeight: CGFloat { UIDevice.kc.isIPhoneXSeries ? 24.0 : 0.0 }
    /// 安全区域底部高度
    public static var safeAreaBottomHeight: CGFloat { UIDevice.kc.isIPhoneXSeries ? 34.0 : 0.0 }
    /// 安全区域 tabbar 高度
    public static var safeAreaTabbarHeight: CGFloat { UIDevice.kc.isIPhoneXSeries ? 83.0 : 49.0 }
    
    /// 适配给定的尺寸 其中设计稿的尺寸默认 750px 宽度
    /// - Parameters:
    ///   - length: 给定的尺寸 单位 px
    ///   - designWidth: 设计稿的尺寸 默认 750px
    /// - Returns: 转换的尺寸
    public static func toDesign(
        _ length: CGFloat,
        designWidth: CGFloat = 750
    ) -> CGFloat {
        return UIScreen.main.bounds.size.width * length / designWidth
    }
    
    /// View 圆角 默认 12pt
    public static var viewRadius: CGFloat {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedViewRadius
            ) as? CGFloat ?? .toDesign(24)
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedViewRadius,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// 按钮圆角 默认 2 pt
    public static var buttonRadius: CGFloat {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedButtonRadius
            ) as? CGFloat ?? .toDesign(4)
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedButtonRadius,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// 按钮高度 默认 45pt
    public static var buttonHeight: CGFloat {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedButtonHeight
            ) as? CGFloat ?? .toDesign(90)
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedButtonHeight,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    private struct AssociatedKey {
        static var associatedViewRadius: Void?
        static var associatedButtonRadius: Void?
        static var associatedButtonHeight: Void?
    }
}
