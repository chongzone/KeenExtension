//
//  UIColor+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/6/15.
//

import UIKit

//MARK: - 初始化
extension UIColor {
    
    /// 初始化
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    /// 初始化
    public convenience init(hexValue: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hexValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// 初始化
    public convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var hex = hexString.kc.trim().lowercased()
        if hex.hasPrefix("#") {
            hex = "\(hex.dropFirst())"
        }
        if hex.hasPrefix("0x") {
            hex = "\(hexString.dropFirst(2))"
        }
        var hexValue: UInt64 = 0
        let scanner: Scanner = Scanner(string: hexString)
        scanner.scanHexInt64(&hexValue)
        let red = CGFloat(Int(hexValue >> 16) & 0x0000FF) / 255.0
        let green = CGFloat(Int(hexValue >> 8) & 0x0000FF) / 255.0
        let blue = CGFloat(Int(hexValue) & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// 初始化
    public convenience init(image: UIImage, alpha: CGFloat = 1.0) {
        let tuple = UIColor.self.kc.color(image: image)
        self.init(
            red: tuple.kc.toRGB().red,
            green: tuple.kc.toRGB().green,
            blue: tuple.kc.toRGB().blue,
            alpha: alpha
        )
    }
}

//MARK: - 基础功能
extension KcPrefixWrapper where Base: UIColor {
    
    /// 转 rgb 数据
    public func toRGB() -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0;
        base.getRed(&r, green: &g, blue: &b, alpha: nil)
        return (CGFloat(r * 255.0), CGFloat(g * 255.0), CGFloat(b * 255.0))
    }
    
    /// 转 十六进制字符串 默认字符串大写
    /// - Parameter isUpper: 是否字母大写
    /// - Returns: 十六进制字符串
    public func toHexString(_ isUpper: Bool = true) -> String? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0;
        guard base.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        let ratio = CGFloat(255.999999)
        if alpha == 1.0 {
            return String(
                format: isUpper ? "#%02lX%02lX%02lX" : "#%02lx%02lx%02lx",
                Int(red*ratio),
                Int(green*ratio),
                Int(blue*ratio)
            )
        }else {
            return String(
                format: isUpper ? "#%02lX%02lX%02lX" : "#%02lx%02lx%02lx%02lx",
                Int(red*ratio),
                Int(green*ratio),
                Int(blue*ratio),
                Int(alpha*ratio)
            )
        }
    }
    
    /// 改变透明度 不会影响子视图透明度
    /// - Parameter alpha: 透明度
    /// - Returns: 对应的 Color
    public func toColor(of alpha: CGFloat) -> UIColor {
        return base.withAlphaComponent(alpha)
    }
    
    /// 由 Color 转渐变的 rgb 数据
    /// - Parameters:
    ///   - lhs: 第一个 Color
    ///   - rhs: 第二个 Color
    /// - Returns: 渐变的 rgb
    public static func toGradientRGB(
        lhs: UIColor,
        rhs: UIColor
    ) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        return (lhs.kc.toRGB().red - rhs.kc.toRGB().red,
                lhs.kc.toRGB().green - rhs.kc.toRGB().green,
                lhs.kc.toRGB().blue - rhs.kc.toRGB().blue)
    }
    
    /// 由 rgb 转渐变的 rgb 数据
    /// - Parameters:
    ///   - lhs:  第一个 rgb
    ///   - rhs: 第二个 rgb
    /// - Returns: 渐变的 rgb
    public static func toGradientRGB(
        lhs: (CGFloat, CGFloat, CGFloat),
        rhs: (CGFloat, CGFloat, CGFloat)
    ) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        return (lhs.0 - rhs.0, lhs.1 - rhs.1, lhs.2 - rhs.2)
    }
}

//MARK: - 常见功能
extension KcPrefixWrapper where Base: UIColor {
    
    /// Color 对应的反色
    /// - Returns: 对应的反色 Color
    public func reversed() -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0;
        guard base.getRed(&red, green: &green, blue: &blue, alpha: nil) else {
            return nil
        }
        return UIColor(red:1.0-red, green: 1.0-green, blue: 1.0-blue, alpha: 1)
    }
    
    /// 由 RGBA 生成 Color 透明度默认 1.0
    /// - Parameters:
    ///   - r: 红色
    ///   - g: 绿色
    ///   - b: 蓝色
    ///   - a: 透明度
    /// - Returns: 对应的 Color
    public static func color(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    /// 由图片生成 Color
    /// - Parameter image: 图片
    /// - Returns: 对应的 Color
    public static func color(image: UIImage) -> UIColor {
        return UIColor(patternImage: image)
    }
    
    /// 由 Hex 生成 Color 透明度默认 1.0
    /// - Parameters:
    ///   - hexValue: 十六进制整型值
    ///   - alpha: 透明度
    /// - Returns: 对应的 Color
    public static func color(hexValue: Int, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(
            red: CGFloat((hexValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hexValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hexValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    /// 由 Hex 生成 Color 透明度默认 1.0
    /// - Parameters:
    ///   - hexString: 十六进制字符串
    ///   - alpha: 透明度
    /// - Returns: 对应的 Color
    public static func color(hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        var hex = hexString.kc.trim().lowercased()
        if hex.hasPrefix("#") {
            hex = "\(hex.dropFirst())"
        }
        if hex.hasPrefix("0x") {
            hex = "\(hexString.dropFirst(2))"
        }
        var hexValue: UInt64 = 0
        let scanner: Scanner = Scanner(string: hex)
        scanner.scanHexInt64(&hexValue)
        return UIColor(
            red: CGFloat(Int(hexValue >> 16) & 0x0000FF) / 255.0,
            green: CGFloat(Int(hexValue >> 8) & 0x0000FF) / 255.0,
            blue: CGFloat(Int(hexValue) & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    /// 由 hex 转 rgb 数据
    /// - Parameters:
    ///   - hexString: 十六进制字符串
    ///   - alpha: 透明度
    /// - Returns: rgb 数据
    public static func hexStringToRGB(
        _ hexString: String,
        alpha: CGFloat
    ) -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var length: Int = 0
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = alpha;
        let scanner: Scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
            length = 1
        }else if hexString.uppercased().hasPrefix("0X") {
            scanner.scanLocation = 2
            length = 2
        }
        var hexValue: UInt64 = 0
        scanner.scanHexInt64(&hexValue)
        switch hexString.count - length {
        case 3:
            r  = (CGFloat)((hexValue & 0xF00) >> 8) / 15.0
            g  = (CGFloat)((hexValue & 0x0F0) >> 4) / 15.0
            b  = (CGFloat)(hexValue & 0x00F) / 15.0
        case 4:
            r  = (CGFloat)((hexValue & 0xF000) >> 12) / 15.0
            g  = (CGFloat)((hexValue & 0x0F00) >> 8) / 15.0
            b  = (CGFloat)((hexValue & 0x00F0) >> 4) / 15.0
            a  = (CGFloat)(hexValue & 0x00F) / 15.0
        case 6:
            r  = (CGFloat)((hexValue & 0xFF0000) >> 16) / 255.0
            g  = (CGFloat)((hexValue & 0x00FF00) >> 8) / 255.0
            b  = (CGFloat)(hexValue & 0x0000FF) / 255.0
        case 8:
            r  = (CGFloat)((hexValue & 0xFF000000) >> 24) / 255.0;
            g  = (CGFloat)((hexValue & 0x00FF0000) >> 16) / 255.0;
            b  = (CGFloat)((hexValue & 0x0000FF00) >> 8) / 255.0;
            a  = (CGFloat)(hexValue & 0x000000FF) / 255.0;
        default:
            break
        }
        return (r, g, b, a)
    }
}

//MARK: - 常见色值 针对具体的视觉规范可自行配置
extension UIColor {
    
    /// #333333 黑色 一级标题颜色
    public static var color01: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedColor01
            ) as? UIColor ?? UIColor.kc.color(hexString: "#333333")
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedColor01,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// #666666 淡黑 部分正文文字
    public static var color02: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedColor02
            ) as? UIColor ?? UIColor.kc.color(hexString: "#666666")
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedColor02,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// #999999 深灰 弱化性的文字
    public static var color03: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedColor03
            ) as? UIColor ?? UIColor.kc.color(hexString: "#999999")
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedColor03,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// #E5E5E5 中灰色 响应的视图背景色
    public static var color04: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedColor04
            ) as? UIColor ?? UIColor.kc.color(hexString: "#E5E5E5")
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedColor04,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// #DBDBDB 深灰 深色分割线
    public static var color05: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedColor05
            ) as? UIColor ?? UIColor.kc.color(hexString: "#DBDBDB")
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedColor05,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// #EFEFEF 淡灰 浅色分割线
    public static var color06: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedColor06
            ) as? UIColor ?? UIColor.kc.color(hexString: "#EFEFEF")
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedColor06,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// #FF6666 淡红 角标等元素
    public static var color07: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedColor07
            ) as? UIColor ?? UIColor.kc.color(hexString: "#FF6666")
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedColor07,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// #86A6DF 淡蓝 链接等元素
    public static var color08: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedColor08
            ) as? UIColor ?? UIColor.kc.color(hexString: "#86A6DF")
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedColor08,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// #00ADA8 青色 正向富有意义等元素
    public static var color09: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedColor09
            ) as? UIColor ?? UIColor.kc.color(hexString: "#00ADA8")
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedColor09,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// #F9F9F9 灰白 页面背景色
    public static var color10: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedColor04
            ) as? UIColor ?? UIColor.kc.color(hexString: "#F9F9F9")
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedColor04,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// #3293FF 蓝色 程序的主色调|品牌色等元素
    public static var colorMain: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedColorMain
            ) as? UIColor ?? UIColor.kc.color(hexString: "#3293FF")
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedColorMain,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// #5874FF 浅蓝色 凸显的标签等元素
    public static var colorLabel: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedColorLabel
            ) as? UIColor ?? UIColor.kc.color(hexString: "#5874FF")
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedColorLabel,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// #FF4644 深红色 失败|删除等元素
    public static var coloError: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedColorError
            ) as? UIColor ?? UIColor.kc.color(hexString: "#FF4644")
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedColorError,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// #333333 黑色 导航条颜色
    public static var colorNavForeground: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedColorNavForeground
            ) as? UIColor ?? UIColor.kc.color(hexString: "#333333")
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedColorNavForeground,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// #FFFFFF 白色 导航栏背景颜色
    public static var colorNavBackground: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedColorNavBackground
            ) as? UIColor ?? UIColor.kc.color(hexString: "#FFFFFF")
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedColorNavBackground,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// #3293FF 按钮正常颜色
    public static var colorButtonNormal: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedColorNavBackground
            ) as? UIColor ?? UIColor.kc.color(hexString: "#3293FF")
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedColorNavBackground,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// #F7B0A6 按钮高亮颜色
    public static var colorButtonHighlighted: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedColorButtonHighlighted
            ) as? UIColor ?? UIColor.kc.color(hexString: "#F7B0A6")
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedColorButtonHighlighted,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// #0078FE 按钮选中颜色
    public static var colorButtonSelected: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedColorButtonSelected
            ) as? UIColor ?? UIColor.kc.color(hexString: "#0078FE")
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedColorButtonSelected,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// #85BFFF 按钮失效颜色
    public static var colorButtonDisabled: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedColorButtonDisabled
            ) as? UIColor ?? UIColor.kc.color(hexString: "#85BFFF")
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedColorButtonDisabled,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// #000000 40%黑色透明 遮罩
    public static var colorMask: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedColorMask
            ) as? UIColor ?? UIColor.kc.color(hexString: "#000000").kc.toColor(of: 0.4)
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedColorMask,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// 随机色 用于调试等
    public static var colorRandom: UIColor {
        let red   = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue  = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    private struct AssociatedKey {
        static var associatedColor01: Void?
        static var associatedColor02: Void?
        static var associatedColor03: Void?
        static var associatedColor04: Void?
        static var associatedColor05: Void?
        static var associatedColor06: Void?
        static var associatedColor07: Void?
        static var associatedColor08: Void?
        static var associatedColor09: Void?
        static var associatedColor10: Void?
        
        static var associatedColorMain: Void?
        static var associatedColorLabel: Void?
        static var associatedColorError: Void?
        static var associatedColorNavForeground: Void?
        static var associatedColorNavBackground: Void?
        
        static var associatedColorButtonNormal: Void?
        static var associatedColorButtonHighlighted: Void?
        static var associatedColorButtonSelected: Void?
        static var associatedColorButtonDisabled: Void?
        
        static var associatedColorMask: Void?
    }
}
