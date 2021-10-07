//
//  UIFont+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/6/15.
//

import UIKit

extension UIFont {
    
    /// 系统自带的字体样式
    public enum FontStyle: Int {
        /// PingFangSC-Regular
        case normal
        /// PingFangSC-Medium
        case medium
        /// PingFangSC-Semibold
        case bold
        /// PingFangSC-Medium
        case number
        /// PingFangSC-Light
        case light
        /// PingFangSC-Thin
        case thin
        /// PingFangSC-Ultralight
        case ultralight
    }
}

//MARK: - 字体扩展
extension UIFont {
    
    //MARK: - 常规字体 大小(7-30)
    public static var font_07: UIFont { fontSizeAdapter(07, .normal) }
    public static var font_08: UIFont { fontSizeAdapter(08, .normal) }
    public static var font_09: UIFont { fontSizeAdapter(09, .normal) }
    public static var font_10: UIFont { fontSizeAdapter(10, .normal) }
    public static var font_11: UIFont { fontSizeAdapter(11, .normal) }
    public static var font_12: UIFont { fontSizeAdapter(12, .normal) }
    public static var font_13: UIFont { fontSizeAdapter(13, .normal) }
    public static var font_14: UIFont { fontSizeAdapter(14, .normal) }
    public static var font_15: UIFont { fontSizeAdapter(15, .normal) }
    public static var font_16: UIFont { fontSizeAdapter(16, .normal) }
    public static var font_17: UIFont { fontSizeAdapter(17, .normal) }
    public static var font_18: UIFont { fontSizeAdapter(18, .normal) }
    public static var font_19: UIFont { fontSizeAdapter(19, .normal) }
    public static var font_20: UIFont { fontSizeAdapter(20, .normal) }
    public static var font_21: UIFont { fontSizeAdapter(21, .normal) }
    public static var font_22: UIFont { fontSizeAdapter(22, .normal) }
    public static var font_23: UIFont { fontSizeAdapter(23, .normal) }
    public static var font_24: UIFont { fontSizeAdapter(24, .normal) }
    public static var font_25: UIFont { fontSizeAdapter(25, .normal) }
    public static var font_26: UIFont { fontSizeAdapter(26, .normal) }
    public static var font_27: UIFont { fontSizeAdapter(27, .normal) }
    public static var font_28: UIFont { fontSizeAdapter(28, .normal) }
    public static var font_29: UIFont { fontSizeAdapter(29, .normal) }
    public static var font_30: UIFont { fontSizeAdapter(30, .normal) }
    
    //MARK: - 加粗字体 程度中等 大小(7-30)
    public static var font_medium_07: UIFont { fontSizeAdapter(07, .medium) }
    public static var font_medium_08: UIFont { fontSizeAdapter(08, .medium) }
    public static var font_medium_09: UIFont { fontSizeAdapter(09, .medium) }
    public static var font_medium_10: UIFont { fontSizeAdapter(10, .medium) }
    public static var font_medium_11: UIFont { fontSizeAdapter(11, .medium) }
    public static var font_medium_12: UIFont { fontSizeAdapter(12, .medium) }
    public static var font_medium_13: UIFont { fontSizeAdapter(13, .medium) }
    public static var font_medium_14: UIFont { fontSizeAdapter(14, .medium) }
    public static var font_medium_15: UIFont { fontSizeAdapter(15, .medium) }
    public static var font_medium_16: UIFont { fontSizeAdapter(16, .medium) }
    public static var font_medium_17: UIFont { fontSizeAdapter(17, .medium) }
    public static var font_medium_18: UIFont { fontSizeAdapter(18, .medium) }
    public static var font_medium_19: UIFont { fontSizeAdapter(19, .medium) }
    public static var font_medium_20: UIFont { fontSizeAdapter(20, .medium) }
    public static var font_medium_21: UIFont { fontSizeAdapter(21, .medium) }
    public static var font_medium_22: UIFont { fontSizeAdapter(22, .medium) }
    public static var font_medium_23: UIFont { fontSizeAdapter(23, .medium) }
    public static var font_medium_24: UIFont { fontSizeAdapter(24, .medium) }
    public static var font_medium_25: UIFont { fontSizeAdapter(25, .medium) }
    public static var font_medium_26: UIFont { fontSizeAdapter(26, .medium) }
    public static var font_medium_27: UIFont { fontSizeAdapter(27, .medium) }
    public static var font_medium_28: UIFont { fontSizeAdapter(28, .medium) }
    public static var font_medium_29: UIFont { fontSizeAdapter(29, .medium) }
    public static var font_medium_30: UIFont { fontSizeAdapter(30, .medium) }
    
    //MARK: - 加粗字体 程度中等以上 大小(7-30)
    public static var font_bold_07: UIFont { fontSizeAdapter(07, .bold) }
    public static var font_bold_08: UIFont { fontSizeAdapter(08, .bold) }
    public static var font_bold_09: UIFont { fontSizeAdapter(09, .bold) }
    public static var font_bold_10: UIFont { fontSizeAdapter(10, .bold) }
    public static var font_bold_11: UIFont { fontSizeAdapter(11, .bold) }
    public static var font_bold_12: UIFont { fontSizeAdapter(12, .bold) }
    public static var font_bold_13: UIFont { fontSizeAdapter(13, .bold) }
    public static var font_bold_14: UIFont { fontSizeAdapter(14, .bold) }
    public static var font_bold_15: UIFont { fontSizeAdapter(15, .bold) }
    public static var font_bold_16: UIFont { fontSizeAdapter(16, .bold) }
    public static var font_bold_17: UIFont { fontSizeAdapter(17, .bold) }
    public static var font_bold_18: UIFont { fontSizeAdapter(18, .bold) }
    public static var font_bold_19: UIFont { fontSizeAdapter(19, .bold) }
    public static var font_bold_20: UIFont { fontSizeAdapter(20, .bold) }
    public static var font_bold_21: UIFont { fontSizeAdapter(21, .bold) }
    public static var font_bold_22: UIFont { fontSizeAdapter(22, .bold) }
    public static var font_bold_23: UIFont { fontSizeAdapter(23, .bold) }
    public static var font_bold_24: UIFont { fontSizeAdapter(24, .bold) }
    public static var font_bold_25: UIFont { fontSizeAdapter(25, .bold) }
    public static var font_bold_26: UIFont { fontSizeAdapter(26, .bold) }
    public static var font_bold_27: UIFont { fontSizeAdapter(27, .bold) }
    public static var font_bold_28: UIFont { fontSizeAdapter(28, .bold) }
    public static var font_bold_29: UIFont { fontSizeAdapter(29, .bold) }
    public static var font_bold_30: UIFont { fontSizeAdapter(30, .bold) }
    
    //MARK: - 数字字体 默认加粗 程度中等 大小(7-30)
    public static var font_number_07: UIFont { fontSizeAdapter(07, .number) }
    public static var font_number_08: UIFont { fontSizeAdapter(08, .number) }
    public static var font_number_09: UIFont { fontSizeAdapter(09, .number) }
    public static var font_number_10: UIFont { fontSizeAdapter(10, .number) }
    public static var font_number_11: UIFont { fontSizeAdapter(11, .number) }
    public static var font_number_12: UIFont { fontSizeAdapter(12, .number) }
    public static var font_number_13: UIFont { fontSizeAdapter(13, .number) }
    public static var font_number_14: UIFont { fontSizeAdapter(14, .number) }
    public static var font_number_15: UIFont { fontSizeAdapter(15, .number) }
    public static var font_number_16: UIFont { fontSizeAdapter(16, .number) }
    public static var font_number_17: UIFont { fontSizeAdapter(17, .number) }
    public static var font_number_18: UIFont { fontSizeAdapter(18, .number) }
    public static var font_number_19: UIFont { fontSizeAdapter(19, .number) }
    public static var font_number_20: UIFont { fontSizeAdapter(20, .number) }
    public static var font_number_21: UIFont { fontSizeAdapter(21, .number) }
    public static var font_number_22: UIFont { fontSizeAdapter(22, .number) }
    public static var font_number_23: UIFont { fontSizeAdapter(23, .number) }
    public static var font_number_24: UIFont { fontSizeAdapter(24, .number) }
    public static var font_number_25: UIFont { fontSizeAdapter(25, .number) }
    public static var font_number_26: UIFont { fontSizeAdapter(26, .number) }
    public static var font_number_27: UIFont { fontSizeAdapter(27, .number) }
    public static var font_number_28: UIFont { fontSizeAdapter(28, .number) }
    public static var font_number_29: UIFont { fontSizeAdapter(29, .number) }
    public static var font_number_30: UIFont { fontSizeAdapter(30, .number) }
    
    //MARK: - 纤细字体 程度常规细 大小(7-30)
    public static var font_light_07: UIFont { fontSizeAdapter(07, .light) }
    public static var font_light_08: UIFont { fontSizeAdapter(08, .light) }
    public static var font_light_09: UIFont { fontSizeAdapter(09, .light) }
    public static var font_light_10: UIFont { fontSizeAdapter(10, .light) }
    public static var font_light_11: UIFont { fontSizeAdapter(11, .light) }
    public static var font_light_12: UIFont { fontSizeAdapter(12, .light) }
    public static var font_light_13: UIFont { fontSizeAdapter(13, .light) }
    public static var font_light_14: UIFont { fontSizeAdapter(14, .light) }
    public static var font_light_15: UIFont { fontSizeAdapter(15, .light) }
    public static var font_light_16: UIFont { fontSizeAdapter(16, .light) }
    public static var font_light_17: UIFont { fontSizeAdapter(17, .light) }
    public static var font_light_18: UIFont { fontSizeAdapter(18, .light) }
    public static var font_light_19: UIFont { fontSizeAdapter(19, .light) }
    public static var font_light_20: UIFont { fontSizeAdapter(20, .light) }
    public static var font_light_21: UIFont { fontSizeAdapter(21, .light) }
    public static var font_light_22: UIFont { fontSizeAdapter(22, .light) }
    public static var font_light_23: UIFont { fontSizeAdapter(23, .light) }
    public static var font_light_24: UIFont { fontSizeAdapter(24, .light) }
    public static var font_light_25: UIFont { fontSizeAdapter(25, .light) }
    public static var font_light_26: UIFont { fontSizeAdapter(26, .light) }
    public static var font_light_27: UIFont { fontSizeAdapter(27, .light) }
    public static var font_light_28: UIFont { fontSizeAdapter(28, .light) }
    public static var font_light_29: UIFont { fontSizeAdapter(29, .light) }
    public static var font_light_30: UIFont { fontSizeAdapter(30, .light) }
    
    //MARK: - 纤细字体 程度中等细 大小(7-30)
    public static var font_thin_07: UIFont { fontSizeAdapter(07, .thin) }
    public static var font_thin_08: UIFont { fontSizeAdapter(08, .thin) }
    public static var font_thin_09: UIFont { fontSizeAdapter(09, .thin) }
    public static var font_thin_10: UIFont { fontSizeAdapter(10, .thin) }
    public static var font_thin_11: UIFont { fontSizeAdapter(11, .thin) }
    public static var font_thin_12: UIFont { fontSizeAdapter(12, .thin) }
    public static var font_thin_13: UIFont { fontSizeAdapter(13, .thin) }
    public static var font_thin_14: UIFont { fontSizeAdapter(14, .thin) }
    public static var font_thin_15: UIFont { fontSizeAdapter(15, .thin) }
    public static var font_thin_16: UIFont { fontSizeAdapter(16, .thin) }
    public static var font_thin_17: UIFont { fontSizeAdapter(17, .thin) }
    public static var font_thin_18: UIFont { fontSizeAdapter(18, .thin) }
    public static var font_thin_19: UIFont { fontSizeAdapter(19, .thin) }
    public static var font_thin_20: UIFont { fontSizeAdapter(20, .thin) }
    public static var font_thin_21: UIFont { fontSizeAdapter(21, .thin) }
    public static var font_thin_22: UIFont { fontSizeAdapter(22, .thin) }
    public static var font_thin_23: UIFont { fontSizeAdapter(23, .thin) }
    public static var font_thin_24: UIFont { fontSizeAdapter(24, .thin) }
    public static var font_thin_25: UIFont { fontSizeAdapter(25, .thin) }
    public static var font_thin_26: UIFont { fontSizeAdapter(26, .thin) }
    public static var font_thin_27: UIFont { fontSizeAdapter(27, .thin) }
    public static var font_thin_28: UIFont { fontSizeAdapter(28, .thin) }
    public static var font_thin_29: UIFont { fontSizeAdapter(29, .thin) }
    public static var font_thin_30: UIFont { fontSizeAdapter(30, .thin) }
    
    //MARK: - 纤细字体 程度极端细 大小(7-30)
    public static var font_ultralight_07: UIFont { fontSizeAdapter(07, .ultralight) }
    public static var font_ultralight_08: UIFont { fontSizeAdapter(08, .ultralight) }
    public static var font_ultralight_09: UIFont { fontSizeAdapter(09, .ultralight) }
    public static var font_ultralight_10: UIFont { fontSizeAdapter(10, .ultralight) }
    public static var font_ultralight_11: UIFont { fontSizeAdapter(11, .ultralight) }
    public static var font_ultralight_12: UIFont { fontSizeAdapter(12, .ultralight) }
    public static var font_ultralight_13: UIFont { fontSizeAdapter(13, .ultralight) }
    public static var font_ultralight_14: UIFont { fontSizeAdapter(14, .ultralight) }
    public static var font_ultralight_15: UIFont { fontSizeAdapter(15, .ultralight) }
    public static var font_ultralight_16: UIFont { fontSizeAdapter(16, .ultralight) }
    public static var font_ultralight_17: UIFont { fontSizeAdapter(17, .ultralight) }
    public static var font_ultralight_18: UIFont { fontSizeAdapter(18, .ultralight) }
    public static var font_ultralight_19: UIFont { fontSizeAdapter(19, .ultralight) }
    public static var font_ultralight_20: UIFont { fontSizeAdapter(20, .ultralight) }
    public static var font_ultralight_21: UIFont { fontSizeAdapter(21, .ultralight) }
    public static var font_ultralight_22: UIFont { fontSizeAdapter(22, .ultralight) }
    public static var font_ultralight_23: UIFont { fontSizeAdapter(23, .ultralight) }
    public static var font_ultralight_24: UIFont { fontSizeAdapter(24, .ultralight) }
    public static var font_ultralight_25: UIFont { fontSizeAdapter(25, .ultralight) }
    public static var font_ultralight_26: UIFont { fontSizeAdapter(26, .ultralight) }
    public static var font_ultralight_27: UIFont { fontSizeAdapter(27, .ultralight) }
    public static var font_ultralight_28: UIFont { fontSizeAdapter(28, .ultralight) }
    public static var font_ultralight_29: UIFont { fontSizeAdapter(29, .ultralight) }
    public static var font_ultralight_30: UIFont { fontSizeAdapter(30, .ultralight) }
    
    /// 导航栏标题字体 默认平方加粗 18pt
    public static var font_NavTitle: UIFont {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedNavTitle
            ) as? UIFont ?? fontSizeAdapter(18, .medium)
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedNavTitle,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// 导航栏左边 item 字体  默认平方常规 15pt
    public static var font_NavLeftItem: UIFont {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedNavLeftItem
            ) as? UIFont ?? fontSizeAdapter(15, .normal)
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedNavLeftItem,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// 导航栏右边 item 字体 默认平方常规 15pt
    public static var font_NavRightItem: UIFont {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedNavRightItem
            ) as? UIFont ?? fontSizeAdapter(15, .normal)
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedNavRightItem,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// 系统平方字体大小适配器 默认适配系数 2
    /// - Parameters:
    ///   - size: 字体大小
    ///   - style: 字体样式
    ///   - fontScale: 字体适配的系数
    /// - Returns: 字体
    public static func fontSizeAdapter(
        _ size: CGFloat,
        _ style: UIFont.FontStyle,
        fontScale: CGFloat = 2
    ) -> UIFont {
        return UIFont(name: fetchFontStyle(style), size: toFontSize(size))!
    }
    
    /// 系统字体大小适配器 默认系统常规字体 适配系数 2
    /// - Parameters:
    ///   - size: 字体大小
    ///   - weight: 字体权重
    ///   - fontScale: 字体适配的系数
    /// - Returns: 字体
    public static func fontSizeAdapter(
        of size: CGFloat,
        weight: UIFont.Weight = .regular,
        fontScale: CGFloat = 2
    ) -> UIFont {
        return UIFont.systemFont(ofSize: toFontSize(size), weight: weight)
    }
    
    /// 字体适配后的大小 默认适配系数 2
    /// - Parameters:
    ///   - size: 字体大小
    ///   - fontScale: 字体适配的系数
    /// - Returns: 适配后的实际大小
    private static func toFontSize(_ size: CGFloat, fontScale: CGFloat = 2) -> CGFloat {
         return fontScale * CGFloat.toDesign(size)
    }
    
    /// 字体名称
    /// - Parameter fontStyle: 字体样式
    /// - Returns: 字体名称
    private static func fetchFontStyle(_ fontStyle: UIFont.FontStyle) -> String {
        switch fontStyle {
        case .normal: return "PingFangSC-Regular"
        case .medium: return "PingFangSC-Medium"
        case .bold: return "PingFangSC-Semibold"
        case .number: return "PingFangSC-Medium"
        case .light: return "PingFangSC-Light"
        case .thin: return "PingFangSC-Thin"
        case .ultralight: return "PingFangSC-Ultralight"
        }
    }
    
    private struct AssociatedKey {
        static var associatedNavTitle: Void?
        static var associatedNavLeftItem: Void?
        static var associatedNavRightItem: Void?
    }
}
