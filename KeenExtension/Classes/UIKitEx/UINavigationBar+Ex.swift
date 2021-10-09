//
//  UINavigationBar+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/12/4.
//

import UIKit

//MARK: - 链式属性函数
extension UINavigationBar {
    
    /// 导航栏是否半透明 半透明且页面边缘向四周延伸的话 则页面从 (0, 0) 开始布局 默认非半透明
    /// 若从导航栏下进行布局 设置 isTranslucent  = false 或 设置页面四周无延伸 即  vc.edgesForExtendedLayout = []
    /// - Parameter enable: 是否半透明
    /// - Returns: 自身
    @discardableResult
    public func isTranslucent(_ enable: Bool = false) -> Self {
        isTranslucent = enable
        return self
    }
    
    /// 导航栏是否显示下划线 默认显示
    /// - Parameter show: 是否显示
    /// - Returns: 自身
    @discardableResult
    public func showUnderline(_ show: Bool = true) -> Self {
        showUnderline = show
        return self
    }
    
    /// 导航栏背景颜色 默认白色 不会出现色差
    /// - Parameter color: 颜色
    /// - Returns: 自身
    @discardableResult
    public func backColor(_ color: UIColor = .white) -> Self {
        backColor = color
        return self
    }
    
    /// 导航栏背景颜色 可能会出现色差  默认 nil
    /// 通过这个直接设置会导致色差 因为在 navigationBar 上面还覆盖着一个 visualeffectView 会对其进行模糊渲染
    /// 去除色差可同步关闭导航栏半透明(页面布局从导航栏下开始) 或 通过设置 setBackgroundImage( : , for : ) 处理
    /// - Parameter color: 背景色
    /// - Returns: 自身
    @discardableResult
    public func barTintColor(_ color: UIColor?) -> Self {
        barTintColor = color
        return self
    }
    
    /// 导航栏标题颜色 默认黑色
    /// - Parameter color: 颜色
    /// - Returns: 自身
    @discardableResult
    public func titleColor(_ color: UIColor = .black) -> Self {
        titleColor = color
        return self
    }
    
    /// 导航栏标题字体 默认加粗 18 pt
    /// - Parameter font: 字体
    /// - Returns: 自身
    @discardableResult
    public func titleFont(_ font: UIFont = .font_medium_18) -> Self {
        titleFont = font
        return self
    }
    
    /// 导航栏标题字体&颜色 字体默认加粗(18 pt) 颜色(黑色)
    /// - Parameter font: 字体
    /// - Parameter color: 颜色
    /// - Returns: 自身
    @discardableResult
    public func titleAttributes(_ font: UIFont = .font_medium_18, _ color: UIColor = .black) -> Self {
        titleAttributes = (font, color)
        return self
    }
    
    /// 导航栏左右 item 颜色 默认黑色
    /// - Parameter color: 颜色
    /// - Returns: 自身
    @discardableResult
    public func barColor(_ color: UIColor = .black) -> Self {
        barColor = color
        return self
    }
}

//MARK: - 导航栏 属性扩展
extension UINavigationBar {
    
    /// 是否显示下划线 默认显示
    public var showUnderline: Bool {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedShowUnderline
            ) as? Bool ?? true
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedShowUnderline,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            shadowImage = newValue ? UIImage.kc.image(color: .color06) : UIImage()
        }
    }
    
    /// 背景颜色 默认白色
    public var backColor: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedBackColor
            ) as? UIColor ?? .white
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedBackColor,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            setBackgroundImage(UIImage.kc.image(color: newValue), for: .default)
        }
    }
    
    /// 标题颜色 默认黑色
    public var titleColor: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedTitleColor
            ) as? UIColor ?? .black
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedTitleColor,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            titleTextAttributes = [.foregroundColor: newValue]
        }
    }
    
    /// 标题字体 默认加粗 18 pt
    public var titleFont: UIFont {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedTitleFont
            ) as? UIFont ?? .font_medium_18
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedTitleFont,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            titleTextAttributes = [.font: newValue]
        }
    }
    
    /// 标题字体&颜色 字体默认加粗(18 pt) 颜色(黑色)
    public var titleAttributes: (UIFont, UIColor) {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedTitleAttributes
            ) as? (UIFont, UIColor) ?? (.font_medium_18, .black)
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedTitleAttributes,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            titleTextAttributes = [.font: newValue.0, .foregroundColor: newValue.1]
        }
    }
    
    /// 左右 item 颜色 默认黑色
    public var barColor: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedBarColor
            ) as? UIColor ?? .black
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedBarColor,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            tintColor = newValue
        }
    }
    
    private struct AssociatedKey {
        static var associatedBackColor: Void?
        static var associatedShowUnderline: Void?
        static var associatedTitleColor: Void?
        static var associatedTitleFont: Void?
        static var associatedTitleAttributes: Void?
        static var associatedBarColor: Void?
    }
}
