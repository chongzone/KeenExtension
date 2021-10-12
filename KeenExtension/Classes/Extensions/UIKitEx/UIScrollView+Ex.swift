//
//  UIScrollView+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/11/26.
//

import UIKit

extension UIScrollView {
    
    /// 滚动到边缘的位置
    public enum ScrollEdge: Int {
        case top
        case left
        case bottom
        case right
    }
}

//MARK: - 链式属性函数
extension UIScrollView {
    
    /// 代理
    /// - Parameter delegate: 代理
    /// - Returns: 自身
    @discardableResult
    public func delegate(_ delegate: UIScrollViewDelegate?) -> Self {
        self.delegate = delegate
        return self
    }
    
    /// 是否有弹性效果 默认是 true
    /// - Parameter bounces: 是否有弹性
    /// - Returns: 自身
    @discardableResult
    public func bounces(_ bounces: Bool = true) -> Self {
        self.bounces = bounces
        return self
    }
    
    /// 是否允许滚动 默认 true
    /// - Parameter enabled: 是否滚动
    /// - Returns: 自身
    @discardableResult
    public func isScrollEnabled(_ enabled: Bool = true) -> Self {
        isScrollEnabled = enabled
        return self
    }
    
    /// 是否滚动分页 默认 false
    /// - Parameter enabled: 是否滚动分页
    /// - Returns: 自身
    @discardableResult
    public func isPagingEnabled(_ enabled: Bool = false) -> Self {
        isPagingEnabled = enabled
        return self
    }
    
    /// 点击状态栏时是否允许其自动滚动到顶部 默认 true
    /// - Parameter enableTop: 是否允许滚动到顶部
    /// - Returns: 自身
    @discardableResult
    public func scrollsToTop(_ enableTop: Bool = true) -> Self {
        scrollsToTop = enableTop
        return self
    }
    
    /// 水平方向是否可弹性滑动 默认 false
    /// - Parameter bounces: 是否弹性
    /// - Returns: 自身
    @discardableResult
    public func alwaysBounceHorizontal(_ bounces: Bool = false) -> Self {
        alwaysBounceHorizontal = bounces
        return self
    }
    
    /// 竖直方向是否可弹性滑动 默认  false
    /// - Parameter bounces: 是否弹性
    /// - Returns: 自身
    @discardableResult
    public func alwaysBounceVertical(_ bounces: Bool = false) -> Self {
        alwaysBounceVertical = bounces
        return self
    }
    
    /// 是否显示水平方向滑动条 默认 true
    /// - Parameter show: 是否显示水平方向滑动条
    /// - Returns: 自身
    @discardableResult
    public func showsHorizontalScrollIndicator(_ show: Bool = true) -> Self {
        showsHorizontalScrollIndicator = show
        return self
    }
    
    /// 是否显示垂直方向滑动条 默认 true
    /// - Parameter show: 是否显示垂直方向滑动条
    /// - Returns: 自身
    @discardableResult
    public func showsVerticalScrollIndicator(_ show: Bool = true) -> Self {
        showsVerticalScrollIndicator = show
        return self
    }
    
    /// 滑动条的样式 默认灰白色
    /// - Parameter style: 滑动条样式
    /// - Returns: 自身
    @discardableResult
    public func indicatorStyle(_ style: UIScrollView.IndicatorStyle = .default) -> Self {
        indicatorStyle = style
        return self
    }
    
    /// 滑动条内边距
    /// - Parameter inset: 内边距
    /// - Returns: 自身
    @discardableResult
    public func scrollIndicatorInsets(_ inset: UIEdgeInsets) -> Self {
        scrollIndicatorInsets = inset
        return self
    }
    
    /// 水平滑动条的内边距 默认 zero
    /// - Parameter inset: 内边距
    /// - Returns: 自身
    @available(iOS 11.1, *)
    @discardableResult
    public func horizontalScrollIndicatorInsets(_ inset: UIEdgeInsets = .zero) -> Self {
        horizontalScrollIndicatorInsets = inset
        return self
    }
    
    /// 垂直滑动条的内边距 默认 zero
    /// - Parameter inset: 内边距
    /// - Returns: 自身
    @available(iOS 11.1, *)
    @discardableResult
    public func verticalScrollIndicatorInsets(_ inset: UIEdgeInsets = .zero) -> Self {
        verticalScrollIndicatorInsets = inset
        return self
    }
    
    /// 滑动时是否锁住另外方向的滑动 默认  false(不锁定)
    /// - Parameter enabled: 是否锁住 默认 false
    /// - Returns: 自身
    @discardableResult
    public func isDirectionalLockEnabled(_ enabled: Bool = false) -> Self {
        isDirectionalLockEnabled = enabled
        return self
    }
    
    /// 减速样式  默认 .normal
    /// - Parameter rate: 减速样式
    /// - Returns: 自身
    @discardableResult
    public func decelerationRate(_ rate: UIScrollView.DecelerationRate = .normal) -> Self {
        decelerationRate = rate
        return self
    }
    
    /// 键盘消失模式
    /// - Parameter mode: 模式
    /// - Returns: 自身
    @discardableResult
    public func keyboardDismissMode(_ mode: UIScrollView.KeyboardDismissMode = .none) -> Self {
        keyboardDismissMode = mode
        return self
    }
    
    /// 当视图缩放比例大于设置比例是否自动进行反弹 默认是 true 反之则缩放不会超过设置的缩放比例
    /// - Parameter bounces: 是否有弹性
    /// - Returns: 自身
    @discardableResult
    public func bouncesZoom(_ bounces: Bool = true) -> Self {
        bouncesZoom = bounces
        return self
    }
    
    /// 最小的缩放比例 默认 1.0
    /// - Parameter scale: 缩放比例
    /// - Returns: 自身
    @discardableResult
    public func minimumZoomScale(_ scale: CGFloat = 1.0) -> Self {
        minimumZoomScale = scale
        return self
    }
    
    /// 最大的缩放比例 默认 1.0 不能和 minimumZoomScale 同值
    /// - Parameter scale: 缩放比例
    /// - Returns: 自身
    @discardableResult
    public func maximumZoomScale(_ scale: CGFloat = 1.0) -> Self {
        maximumZoomScale = scale
        return self
    }
    
    /// 缩放比例 默认 1.0
    /// - Parameter scale: 缩放比例
    /// - Parameter animated: 是否动画
    /// - Returns: 自身
    @discardableResult
    public func zoomScale(_ scale: CGFloat = 1.0, animated: Bool = true) -> Self {
        setZoomScale(scale, animated: animated)
        return self
    }
    
    /// 缩放区域 常用在点击放大等场景
    /// - Parameters:
    ///   - rect: 范围
    ///   - animated: 是否动画
    /// - Returns: 自身
    @discardableResult
    public func zoom(rect: CGRect, animated: Bool = true) -> Self {
        zoom(to: rect, animated: animated)
        return self
    }
    
    /// 内边距 默认 zero
    /// - Parameter inset: 内边距
    /// - Returns: 自身
    @discardableResult
    public func contentInset(_ inset: UIEdgeInsets = .zero) -> Self {
        contentInset = inset
        return self
    }
    
    /// 滑动区域大小 默认 zero
    /// - Parameter size: 滑动区域
    /// - Returns: 自身
    @discardableResult
    public func contentSize(_ size: CGSize = .zero) -> Self {
        contentSize = size
        return self
    }
    
    /// 偏移量 默认 zero
    /// - Parameter offset: 偏移量
    /// - Returns: 自身
    @discardableResult
    public func contentOffset(_ offset: CGPoint = .zero) -> Self {
        contentOffset = offset
        return self
    }
    
    /// 滚动的偏移量  默认动画
    /// - Parameters:
    ///   - x: x 偏移量
    ///   - y: y 偏移量
    ///   - animated: 是否有动画 默认 true
    /// - Returns: 自身
    @discardableResult
    public func setContentOffset(x: CGFloat, y: CGFloat, animated: Bool = true) -> Self {
        setContentOffset(CGPoint(x: x, y: y), animated: animated)
        return self
    }
    
    /// 内容内边距自适应的样式 适配 iOS11 以上系统 默认 automatic
    /// - Parameter behavior: 行为样式
    /// - Returns: 自身
    @discardableResult
    @available(iOS 11.0, *)
    public func adjustmentBehavior(_ behavior: UIScrollView.ContentInsetAdjustmentBehavior = .automatic) -> Self {
        contentInsetAdjustmentBehavior = behavior
        return self
    }
}

//MARK: - 基础功能
extension KcPrefixWrapper where Base: UIScrollView {
    
    /// iOS 11 适配 禁止自动调整其 inset
    public func automaticallyAdjustsInsets(_ vc: UIViewController) {
        if #available(iOS 11.0, *) {
            base.contentInsetAdjustmentBehavior = .never
        }else {
            vc.automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    /// 滚动到边距位置 默认动画
    /// - Parameters:
    ///   - edge: 位置
    ///   - animated: 是否动画 默认 true
    public func scroll(_ edge: UIScrollView.ScrollEdge, animated: Bool = true) {
        var offset = base.contentOffset
        switch edge {
        case .top:
            offset.y = -base.contentInset.top
        case .left:
            offset.x = -base.contentInset.left
        case .bottom:
            offset.y = base.contentSize.height + base.contentInset.bottom - height
        case .right:
            offset.x = base.contentSize.width + base.contentInset.right - width
        }
        base.setContentOffset(offset, animated: animated)
    }
}
