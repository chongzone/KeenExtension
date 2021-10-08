//
//  UIControl+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/8/11.
//

import UIKit

//MARK: - 链式属性函数
extension UIControl {
    
    /// 控件是否可接受响应
    /// - Parameter isEnabled: 是否可接受响应
    /// - Returns: 自身
    @discardableResult
    public func isEnabled(_ isEnabled: Bool) -> Self {
        self.isEnabled = isEnabled
        return self
    }
    
    /// 是否被点击
    /// - Parameter isSelected: 点击状态
    /// - Returns: 自身
    @discardableResult
    public func isSelected(_ isSelected: Bool) -> Self {
        self.isSelected = isSelected
        return self
    }
    
    /// 是否高亮状态
    /// - Parameter isHighlighted: 高亮状态
    /// - Returns: 自身
    @discardableResult
    public func isHighlighted(_ isHighlighted: Bool) -> Self {
        self.isHighlighted = isHighlighted
        return self
    }
    
    /// 内容水平对齐方式
    /// - Parameter horizontalAlignment: 对齐方式
    /// - Returns: 自身
    @discardableResult
    public func horizontalAlignment(_ horizontalAlignment: UIControl.ContentHorizontalAlignment) -> Self {
        contentHorizontalAlignment = horizontalAlignment
        return self
    }
    
    /// 内容垂直对齐方式
    /// - Parameter verticalAlignment: 对齐方式
    /// - Returns: 自身
    @discardableResult
    public func verticalAlignment(_ verticalAlignment: UIControl.ContentVerticalAlignment) -> Self {
        contentVerticalAlignment = verticalAlignment
        return self
    }
    
    /// 扩大控件的响应边距 起最大响应区域是其父视图的 bounds
    /// 子控件有: UITextField UIButton UIPageControl UISlider UISwitch UIDatePicker UISegmentedControl 等
    /// - Parameter edge: 扩大的四周区域
    /// - Returns: 自身
    @discardableResult
    public func hitEdgeInsets(_ edge: UIEdgeInsets) -> Self {
        hitEdgeInsets = edge
        return self
    }
}

//MARK: - 常见功能
extension UIControl {
    
    /// 扩大响应边距 最大响应区域是其父视图的 bounds
    public var hitEdgeInsets: UIEdgeInsets {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedHitEdgeArea
            ) as? UIEdgeInsets ?? .zero
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedHitEdgeArea,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// 是否响应
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard hitEdgeInsets != .zero,
              isEnabled,
              isUserInteractionEnabled,
              alpha > 0.01,
              !isHidden else {
            return super.point(inside: point, with: event)
        }
        let responseArea = self.bounds.inset(by: hitEdgeInsets)
        return responseArea.contains(point)
    }
    
    /// 响应事件
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return super.hitTest(point, with: event)
    }
}

//MARK: - 点击事件
extension KcPrefixWrapper where Base: UIControl {
    
    /// Control 事件点击 默认响应间隔 1.0s
    /// - Parameters:
    ///   - event: 事件模式
    ///   1. Button(touchUpInside) | DatePicker(valueChanged) |
    ///   - action: 点击的事件
    ///   - interval: 允许的点击间隔 默认 1.0s
    ///   - isExclusion: 事件之间是否互斥 默认互斥
    public func clickEvent(
        _ event: UIControl.Event,
        _ action: @escaping ((_ control: UIControl) -> ()),
        interval: TimeInterval = 1.0,
        isExclusion: Bool = true
    ) {
        objc_setAssociatedObject(
            self,
            &Base.AssociatedKey.associatedClickAction,
            action,
            .OBJC_ASSOCIATION_COPY_NONATOMIC
        )
        base.clickInterval = interval
        base.isExclusiveTouch = isExclusion
        base.addTarget(base, action: #selector(base.clickAction(_ :)), for: event)
    }
}

fileprivate extension UIControl {
    
    @objc func clickAction(_ control: UIControl) {
        if Date().timeIntervalSince1970 - clickLastTime < clickInterval { return }
        clickLastTime = Date().timeIntervalSince1970
        if let action = objc_getAssociatedObject(
            self,
            &AssociatedKey.associatedClickAction
        ) as? ((UIControl) -> ()) {
            action(control)
        }
    }
    
    /// 最近一次的点击时间
    var clickLastTime: TimeInterval {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedLastTime
            ) as? TimeInterval ?? 0
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedLastTime,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// 点击的响应间隔 默认 1.0s
    var clickInterval: TimeInterval {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedInterval
            ) as? TimeInterval ?? 1.0
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedInterval,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    struct AssociatedKey {
        static var associatedLastTime: Void?
        static var associatedInterval: Void?
        static var associatedClickAction: Void?
        static var associatedHitEdgeArea: Void?
    }
}
