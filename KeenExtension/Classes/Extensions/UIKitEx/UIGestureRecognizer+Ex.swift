//
//  UIGestureRecognizer+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/12/19.
//

import UIKit

//MARK: - 链式属性函数
extension UIGestureRecognizer {
    
    /// 代理
    /// - Parameter delegate: 代理
    /// - Returns: 自身
    @discardableResult
    public func delegate(_ delegate: UIGestureRecognizerDelegate?) -> Self {
        self.delegate = delegate
        return self
    }
    
    /// 手势是否有效
    /// - Parameter enable: 是否有效
    /// - Returns: 自身
    @discardableResult
    public func isEnabled(_ enable: Bool) -> Self {
        self.isEnabled = enable
        return self
    }
    
    /// 是否取消手势在其视图事件链上的传递 默认 true
    /// - Parameter isCancel: 是否取消
    /// - Returns: 自身
    @discardableResult
    public func cancelsTouchesInView(_ isCancel: Bool = true) -> Self {
        cancelsTouchesInView = isCancel
        return self
    }
    
    ///手势识别之前是否推迟事件传递 默认 false
    /// - Parameter isDelays: 是否延迟
    /// - Returns: 自身
    @discardableResult
    public func delaysTouchesBegan(_ isDelays: Bool = false) -> Self {
        delaysTouchesBegan = isDelays
        return self
    }
    
    /// 手势识别结束之后是否推迟事件传递 默认 false
    /// - Parameter isDelays: 是否延迟
    /// - Returns: 自身
    @discardableResult
    public func delaysTouchesEnded(_ isDelays: Bool = false) -> Self {
        delaysTouchesEnded = isDelays
        return self
    }
    
    /// 该手势需其他手势识别失败之后执行 即优先执行其他手势事件
    /// - Parameter otherGesture: 其他手势
    /// - Returns: 自身
    @discardableResult
    public func require(after otherGesture: UIGestureRecognizer) -> Self {
        require(toFail: otherGesture)
        return self
    }
    
    /// 添加手势
    /// - Parameter view: 视图
    /// - Returns: 自身
    @discardableResult
    public func addGestureTo(_ view: UIView) -> Self {
        view.addGestureRecognizer(self)
        return self
    }
    
    /// 移除手势
    /// - Parameter view: 视图
    /// - Returns: 自身
    @discardableResult
    public func removeGestureTo(_ view: UIView) -> Self {
        view.removeGestureRecognizer(self)
        return self
    }
}

extension UITapGestureRecognizer {
    
    /// 要求的点击数 默认 1
    /// - Parameter nums: 点击数
    /// - Returns: 自身
    @discardableResult
    public func numberOfTapsRequired(_ nums: Int = 1) -> Self {
        numberOfTapsRequired = nums
        return self
    }
    
    /// 要求的触摸点数 默认 1
    /// - Parameter nums: 触摸点数
    /// - Returns: 自身
    @discardableResult
    public func numberOfTouchesRequired(_ nums: Int = 1) -> Self {
        numberOfTouchesRequired = nums
        return self
    }
}

extension UILongPressGestureRecognizer {
    
    /// 长按之前要求的点击数 默认 0
    /// - Parameter nums: 点击数
    /// - Returns: 自身
    @discardableResult
    public func numberOfTapsRequired(_ nums: Int = 0) -> Self {
        numberOfTapsRequired = nums
        return self
    }
    
    /// 要求的触摸点数 默认 1
    /// - Parameter nums: 触摸点数
    /// - Returns: 自身
    @discardableResult
    public func numberOfTouchesRequired(_ nums: Int = 1) -> Self {
        numberOfTouchesRequired = nums
        return self
    }
    
    /// 长按要求的最低时长 默认 0.5s
    /// - Parameter duration: 长按时长
    /// - Returns: 自身
    @discardableResult
    public func minimumPressDuration(_ duration: TimeInterval = 0.5) -> Self {
        minimumPressDuration = duration
        return self
    }
    
    /// 手势识别之前允许的最大移动距离 默认 10 px
    /// - Parameter distance: 最大距离 单位 px
    /// - Returns: 自身
    @discardableResult
    public func allowableMovement(_ distance: CGFloat = 10) -> Self {
        allowableMovement = distance
        return self
    }
}

extension UIPanGestureRecognizer {
    
    /// 要求的最低触摸点数 默认 1
    /// - Parameter nums: 触摸点数
    /// - Returns: 自身
    @discardableResult
    public func minimumNumberOfTouches(_ nums: Int = 1) -> Self {
        minimumNumberOfTouches = nums
        return self
    }
    
    /// 要求的最大触摸点数 默认无穷大 ∞
    /// - Parameter nums: 触摸点数
    /// - Returns: 自身
    @discardableResult
    public func maximumNumberOfTouches(_ nums: Int = Int(UInt.max)) -> Self {
        maximumNumberOfTouches = nums
        return self
    }
}

extension UISwipeGestureRecognizer {
    
    /// 要求的触摸点数 默认 1
    /// - Parameter nums: 触摸点数
    /// - Returns: 自身
    @discardableResult
    public func numberOfTouchesRequired(_ nums: Int = 1) -> Self {
        numberOfTouchesRequired = nums
        return self
    }
    
    /// 清扫方向 默认向右清扫
    /// 若是多个方向执行同样的操作则可指定多个方向 否则应一个方向指定发一个清扫手势
    /// - Parameter direction: 清扫方向
    /// - Returns: 自身
    @discardableResult
    public func direction(_ direction: UISwipeGestureRecognizer.Direction = .right) -> Self {
        self.direction = direction
        return self
    }
}

extension UIPinchGestureRecognizer {
 
    /// 捏合手势的比例
    /// - Parameter scale: 捏合比例
    /// - Returns: 自身
    @discardableResult
    public func scale(_ scale: CGFloat) -> Self {
        self.scale = scale
        return self
    }
}

extension UIRotationGestureRecognizer {
    
    /// 旋转手势的比例 其中以开始为基点 顺时针旋转 rotation 减小 逆时针旋转 rotation 增大
    /// - Parameter rotation: 旋转比例
    /// - Returns: 自身
    @discardableResult
    public func rotation(_ rotation: CGFloat) -> Self {
        self.rotation = rotation
        return self
    }
}

extension UIScreenEdgePanGestureRecognizer {
    
    /// 旋转手势的比例 其中以开始为基点 顺时针旋转 rotation 减小 逆时针旋转 rotation 增大
    /// - Parameter rotation: 旋转比例
    /// - Returns: 自身
    @discardableResult
    public func edges(_ edges: UIRectEdge) -> Self {
        self.edges = edges
        return self
    }
}

//MARK: - 手势事件
extension KcPrefixWrapper where Base: UIGestureRecognizer {
    
    public func addGesture(_ action: @escaping (UIGestureRecognizer) -> Void) {
        base.addTarget(self, action: #selector(base.clickGesture))
        objc_setAssociatedObject(
            self,
            &Base.AssociatedKey.associatedGestureEvent,
            action,
            .OBJC_ASSOCIATION_COPY_NONATOMIC
        )
    }
}

fileprivate extension UIGestureRecognizer {
    
    @objc func clickGesture() {
        if let event = objc_getAssociatedObject(
            self,
            &AssociatedKey.associatedGestureEvent
        ) as? ((UIGestureRecognizer) -> (Void)) {
            event(self)
        }
    }
    
    struct AssociatedKey {
        static var associatedGestureEvent: Void?
    }
}
