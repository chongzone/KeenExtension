//
//  UIView+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/6/15.
//

import UIKit
import WebKit

extension UIView {
    
    /// 边框位置
    public enum BorderPosition: Int {
        case top
        case left
        case bottom
        case right
        case all
    }
    
    /// 抖动的方向
    public enum ShakeDirection: Int {
        case horizontal
        case vertical
    }
    
    /// 常见的动画类型模式
    public enum AnimationMode: Int {
        /// 缩放 x & y 其中  z 轴对平面图像不明显
        case scale
        /// 旋转 x & y & z
        case rotation
        /// 旋转 x
        case rotationX
        /// 旋转 y
        case rotationY
        /// 旋转 z
        case rotationZ
        /// 移动 x & y 其中 z 轴对平面图像不明显
        case translation
    }
}

//MARK: - 初始化
extension UIView {
    
    /// 初始化
    /// - Parameters:
    ///   - origin: origin 点
    ///   - size: size 大小
    public convenience init(origin: CGPoint, size: CGSize) {
        self.init(frame: CGRect(origin: origin, size: size))
    }
    
    /// 初始化
    /// - Parameters:
    ///   - x: x 坐标
    ///   - y: y 坐标
    ///   - width: 宽度大小
    ///   - height: 高度大小
    public convenience init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: width, height: height))
    }
    
    /// 初始化 默认内边距 0
    /// - Parameters:
    ///   - superView: 父视图
    ///   - padding: 内边距
    public convenience init(superView: UIView, padding: CGFloat = 0) {
        self.init(frame: CGRect(
                    x: superView.kc.x + padding,
                    y: superView.kc.y + padding,
                    width: superView.kc.width - padding*2,
                    height: superView.kc.height - padding*2)
        )
    }
}

//MARK: - frame 扩展
extension KcPrefixWrapper where Base: UIView {
    
    public var x: CGFloat {
        get {
            return base.frame.origin.x
        } set(value) {
            base.frame = CGRect(x: value, y: y, width: width, height: height)
        }
    }
    
    public var y: CGFloat {
        get {
            return base.frame.origin.y
        } set(value) {
            base.frame = CGRect(x: x, y: value, width: width, height: height)
        }
    }
    
    public var width: CGFloat {
        get {
            return base.frame.size.width
        } set(value) {
            base.frame = CGRect(x: x, y: y, width: value, height: height)
        }
    }
    
    public var height: CGFloat {
        get {
            return base.frame.size.height
        } set(value) {
            base.frame = CGRect(x: x, y: y, width: width, height: value)
        }
    }
    
    public var origin: CGPoint {
        get {
            return base.frame.origin
        } set(value) {
            base.frame = CGRect(origin: value, size: base.frame.size)
        }
    }
    
    public var size: CGSize {
        get {
            return base.frame.size
        } set(value) {
            base.frame = CGRect(origin: base.frame.origin, size: value)
        }
    }
    
    public var centerX: CGFloat {
        get {
            return base.center.x
        } set(value) {
            base.center = CGPoint(x: value, y: centerY)
        }
    }
    
    public var centerY: CGFloat {
        get {
            return base.center.y
        } set(value) {
            base.center = CGPoint(x: centerX, y: value)
        }
    }
    
    public var top: CGFloat {
        get {
            return y
        } set(value) {
            y = value
        }
    }
    
    public var left: CGFloat {
        get {
            return x
        } set(value) {
            x = value
        }
    }
    
    public var bottom: CGFloat {
        get {
            return y + height
        } set(value) {
            y = value - height
        }
    }

    public var right: CGFloat {
        get {
            return x + width
        } set(value) {
            x = value - width
        }
    }
    
    public var minX: CGFloat { base.frame.minX }
    public var maxX: CGFloat { base.frame.maxX }
    
    public var minY: CGFloat { base.frame.minY }
    public var maxY: CGFloat { base.frame.maxY }
    
    public func midX(_ width: CGFloat) -> CGFloat { (base.kc.width - width) * 0.5 }
    public func midY(_ height: CGFloat) -> CGFloat { (base.kc.height - height) * 0.5 }
}

//MARK: - 链式属性函数
extension UIView {
    
    /// frame
    /// - Parameter frame: frame
    /// - Returns: 自身
    @discardableResult
    public func frame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }
    
    /// 背景色
    /// - Parameter color: 颜色
    /// - Returns: 自身
    @discardableResult
    public func backColor(_ color: UIColor?) -> Self {
        backgroundColor = color
        return self
    }
    
    /// 背景色
    /// - Parameter hexString: 十六进制颜色值
    /// - Returns: 自身
    @discardableResult
    public func backColor(_ hexString: String) -> Self {
        backgroundColor = UIColor.kc.color(hexString: hexString)
        return self
    }
    
    /// 背景色 默认图片拉伸且不失真
    /// - Parameters:
    ///   - imageName: 图片名称
    ///   - model: 图片模式 默认拉伸
    ///   - undistorted: 是否不失真
    /// - Returns: 自身
    @discardableResult
    func backColor(
        _ imageName: String,
        model: UIImage.ResizingMode = .stretch,
        undistorted: Bool = true
    ) -> Self {
        if model == .stretch {
            if undistorted {
                let ratio = .screenWidth / .screenHeight
                let image = UIImage(named:imageName)?.kc.imageCrop(at: ratio)
                layer.contents = image?.cgImage
            }else {
                layer.contents = UIImage(named:imageName)?.cgImage
            }
        }else {
            backgroundColor = UIColor(image: UIImage(named: imageName)!)
        }
        return self
    }
    
    /// tag 值
    /// - Parameter tag: tag 值
    /// - Returns: 自身
    @discardableResult
    public func tag(_ tag: Int) -> Self {
        self.tag = tag
        return self
    }
    
    /// 透明度
    /// - Parameter alpha: 透明度
    /// - Returns: 自身
    @discardableResult
    public func alpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }
    
    /// 是否隐藏
    /// - Parameter isHidden: 是否隐藏
    /// - Returns: 自身
    @discardableResult
    public func isHidden(_ isHidden: Bool) -> Self {
        self.isHidden = isHidden
        return self
    }
    
    /// 是否支持响应 label & imageView 默认 false
    /// - Parameter enabled: 是否支持响应
    /// - Returns: 自身
    @discardableResult
    public func isUserInteractionEnabled(_ enabled: Bool) -> Self {
        isUserInteractionEnabled = enabled
        return self
    }
    
    /// 圆角
    /// - Parameter radius: 圆角
    /// - Returns: 自身
    @discardableResult
    public func corner(_ radius: CGFloat) -> Self {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        return self
    }
    
    /// 边框宽度
    /// - Parameter width: 宽度
    /// - Returns: 自身
    @discardableResult
    public func borderWidth(_ width: CGFloat) -> Self {
        layer.borderWidth = width
        return self
    }
    
    /// 边框颜色
    /// - Parameter color: 颜色
    /// - Returns: 自身
    @discardableResult
    public func borderColor(_ color: UIColor) -> Self {
        layer.borderColor = color.cgColor
        return self
    }
    
    /// 边框颜色
    /// - Parameter hexString: 十六进制颜色值
    /// - Returns: 自身
    @discardableResult
    public func borderColor(_ hexString: String) -> Self {
        layer.borderColor = UIColor.kc.color(hexString: hexString).cgColor
        return self
    }
    
    /// 显示模式
    /// - Parameter mode: 模式类型
    /// - Returns: 自身
    @discardableResult
    public func contentMode(_ mode: UIView.ContentMode) -> Self {
        contentMode = mode
        return self
    }
    
    /// 是否超出的裁剪 默认 true
    /// - Parameter isClips: 是否裁剪
    /// - Returns: 自身
    @discardableResult
    public func clipsToBounds(_ isClips: Bool = true) -> Self {
        clipsToBounds = isClips
        return self
    }
    
    /// 平移|缩放|旋转 等 transform 动画
    /// - Parameter form: 平移|缩放|旋转
    /// 1. CGAffineTransform 是一个 3*3 的仿射矩阵
    /// - Returns: 自身
    @discardableResult
    public func transform(_ form: CGAffineTransform) -> Self {
        transform = form
        return self
    }
    
    /// 基于 layer 进行的 3D 动画
    /// - Parameter form: 3D 操作
    /// 1. CATransform3D 是一个 4*4 标准变形矩阵
    /// - Returns: 自身
    @discardableResult
    @available(iOS 13.0, *)
    public func transform3D(_ form: CATransform3D) -> Self {
        transform3D = form
        return self
    }
    
    /// 着色
    /// 具有传递性 即: 传递到子视图 若子视图设置 tintColor 则使用子视图 否则使用父视图的 tintColor
    /// 若父子视图都没设置则使用系统的 tintColor 其中系统默认蓝色 如: 系统按钮默认蓝色背景
    /// 对图片可通过其 UIImage.RenderingMode 中的  alwaysTemplate &  tintColor 达到实现指定色值的图片
    /// - Parameter color: 颜色值
    /// - Returns: 自身
    @discardableResult
    public func tintColor(_ color: UIColor) -> Self {
        tintColor = color
        return self
    }
    
    /// 着色
    /// 具有传递性 即: 传递到子视图 若子视图设置 tintColor 则使用子视图 否则使用父视图的 tintColor
    /// 若父子视图都没设置则使用系统的 tintColor 其中系统默认蓝色 如: 系统按钮默认蓝色背景
    /// 对图片可通过其 UIImage.RenderingMode 中的  alwaysTemplate &  tintColor 达到实现指定色值的图片
    /// - Parameter hexString: 十六进制颜色值
    /// - Returns: 自身
    @discardableResult
    public func tintColor(_ hexString: String) -> Self {
        tintColor = UIColor.kc.color(hexString: hexString)
        return self
    }
    
    /// 是否允许多点触摸
    /// - Parameter enable: 是否允许
    /// - Returns: 自身
    @discardableResult
    public func isMultipleTouchEnabled(_ enable: Bool) -> Self {
        isMultipleTouchEnabled = enable
        return self
    }
    
    /// 事件间是否排斥
    /// - Parameter enable: 是否排斥
    /// - Returns: 自身
    @discardableResult
    public func isExclusiveTouch(_ enable: Bool) -> Self {
        isExclusiveTouch = enable
        return self
    }
    
    /// 添加到父视图
    /// - Parameter superView: 父视图
    /// - Returns: 自身
    @discardableResult
    public func addViewTo(_ superView: UIView) -> Self {
        superView.addSubview(self)
        return self
    }
    
    /// 将某个视图移到前面
    /// - Parameter superView: 父视图
    /// - Returns: 自身
    @discardableResult
    public func bringFrontViewTo(_ superView: UIView) -> Self {
        superView.addSubview(self)
        superView.bringSubviewToFront(self)
        return self
    }
    
    /// 将某个视图移到后面
    /// - Parameter superView: 父视图
    /// - Returns: 自身
    @discardableResult
    public func sendBackViewTo(_ superView: UIView) -> Self {
        superView.addSubview(self)
        superView.sendSubviewToBack(self)
        return self
    }
    
    /// 插入视图到某个层级
    /// - Parameter superView: 父视图
    /// - Returns: 自身
    @discardableResult
    public func insertViewTo(_ superView: UIView, at index: Int) -> Self {
        superView.insertSubview(self, at: index)
        return self
    }
    
    /// 插入到某个视图下面
    /// - Parameter superView: 父视图
    /// - Parameter siblingSubview: 同级视图
    /// - Returns: 自身
    @discardableResult
    public func insertViewTo(_ superView: UIView, belowSubview siblingSubview: UIView) -> Self {
        superView.insertSubview(self, belowSubview: siblingSubview)
        return self
    }
    
    /// 插入到某个视图上面
    /// - Parameter superView: 父视图
    /// - Parameter siblingSubview: 同级视图
    /// - Returns: 自身
    @discardableResult
    public func insertViewTo(_ superView: UIView, aboveSubview siblingSubview: UIView) -> Self {
        superView.insertSubview(self, aboveSubview: siblingSubview)
        return self
    }
    
    /// 交换视图层级
    /// - Parameter index1: 第一个层级
    /// - Parameter index2: 第二个层级
    /// - Returns: 自身
    @discardableResult
    public func exchangeView(index1: Int, index2: Int) -> Self {
        exchangeSubview(at: index1, withSubviewAt: index2)
        return self
    }
}

//MARK: - 基础功能
extension KcPrefixWrapper where Base: UIView {
    
    /// View 是否正在显示
    public var isShowing: Bool {
        let keyWindow = UIDevice.kc.keyWindow
        let newFrame = keyWindow!.convert(base.frame, from: base.superview)
        let isIntersects = newFrame.intersects(keyWindow!.bounds);
        return !base.isHidden && base.alpha > 0.01 && base.window == keyWindow && isIntersects
    }
    
    /// 当前 View 所在的控制器
    public var currentVc: UIViewController? {
        var responder: UIResponder? = base
        while responder != nil {
            responder = responder!.next
            if let vc = responder as? UIViewController {
                return vc
            }
        }
        return nil
    }
    
    /// 隐藏键盘
    public func keyboardEndEditing() { base.endEditing(true) }
    
    /// 自适应宽度
    public func resizeToFitWidth() {
        let currentH = height
        base.sizeToFit()
        base.kc.height = currentH
    }
    
    /// 自适应高度
    public func resizeToFitHeight() {
        let currentW = width
        base.sizeToFit()
        base.kc.width = currentW
    }
    
    /// 添加视图集合
    public func addSubviews(_ views: [UIView]) {
        views.forEach { $0.addViewTo(base) }
    }
    
    /// 移除子视图
    public func removeSubviews() {
        base.subviews.forEach { $0.removeFromSuperview() }
    }
    
    /// 移除子视图 layer
    public func removeSubviewLayers() {
        base.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    }
    
    /// 查找父视图
    /// - Parameter type: 父视图类型
    /// - Returns: 父视图
    public func seekSuperView<T: UIView>(of: T.Type) -> T? {
        for view in sequence(first: base.superview, next: { $0?.superview }) {
            if let element = view as? T {
                return element
            }
        }
        return nil
    }
    
    /// 查找子视图
    /// - Parameter type: 子视图类型
    /// - Returns: 子视图
    public func seekSubView(_ type: UIResponder.Type) -> UIResponder? {
        if base.subviews.count == 0 {
            return nil
        }
        for item in base.subviews.enumerated() {
            if item.element.isKind(of: type) {
                return item.element
            }
        }
        return nil
    }
    
    /// View 调试
    /// - Parameters:
    ///   - borderWidth: 边框宽度 默认 1.0
    ///   - borderColor: 边框颜色 默认随机色
    ///   - backColor: 背景色
    public func debugSubviews(
        _ borderWidth: CGFloat = 1.0,
        _ borderColor: UIColor = .colorRandom,
        _ backColor: UIColor = .colorRandom) {
        #if DEBUG
        if base.subviews.count == 0 { return }
        base.subviews.forEach {
            $0.layer.borderWidth = borderWidth
            $0.layer.borderColor = borderColor.cgColor
            $0.backgroundColor = backColor
            $0.kc.debugSubviews(borderWidth, borderColor, backColor)
        }
        #endif
    }
}

//MARK: - 常见功能
extension KcPrefixWrapper where Base: UIView {
    
    /// View 边框 默认 View 四周皆有边框
    /// - Parameters:
    ///   - width: 边框宽度
    ///   - color: 边框颜色
    ///   - position: 边框位置
    public func viewBorder(
        width: CGFloat,
        color: UIColor,
        position: UIView.BorderPosition = .all
    ) {
        switch position {
        case .all:
            base.layer.borderWidth = width
            base.layer.borderColor = color.cgColor
        default:
            var viewX: CGFloat = 0.0, viewY: CGFloat = 0.0;
            var viewW: CGFloat = base.kc.width, viewH: CGFloat = base.kc.height;
            if position == .top {
                viewH = width
            }else if position == .left {
                viewW = width
            }else if position == .bottom {
                viewY = self.height - width
                viewH = width
            }else if position == .right {
                viewX = self.width - width
                viewW = width
            }
            let borderLayer = CALayer()
            borderLayer.backgroundColor = color.cgColor
            borderLayer.frame = CGRect(x: viewX, y: viewY, width: viewW, height: viewH)
            base.layer.addSublayer(borderLayer)
        }
    }
    
    /// View 圆角  默认 View 四周皆有圆角
    /// - Parameters:
    ///   - size: View 宽高
    ///   - radius: 圆角大小
    ///   - corner: 圆角位置
    public func viewCorner(
        size: CGSize,
        radius: CGFloat,
        corner: UIRectCorner = .allCorners
    ) {
        let path = UIBezierPath(
            roundedRect: CGRect(origin: .zero, size: size),
            byRoundingCorners: corner,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRect(origin: .zero, size: size)
        shapeLayer.path = path.cgPath
        base.layer.mask = shapeLayer
    }
    
    /// View 阴影 默认偏移量 (0, -3)
    /// - Parameters:
    ///   - color: 阴影颜色
    ///   - opacity: 透明度 默认 0
    ///   - radius: 半径 默认 3
    ///   - offset: 偏移量 默认 (0, -3) 其中 X 正右负左 Y 正下负上
    public func viewShadow(
        color: UIColor,
        opacity: Float = 0.0,
        radius: CGFloat = 3,
        offset: CGSize = CGSize(width: 0, height: -3)
    ) {
        base.layer.shadowColor   = color.cgColor
        base.layer.shadowOpacity = opacity
        base.layer.shadowRadius  = radius
        base.layer.shadowOffset  = offset
    }
    
    /// View 圆角和阴影
    /// - Parameters:
    ///   - superview: 父视图
    ///   - rect: View  对应的 Frame
    ///   - radius: 圆角大小
    ///   - corner: 圆角位置
    ///   - shadowColor: 阴影颜色
    ///   - shadowOpacity: 阴影透明度 默认 0
    ///   - shadowRadius: 阴影半径 默认 3
    ///   - shadowOffset: 阴影偏移量 默认 (0, -3) 其中 X 正右负左 Y 正下负上
    public func viewCornerShadow(
        superview: UIView,
        rect: CGRect,
        radius: CGFloat,
        corner: UIRectCorner,
        shadowColor: UIColor,
        shadowOpacity: Float,
        shadowRadius: CGFloat,
        shadowOffset: CGSize
    ) {
        viewCorner(size: rect.size, radius: radius, corner: corner)
        let subLayer = CALayer()
        subLayer.frame = rect
        subLayer.cornerRadius    = radius
        subLayer.backgroundColor = shadowColor.cgColor
        subLayer.masksToBounds   = false
        subLayer.shadowColor     = shadowColor.cgColor
        subLayer.shadowOpacity   = shadowOpacity
        subLayer.shadowRadius    = shadowRadius
        subLayer.shadowOffset    = shadowOffset
        superview.layer.insertSublayer(subLayer, below: base.layer)
    }
    
    /// View 圆环
    /// - Parameters:
    ///   - strokeWidth: 外环宽度
    ///   - strokeColor: 外环颜色
    ///   - fillColor: 内环颜色
    public func viewLoop(strokeWidth: CGFloat, strokeColor: UIColor, fillColor: UIColor) {
        let radius = min(width, height)
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(x: 0, y: 0, width: radius, height: radius),
            cornerRadius: radius * 0.5
        )
        let shapeLayer  = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.lineWidth   = strokeWidth
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.fillColor   = fillColor.cgColor
        base.layer.addSublayer(shapeLayer)
    }
    
    /// View 抖动
    /// - Parameters:
    ///   - direction: 抖动方向
    ///   - duration: 动画时间
    ///   - repeatCount: 抖动次数
    ///   - offset: 偏移量
    public func viewShake(
        direction: UIView.ShakeDirection = .horizontal,
        duration: TimeInterval = 0.1,
        repeatCount: Float = 1,
        offset: CGFloat = 2
    ) {
        var fromValue: CGPoint!
        var toValue: CGPoint!
        switch direction {
        case .horizontal:
            fromValue = CGPoint(x: base.layer.position.x + offset, y: base.layer.position.y)
            toValue = CGPoint(x: base.layer.position.x - offset, y: base.layer.position.y)
        case .vertical:
            fromValue = CGPoint(x: base.layer.position.x, y: base.layer.position.y + offset)
            toValue = CGPoint(x: base.layer.position.x, y: base.layer.position.y - offset)
        }
        base.layer.kc.basicAnimationKeyPath(
            keyPath: "position",
            fromValue: fromValue,
            toValue: toValue,
            duration: duration,
            delay: 0,
            repeatCount: repeatCount,
            fillMode: .forwards,
            removedOnCompletion: true,
            option: .easeInEaseOut,
            animationKey: nil
        )
    }
    
    /// View 截屏 针对 View | UIScrollView | WKWebView 等视图
    /// - Returns: 图片
    public func viewCapture() -> UIImage? {
        if base.isKind(of: UIScrollView.self) ||
            base.isKind(of: UITableView.self) ||
            base.isKind(of: UICollectionView.self) {
            let view = base as! UIScrollView
            let viewFrame = view.frame
            let viewOffset = view.contentOffset
            if view.contentSize.height > view.kc.height {
                view.contentOffset = CGPoint(x: 0, y: view.contentSize.height - view.kc.height)
            }
            view.frame = CGRect(
                x: 0,
                y: 0,
                width: view.kc.width,
                height: view.contentSize.height
            )
            view.contentOffset = .zero
            
            UIGraphicsBeginImageContextWithOptions(view.kc.size, true, .screenScale)
            let context = UIGraphicsGetCurrentContext()
            guard let ctx = context else {
                UIGraphicsEndImageContext()
                return nil
            }
            base.layer.render(in: ctx)
            guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
                UIGraphicsEndImageContext()
                return nil
            }
            UIGraphicsEndImageContext()
            view.contentOffset = viewOffset
            view.frame = viewFrame
            return image
        }else if base.isKind(of: WKWebView.self) {
            let view = base as! WKWebView
            let snapshotView = view.snapshotView(afterScreenUpdates: true)!
            snapshotView.frame = CGRect(
                x: view.kc.x,
                y: view.kc.y,
                width: view.kc.width,
                height: view.kc.height
            )
            base.superview?.addSubview(snapshotView)
            
            let viewFrame  = view.frame
            let viewSize   = view.scrollView.contentSize
            let viewOffset = view.scrollView.contentOffset
            let snapCount  = floorf(Float(viewSize.height / view.scrollView.kc.height))
            view.frame = CGRect(
                origin: .zero,
                size: CGSize(width: viewSize.width, height: viewSize.height)
            )
            view.scrollView.contentOffset = .zero
            
            UIGraphicsBeginImageContextWithOptions(viewSize, true, .screenScale)
            for idx in 0..<snapCount.kc.toInt {
                let snapFrame = CGRect(
                    x: 0,
                    y: CGFloat(idx)*view.kc.height,
                    width: view.kc.width,
                    height: view.kc.height
                )
                var rect = view.frame
                rect.origin.y = -(CGFloat(idx)*view.kc.height)
                view.frame = rect
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
                    view.drawHierarchy(in: snapFrame, afterScreenUpdates: true)
                }
            }
            snapshotView.removeFromSuperview()
            guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
                UIGraphicsEndImageContext()
                return nil
            }
            UIGraphicsEndImageContext()
            view.scrollView.contentOffset = viewOffset
            view.frame = viewFrame
            return image
        }else {
            UIGraphicsBeginImageContextWithOptions(size, true, .screenScale)
            let context = UIGraphicsGetCurrentContext()
            guard let ctx = context else {
                UIGraphicsEndImageContext()
                return nil
            }
            base.layer.render(in: ctx)
            guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
                UIGraphicsEndImageContext()
                return nil
            }
            UIGraphicsEndImageContext()
            return image
        }
    }
}

//MARK: - 旋转|缩放|叠加|反转
extension KcPrefixWrapper where Base: UIView {
    
    /// View transform 平移&缩放等形变 默认动画
    ///  其中缩放: 以 layer 中心对称变化, 正常大小为 1
    ///  若 x 为负 则 layer 在原缩放基础上沿穿过其中心的竖直线翻转
    ///  若 y 为负 则 layer 在原缩放基础上沿穿过其中心的水平线翻转
    /// - Parameters:
    ///   - mode: 形变类型
    ///   - x: x 轴  针对平移 & 缩放
    ///   - y: y 轴 针对平移 & 缩放
    ///   - isReversed: 是否反转
    ///   - animated: 是否添加动画
    public func viewTransform(
        mode: UIView.AnimationMode,
        x: CGFloat,
        y: CGFloat,
        isReversed: Bool = false,
        animated: Bool = true
    ) {
        var transform = CATransform3DIdentity
        switch mode {
        case .translation:
            let block: (() -> ()) = {
                transform = CATransform3DTranslate(transform, x, y, 0)
                if isReversed {
                    transform = CATransform3DInvert(transform)
                }
                self.base.layer.transform = transform
            }
            if animated {
                UIView.animate(withDuration: 1) {
                    block()
                }
            }else {
                block()
            }
        case .scale:
            let block: (() -> ()) = {
                transform = CATransform3DScale(transform, x, y, 1)
                if isReversed {
                    transform = CATransform3DInvert(transform)
                }
                self.base.layer.transform = transform
            }
            if animated {
                UIView.animate(withDuration: 1) {
                    block()
                }
            }else {
                block()
            }
        default: break
        }
    }
    
    /// View transform 旋转形变 其中垂直屏幕方向为 z 轴
    ///  其中旋转一般需设置其透视效果(m34)来达到明显效果 其中 m34= -1/D D越小 透视效果越明显
    ///  旋转参数 x & y & z 取值[-1, 1], x 轴旋转(1, 0, 0)  y 轴旋转(0, 1, 0)  z 轴旋转(0, 0, 1)
    /// - Parameters:
    ///   - mode: 形变类型
    ///   - angles: 角度集合 取值(0-360)
    ///   1.  其中集合数量务必是 3 即第1个代表 x 轴  第2个代表 y 轴  第3个代表 z 轴
    ///   - isReversed: 是否反转
    ///   - animated: 是否添加动画
    public func viewTransform(
        rotation mode: UIView.AnimationMode,
        angles: [CGFloat]?,
        isReversed: Bool = false,
        animated: Bool = true
    ) {
        var transform = CATransform3DIdentity
        switch mode {
        case .rotation:
            transform.m34 = -1.0 / 500.0
            let block: (() -> ()) = {
                if let angle = angles {
                    assert(angle.count == 3, "angles count must is 3")
                    transform = CATransform3DRotate(transform, angle[0].kc.toRadians, 1.0, 0.0, 0.0)
                    transform = CATransform3DRotate(transform, angle[1].kc.toRadians, 0.0, 1.0, 0.0)
                    transform = CATransform3DRotate(transform, angle[2].kc.toRadians, 0.0, 0.0, 1.0)
                    self.base.layer.transform = transform
                }
            }
            if animated {
                UIView.animate(withDuration: 1) {
                    block()
                }
            }else {
                block()
            }
        case .rotationX:
            transform.m34 = -1.0 / 500.0
            let block: (() -> ()) = {
                if let angle = angles {
                    assert(angle.count == 3, "angles count must is 3")
                    transform = CATransform3DRotate(transform, angle[0].kc.toRadians, 1.0, 0.0, 0.0)
                    if isReversed {
                        transform = CATransform3DInvert(transform)
                    }
                    self.base.layer.transform = transform
                }
            }
            if animated {
                UIView.animate(withDuration: 1) {
                    block()
                }
            }else {
                block()
            }
        case .rotationY:
            transform.m34 = -1.0 / 500.0
            let block: (() -> ()) = {
                if let angle = angles {
                    assert(angle.count == 3, "angles count must is 3")
                    transform = CATransform3DRotate(transform, angle[1].kc.toRadians, 0.0, 1.0, 0.0)
                    if isReversed {
                        transform = CATransform3DInvert(transform)
                    }
                    self.base.layer.transform = transform
                }
            }
            if animated {
                UIView.animate(withDuration: 1) {
                    block()
                }
            }else {
                block()
            }
        case .rotationZ:
            let block: (() -> ()) = {
                if let angle = angles {
                    assert(angle.count == 3, "angles count must is 3")
                    transform = CATransform3DRotate(transform, angle[2].kc.toRadians, 0.0, 0.0, 1.0)
                    if isReversed {
                        transform = CATransform3DInvert(transform)
                    }
                    self.base.layer.transform = transform
                }
            }
            if animated {
                UIView.animate(withDuration: 1) {
                    block()
                }
            }else {
                block()
            }
        default:
            break
        }
    }
    
    /// View 形变叠加
    /// - Parameters:
    ///   - lhs: 第一个形变
    ///   - rhs: 第二个形变
    ///   - animated: 是否添加动画
    public func viewTransformConcat(
        lhs: CATransform3D,
        rhs: CATransform3D,
        animated: Bool = true
    ) {
        let block: (() -> ()) = {
            self.base.layer.transform = CATransform3DConcat(lhs, rhs)
        }
        if animated {
            UIView.animate(withDuration: 1) {
                block()
            }
        }else {
            block()
        }
    }
}

//MARK: - 点击事件
extension KcPrefixWrapper where Base: UIView {
    
    /// View 事件点击  默认响应间隔 1.0s
    /// - Parameters:
    ///   - target: 响应对象
    ///   - action: 事件
    ///   - interval: 允许的点击间隔 默认 1.0s
    ///   - isExclusion: 事件之间是否互斥 默认互斥
    public func clickAction(
        _ target: Any,
        _ action: @escaping (() -> ()),
        interval: TimeInterval = 1.0,
        isExclusion: Bool = true) {
        var gesture = objc_getAssociatedObject(
            self,
            &Base.AssociatedKey.associatedTapGesture
        )
        if gesture == nil {
            gesture = UITapGestureRecognizer(
                target: self,
                action: #selector(base.clickMethod(_:))
            )
            base.addGestureRecognizer(gesture as! UIGestureRecognizer)
            objc_setAssociatedObject(
                self,
                &Base.AssociatedKey.associatedTapGesture,
                gesture,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
        base.clickInterval = interval
        base.isExclusiveTouch = isExclusion
        base.isUserInteractionEnabled = true
        objc_setAssociatedObject(
            self,
            &Base.AssociatedKey.associatedTapAction,
            action,
            .OBJC_ASSOCIATION_COPY_NONATOMIC
        )
    }
}

fileprivate extension UIView {
    
    @objc func clickMethod(_ gesture: UITapGestureRecognizer) {
        if Date().timeIntervalSince1970 - clickLastTime < clickInterval { return }
        clickLastTime = Date().timeIntervalSince1970
        if gesture.state == .recognized {
            if let clickEvent = objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedTapAction
            ) as? (() -> (Void)) {
                clickEvent()
            }
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
        static var associatedTapAction: Void?
        static var associatedTapGesture: Void?
    }
}

//MARK: - 添加手势
extension KcPrefixWrapper where Base: UIView {
    
    /// 单击手势
    /// - Parameter action: 事件
    public func addTap(_ action: @escaping (UITapGestureRecognizer) -> Void) {
        UITapGestureRecognizer()
            .addGestureTo(base)
            .kc.addGesture { gesture in
                action(gesture as! UITapGestureRecognizer)
            }
        base.isUserInteractionEnabled(true)
            .isMultipleTouchEnabled(true)
    }
    
    /// 长按手势 长按时长默认 0.5
    /// - Parameters:
    ///   - duration: 长按时间
    ///   - action: 事件
    public func addLongPress(
        _ duration: TimeInterval = 0.5,
        _ action: @escaping (UILongPressGestureRecognizer) -> Void
    ) {
        UILongPressGestureRecognizer()
            .minimumPressDuration(duration)
            .addGestureTo(base)
            .kc.addGesture { gesture in
                action(gesture as! UILongPressGestureRecognizer)
            }
        base.isUserInteractionEnabled(true)
            .isMultipleTouchEnabled(true)
    }
    
    /// 拖拽手势 最大触摸手指数 2
    /// - Parameter action: 事件
    public func addPan(_ action: @escaping (UIPanGestureRecognizer) -> Void) {
        UIPanGestureRecognizer()
            .maximumNumberOfTouches(2)
            .kc.addGesture { gesture in
                if let sender = gesture as? UIPanGestureRecognizer,
                   let senderView = sender.view {
                    let translate: CGPoint = sender.translation(in: senderView.superview)
                    senderView.center = CGPoint(
                        x: senderView.center.x + translate.x,
                        y: senderView.center.y + translate.y
                    )
                    sender.setTranslation(.zero, in: senderView.superview)
                    action(gesture as! UIPanGestureRecognizer)
                }
            }
        base.isUserInteractionEnabled(true)
            .isMultipleTouchEnabled(true)
    }
    
    /// 清扫手势 默认向右清扫
    /// - Parameters:
    ///   - action: 事件
    ///   - direction: 清扫方向
    public func addSwip(
        _ action: @escaping (UISwipeGestureRecognizer) -> Void,
        direction: UISwipeGestureRecognizer.Direction = .right
    ) {
        UISwipeGestureRecognizer()
            .direction(direction)
            .kc.addGesture { gesture in
                action(gesture as! UISwipeGestureRecognizer)
            }
        base.isUserInteractionEnabled(true)
            .isMultipleTouchEnabled(true)
    }
    
    /// 捏合手势
    /// - Parameter action: 事件
    public func addPinch(_ action: @escaping (UIPinchGestureRecognizer) -> Void) {
        UIPinchGestureRecognizer()
            .addGestureTo(base)
            .kc.addGesture { gesture in
                if let sender = gesture as? UIPinchGestureRecognizer {
                    let location = gesture.location(in: sender.view!.superview)
                    let view = sender.view!
                    view.center = location
                    view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
                    sender.scale = 1.0
                    action(gesture as! UIPinchGestureRecognizer)
                }
            }
        base.isUserInteractionEnabled(true)
            .isMultipleTouchEnabled(true)
    }
    
    /// 旋转手势
    /// - Parameter action: 事件
    public func addRotation(_ action: @escaping (UIRotationGestureRecognizer) -> Void) {
        UIRotationGestureRecognizer()
            .addGestureTo(base)
            .kc.addGesture { gesture in
                if let sender = gesture as? UIRotationGestureRecognizer {
                    sender.view!.transform = sender.view!.transform.rotated(by: sender.rotation)
                    sender.rotation = 0.0
                    action(gesture as! UIRotationGestureRecognizer)
                }
            }
        base.isUserInteractionEnabled(true)
            .isMultipleTouchEnabled(true)
    }
    
    /// 清扫屏幕边缘手势
    /// - Parameters:
    ///   - action: 事件
    ///   - edgs: 边缘位置
    public func addEdge(
        _ action: @escaping (UIScreenEdgePanGestureRecognizer) -> Void,
        edgs: UIRectEdge
    ) {
        UIScreenEdgePanGestureRecognizer()
            .edges(edgs)
            .addGestureTo(base)
            .kc.addGesture { gesture in
                action(gesture as! UIScreenEdgePanGestureRecognizer)
            }
        base.isUserInteractionEnabled(true)
            .isMultipleTouchEnabled(true)
    }
}
