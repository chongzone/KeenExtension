//
//  CALayer+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/6/18.
//

import UIKit

extension CALayer {
    
    /// 常见的动画类型模式
    public enum AnimationMode: String {
        /// 缩放 x & y & z
        case scale = "transform.scale"
        /// 缩放 x
        case scaleX = "transform.scale.x"
        /// 缩放 y
        case scaleY = "transform.scale.y"
        /// 缩放 z
        case scaleZ = "transform.scale.z"
        /// 旋转 x & y & z
        case rotation = "transform.rotation"
        /// 旋转 x
        case rotationX = "transform.rotation.x"
        /// 旋转 y
        case rotationY = "transform.rotation.y"
        /// 旋转 z
        case rotationZ = "transform.rotation.z"
        /// 移动 x & y
        case translation = "transform.translation"
        /// 移动 x
        case translationX = "transform.translation.x"
        /// 移动 y
        case translationY = "transform.translation.y"
        /// 圆角
        case cornerRadius = "cornerRadius"
        /// 某点 Point
        case position = "position"
    }
}

//MARK: - CALayer 链式属性函数
extension KcPrefixWrapper where Base: CALayer {
    
    /// frame
    /// - Parameter frame: frame
    /// - Returns: 自身
    @discardableResult
    public func frame(_ frame: CGRect) -> Self {
        base.frame = frame
        return self
    }
    
    /// bounds
    /// - Parameter bounds: bounds
    /// - Returns: 自身
    @discardableResult
    public func bounds(_ bounds: CGRect) -> Self {
        base.bounds = bounds
        return self
    }
    
    /// 背景色
    /// - Parameter color: 颜色
    /// - Returns: 自身
    @discardableResult
    public func backColor(_ color: UIColor) -> Self {
        base.backgroundColor = color.cgColor
        return self
    }
    
    /// 背景色
    /// - Parameter hexString: 十六进制颜色
    /// - Returns: 自身
    @discardableResult
    public func backColor(_ hexString: String) -> Self {
        base.backgroundColor = UIColor.kc.color(hexString: hexString).cgColor
        return self
    }
    
    /// 是否隐藏
    /// - Parameter isHidden: 是否隐藏
    /// - Returns: 自身
    @discardableResult
    public func isHidden(_ isHidden: Bool) -> Self {
        base.isHidden = isHidden
        return self
    }
    
    /// 圆角 默认裁剪
    /// - Parameter radius: 圆角
    /// - Parameter mask: 是否裁剪
    /// - Returns: 自身
    @discardableResult
    public func corner(_ radius: CGFloat, mask: Bool = true) -> Self {
        base.cornerRadius = radius
        base.masksToBounds = mask
        return self
    }
    
    /// 边框宽度
    /// - Parameter width: 宽度
    /// - Returns: 自身
    @discardableResult
    public func borderWidth(_ width: CGFloat) -> Self {
        base.borderWidth = width
        return self
    }
    
    /// 边框颜色
    /// - Parameter color: 颜色
    /// - Returns: 自身
    @discardableResult
    public func borderColor(_ color: UIColor) -> Self {
        base.borderColor = color.cgColor
        return self
    }
    
    /// 阴影颜色
    /// - Parameter color: 颜色
    /// - Returns: 自身
    @discardableResult
    public func shadowColor(_ color: UIColor) -> Self {
        base.shadowColor = color.cgColor
        return self
    }
    
    /// 阴影的透明度
    /// - Parameter opacity: 透明度
    /// - Returns: 自身
    @discardableResult
    public func shadowOpacity(_ opacity: Float) -> Self {
        base.shadowOpacity = opacity
        return self
    }
    
    /// 阴影偏移量
    /// - Parameter offset: 偏移量
    /// - Returns: 自身
    @discardableResult
    public func shadowOffset(_ offset: CGSize) -> Self {
        base.shadowOffset = offset
        return self
    }
    
    /// 阴影圆角
    /// - Parameter radius: 圆角
    /// - Returns: 自身
    @discardableResult
    public func shadowRadius(_ radius: CGFloat) -> Self {
        base.shadowRadius = radius
        return self
    }
    
    /// 添加阴影避免离屏渲染 size 为其图层大小
    /// - Parameter size: 图层大小
    /// - Returns: 自身
    @discardableResult
    public func shadowPath(_ size: CGSize) -> Self {
        base.shadowPath = UIBezierPath(
            rect: CGRect(x: 0, y: 0, width: size.width, height: size.height)
        ).cgPath
        return self
    }
    
    /// 是否开启光栅化 默认不开启
    /// - Parameter rasterize: 是否开启
    /// - Returns: 自身
    @discardableResult
    public func shouldRasterize(_ rasterize: Bool = false) -> Self {
        base.shouldRasterize = rasterize
        return self
    }
    
    /// 光栅化比例
    /// - Parameter scale: 比例
    /// - Returns: 自身
    @discardableResult
    public func rasterizationScale(_ scale: CGFloat) -> Self {
        base.rasterizationScale = scale
        base.shouldRasterize = true
        return self
    }
    
    /// 以父层左上角为原点 设置其在父层的位置 默认 zero
    /// - Parameter position: position
    /// - Returns: 自身
    @discardableResult
    public func position(_ position: CGPoint = .zero) -> Self {
        base.position = position
        return self
    }
    
    /// 调整视图层级关系 默认 0 即在底层
    /// 只能调整同级别的视图层级关系 不能调整父子关系的视图层级
    /// - Parameter zPosition: zPosition
    /// - Returns: 自身
    @discardableResult
    public func zPosition(_ zPosition: CGFloat = 0) -> Self {
        base.zPosition = zPosition
        return self
    }
    
    /// 锚点 默认(0.5, 0.5)
    /// 视图旋转按着其锚点进行 默认按中心点旋转
    /// - Parameter anchorPoint: 锚点
    /// - Returns: 自身
    @discardableResult
    public func anchorPoint(_ anchorPoint: CGPoint = CGPoint(x: 0.5, y: 0.5)) -> Self {
        base.anchorPoint = anchorPoint
        return self
    }
    
    /// 基于 layer 进行 3D 动画
    /// - Parameter form: 3D 动画
    /// - Returns: 自身
    @discardableResult
    public func transform3D(_ form: CATransform3D) -> Self {
        base.transform = form
        return self
    }
    
    /// 添加到父视图
    /// - Parameter superView: 父视图
    /// - Returns: 自身
    @discardableResult
    public func addLayerTo(_ superView: UIView) -> Self {
        superView.layer.addSublayer(base)
        return self
    }
    
    /// 添加到父视图层
    /// - Parameter superLayer: 父视图层
    /// - Returns: 自身
    @discardableResult
    public func addLayerTo(_ superLayer: CALayer) -> Self {
        superLayer.addSublayer(base)
        return self
    } 
}

//MARK: - CAShapeLayer 链式属性函数
extension KcPrefixWrapper where Base: CAShapeLayer {
 
    /// 设置路径 决定了其形状
    /// - Parameters:
    ///   - path: 路径
    /// - Returns: 自身
    @discardableResult
    public func path(_ path: CGPath) -> Self {
        base.path = path
        return self
    }
    
    /// 填充色
    /// - Parameters:
    ///   - color: 填充色
    /// - Returns: 自身
    @discardableResult
    public func fillColor(_ color: UIColor) -> Self {
        base.fillColor = color.cgColor
        return self
    }
    
    /// 填充角色
    /// - Parameters:
    ///   - rule: 角色
    /// - Returns: 自身
    @discardableResult
    public func fillRule(_ rule: CAShapeLayerFillRule) -> Self {
        base.fillRule = rule
        return self
    }
    
    /// 线条颜色
    /// - Parameters:
    ///   - color: 线条颜色
    /// - Returns: 自身
    @discardableResult
    public func strokeColor(_ color: UIColor) -> Self {
        base.strokeColor = color.cgColor
        return self
    }
    
    /// 路径起点的相对位置 0-1 默认 0
    /// - Parameters:
    ///   - start: 开始位置 
    /// - Returns: 自身
    @discardableResult
    public func strokeStart(_ start: CGFloat) -> Self {
        base.strokeStart = start
        return self
    }
    
    /// 路径终点的相对位置 0-1 默认 1
    /// - Parameters:
    ///   - end: 结束位置
    /// - Returns: 自身
    @discardableResult
    public func strokeEnd(_ end: CGFloat) -> Self {
        base.strokeEnd = end
        return self
    }
    
    /// 设置线宽
    /// - Parameters:
    ///   - width: 线宽
    /// - Returns: 自身
    @discardableResult
    public func lineWidth(_ width: CGFloat) -> Self {
        base.lineWidth = width
        return self
    }
    
    /// path 终点样式 butt(无样式) round(圆形) square(方形)
    /// - Parameters:
    ///   - cap: 终点样式
    /// - Returns: 自身
    @discardableResult
    public func lineCap(_ cap: CAShapeLayerLineCap) -> Self {
        base.lineCap = cap
        return self
    }
    
    /// 路径连接部分的拐角样式 miter(尖状) round(圆形) bevel(平形)
    /// - Parameters:
    ///   - join: 拐角样式
    /// - Returns: 自身
    @discardableResult
    public func lineJoin(_ join: CAShapeLayerLineJoin) -> Self {
        base.lineJoin = join
        return self
    }
    
    /// 虚线起始位置
    /// - Parameters:
    ///   - start: 虚线起始位置
    /// - Returns: 自身
    @discardableResult
    public func lineDashPhase(_ start: CGFloat) -> Self {
        base.lineDashPhase = start
        return self
    }
    
    /// 虚线数组
    /// - Parameters:
    ///   - dashs: 虚线宽度数组  [lineW1,  lineW2, lineW3, ...]
    /// - Returns: 自身
    @discardableResult
    public func lineDashPattern(_ dashs: [NSNumber]) -> Self {
        base.lineDashPattern = dashs
        return self
    }
}

//MARK: - CATextLayer 链式属性函数
extension KcPrefixWrapper where Base: CATextLayer {
    
    /// 内容
    /// - Parameters:
    ///   - text: 内容
    /// - Returns: 自身
    @discardableResult
    public func text(_ text: String) -> Self {
        base.string = text
        return self
    }
    
    /// 富文本内容
    /// - Parameter attributedText: 富文本
    /// - Returns: 自身
    @discardableResult
    public func attributedText(_ attributedText: NSAttributedString) -> Self {
        base.string = attributedText
        return self
    }
    
    /// 字体 默认常规
    /// - Parameters:
    ///   - fontSize: 字体大小
    ///   - style: 字体样式
    /// - Returns: 自身
    @discardableResult
    public func font(_ fontSize: CGFloat, _ style: UIFont.FontStyle = .normal) -> Self {
        base.fontSize = fontSize
        base.font = UIFont.fontSizeAdapter(fontSize, style)
        base.contentsScale = UIScreen.main.scale
        return self
    }
    
    /// 颜色
    /// - Parameter color: 颜色
    /// - Returns: 自身
    @discardableResult
    public func color(_ color: UIColor) -> Self {
        base.foregroundColor = color.cgColor
        return self
    }
    
    /// 颜色
    /// - Parameter hexString: 十六进制颜色
    /// - Returns: 自身
    @discardableResult
    public func color(_ hexString: String) -> Self {
        base.foregroundColor = UIColor.kc.color(hexString: hexString).cgColor
        return self
    }
    
    /// 截取模式
    /// - Parameter mode: 模式
    /// - Returns: 自身
    @discardableResult
    public func truncationMode(_ mode: CATextLayerTruncationMode) -> Self {
        base.truncationMode = mode
        return self
    }
    
    /// 对齐方式 默认靠左
    /// - Parameter alignment: 对齐方式
    /// - Returns: 自身
    @discardableResult
    public func alignment(_ alignment: NSTextAlignment = .left) -> Self {
        switch alignment {
        case .left:
            base.alignmentMode = .left
        case .right:
            base.alignmentMode = .right
        case .center:
            base.alignmentMode = .center
        case .natural:
            base.alignmentMode = .natural
        case .justified:
            base.alignmentMode = .justified
        default:
            base.alignmentMode = .left
        }
        return self
    }
    
    /// 是否自动换行 默认 false
    /// - Parameter isWrapped: 是否自动换行
    /// - Returns: 自身
    @discardableResult
    public func isWrapped(_ isWrapped: Bool = false) -> Self {
        base.isWrapped = isWrapped
        return self
    }
}

//MARK: - CALayer 动画扩展
extension KcPrefixWrapper where Base: CALayer {
    
    //MARK: - CABasicAnimation 基础动画
    
    /// 常见的基本动画
    /// - Parameters:
    ///   - mode: 动画类型
    ///   - fromValue: 开始值
    ///   - toValue: 结束值
    ///   - duration: 动画持续时间 单位 s
    ///   - delay: 延迟时间 单位 s
    ///   - repeatCount: 动画重复次数
    ///   - fillMode: 动画填充模式 默认 forwards
    ///   - autoreverses: 动画结束是否自动反向运动 默认 false
    ///   - removedOnCompletion: 结束后是否回到原状态 默认 false
    ///   - option: 动画的控制方式
    ///   - animationKey: 控制动画执行对应的key
    public func basicAnimationMode(
        _ mode: CALayer.AnimationMode,
        fromValue: Any?,
        toValue: Any?,
        duration: TimeInterval = 2.0,
        delay: TimeInterval = 0,
        repeatCount: Float = 1,
        fillMode: CAMediaTimingFillMode = .forwards,
        autoreverses: Bool = false,
        removedOnCompletion: Bool = false,
        option: CAMediaTimingFunctionName = .default,
        animationKey: String?
    ) {
        var keyPath: String!
        switch mode {
        case .scale: keyPath = Base.AnimationMode.scale.rawValue
        case .scaleX: keyPath = Base.AnimationMode.scaleX.rawValue
        case .scaleY: keyPath = Base.AnimationMode.scaleY.rawValue
        case .scaleZ: keyPath = Base.AnimationMode.scaleZ.rawValue
        case .rotation: keyPath = Base.AnimationMode.rotation.rawValue
        case .rotationX: keyPath = Base.AnimationMode.rotationX.rawValue
        case .rotationY: keyPath = Base.AnimationMode.rotationY.rawValue
        case .rotationZ: keyPath = Base.AnimationMode.rotationZ.rawValue
        case .translation: keyPath = Base.AnimationMode.translation.rawValue
        case .translationX: keyPath = Base.AnimationMode.translationX.rawValue
        case .translationY: keyPath = Base.AnimationMode.translationY.rawValue
        case .position: keyPath = Base.AnimationMode.position.rawValue
        case .cornerRadius: keyPath = Base.AnimationMode.cornerRadius.rawValue
        }
        basicAnimationKeyPath(
            keyPath: keyPath,
            fromValue: fromValue,
            toValue: toValue,
            duration: duration,
            delay: delay,
            repeatCount: repeatCount,
            fillMode: fillMode,
            autoreverses: autoreverses,
            removedOnCompletion: removedOnCompletion,
            option: option,
            animationKey: animationKey
        )
    }
    
    /// 基础动画配置 默认配置: 执行 1 次 时长 2s 无延迟 效果慢进慢出
    /// - Parameters:
    ///   - keyPath: 动画类型 其部分取值
    ///   1. 平移 transform.translation(x&y 平移) transform.translation.x(x 平移) transform.translation.y(y 平移)
    ///   2. 缩放 transform.scale(x&y&z 缩放) transform.scale.x(x 缩放) transform.scale.y(y 缩放) transform.scale.z(z 缩放)
    ///   3. 旋转 transform.rotation(x&y&z 旋转) transform.rotation.x(x 旋转) transform.rotation.y(y 旋转) transform.rotation.z(z 旋转)
    ///   4. 大小 frame | bounds | bounds.size | hidden | cornerRadius | borderWidth |  position | mask | masksToBounds
    ///   5. shadowColor | shadowOffset | shadowOpacity | shadowRadius | contents | contentsRect | zPosition
    ///   6. opacity(透明度) strokeEnd(进度条) backgroundColor(背景色)
    ///   - fromValue: 开始值
    ///   - toValue: 结束值
    ///   - duration: 动画持续时间 单位 s
    ///   - delay: 延迟时间 单位 s
    ///   - repeatCount: 动画重复次数
    ///   - fillMode: 动画填充模式 默认 forwards
    ///   1. forwards(对应 toValue 动画结束图层保持 toValue 状态)
    ///   2. backwards(对应 fromValue 动画开始前图层会一直保持 fromValue 状态)
    ///   3. both(对应 fromValue & toValue 是 forwards & backwards 结合)
    ///   4. removed(默认属性 对图层无影响 动画结束图层恢复原有的状态)
    ///   - speed: 动画速度 默认 1.0 若速度为 0 且设置对应的 timeOffset 则可暂停动画
    ///   - timeOffset: 附加的偏移量 默认 0
    ///   1. 若在动画时间内控件状态(a b c) 当其为 0 则执行顺序 a b c 当为 1 则执行顺序 b c a ...
    ///   - repeatDuration: 动画重复的时长 默认 0
    ///   - autoreverses: 动画结束是否自动反向运动 默认 false
    ///   - isCumulative: 是否累计动画 默认 false
    ///   - removedOnCompletion: 结束后是否回到原状态 默认 false
    ///   - option: 动画的控制方式
    ///   1. (linear: 匀速) | (easeIn: 慢进) | (easeOut: 慢出) | (easeInEaseOut: 慢进慢出) | (default: 慢进慢出)
    ///   - animationKey: 控制动画执行对应的key
    public func basicAnimationKeyPath(
        keyPath: String,
        fromValue: Any?,
        toValue: Any?,
        duration: TimeInterval = 2.0,
        delay: TimeInterval = 0,
        repeatCount: Float = 1,
        fillMode: CAMediaTimingFillMode = .forwards,
        speed: Float = 1.0,
        timeOffset: TimeInterval = 0,
        repeatDuration: TimeInterval = 0,
        autoreverses: Bool = false,
        isCumulative: Bool = false,
        removedOnCompletion: Bool = false,
        option: CAMediaTimingFunctionName = .default,
        animationKey: String?
    ) {
        let animation: CABasicAnimation = CABasicAnimation()
        animation.beginTime = delay + base.convertTime(CACurrentMediaTime(), to: nil)
        
        if let fValue = fromValue { animation.fromValue = fValue }
        if let tValue = toValue { animation.toValue = tValue }
        
        animation.keyPath = keyPath
        animation.duration = duration
        animation.fillMode = fillMode
        animation.repeatCount = repeatCount
        animation.autoreverses = autoreverses
        
        animation.speed = speed
        animation.timeOffset = timeOffset
        animation.repeatDuration = repeatDuration
        
        animation.isCumulative = isCumulative
        animation.isRemovedOnCompletion = removedOnCompletion
        animation.timingFunction = CAMediaTimingFunction(name: option)
        base.add(animation, forKey: animationKey)
    }
    
    //MARK: - CAKeyframeAnimation 关键帧动画
    
    /// 抖动动画 关键帧集合默认为角度[-5, 5, -5]
    /// - Parameters:
    ///   - keyValues: 弧度集合
    ///   - keyTimes: 关键帧对应的时间点集合 取值 0-1 若没有设置该属性 则每一帧的时间平分
    ///   - duration: 动画持续时间 单位 s
    ///   - delay: 延迟时间 单位 s
    ///   - repeatCount: 动画重复次数
    ///   - removedOnCompletion: 结束后是否回到原状态 默认 true
    ///   - option: 动画的控制方式
    public func keyframeAnimationShake(
        keyValues: [Any] = [CGFloat(-5).kc.toRadians, CGFloat(5).kc.toRadians, CGFloat(-5).kc.toRadians],
        keyTimes: [NSNumber]? = nil,
        duration: TimeInterval = 1.0,
        delay: TimeInterval = 0,
        repeatCount: Float = 1,
        removedOnCompletion: Bool = true,
        option: CAMediaTimingFunctionName = .default
    ) {
        keyframeAnimationKeyPath(
            path: nil,
            keyPath: "transform.rotation",
            keyValues: keyValues,
            keyTimes: keyTimes,
            duration: duration,
            delay: delay,
            repeatCount: repeatCount,
            removedOnCompletion: removedOnCompletion,
            option: option
        )
    }
    
    /// 沿锚点进行移动动画
    /// - Parameters:
    ///   - keyValues: CGPoint 集合
    ///   - keyTimes: 关键帧对应的时间点集合 取值 0-1 若没有设置该属性 则每一帧的时间平分
    ///   - duration: 动画持续时间 单位 s
    ///   - delay: 延迟时间 单位 s
    ///   - repeatCount: 动画重复次数
    ///   - removedOnCompletion: 结束后是否回到原状态 默认 false
    ///   - option: 动画的控制方式
    public func keyframeAnimationPosition(
        keyValues: [Any],
        keyTimes: [NSNumber]?,
        duration: TimeInterval = 2.0,
        delay: TimeInterval = 0,
        repeatCount: Float = 1,
        removedOnCompletion: Bool = false,
        option: CAMediaTimingFunctionName = .default
    ) {
        keyframeAnimationKeyPath(
            path: nil,
            keyPath: "position",
            keyValues: keyValues,
            keyTimes: keyTimes,
            duration: duration,
            delay: delay,
            repeatCount: repeatCount,
            removedOnCompletion: removedOnCompletion,
            option: option
        )
    }
    
    /// 沿 CGPath | CGMutablePath 路径进行移动动画
    /// - Parameters:
    ///   - path: CGPath 路径 | CGMutablePath 复合路径
    ///   - duration: 动画持续时间 单位 s
    ///   - delay: 延迟时间 单位 s
    ///   - repeatCount: 动画重复次数
    ///   - rotationMode: 沿着路径旋转模式
    ///   - removedOnCompletion: 结束后是否回到原状态 默认 false
    ///   - option: 动画的控制方式
    public func keyframeAnimationCGPath(
        path: CGPath?,
        duration: TimeInterval = 2.0,
        delay: TimeInterval = 0,
        repeatCount: Float = 1,
        rotationMode: CAAnimationRotationMode? = .none,
        removedOnCompletion: Bool = false,
        option: CAMediaTimingFunctionName = .default
    ) {
        keyframeAnimationKeyPath(
            path: path,
            keyPath: "position",
            keyValues: nil,
            keyTimes: nil,
            duration: duration,
            delay: delay,
            repeatCount: repeatCount,
            removedOnCompletion: removedOnCompletion,
            option: option
        )
    }
    
    /// 关键帧动画配置
    /// - Parameters:
    ///   - path: CGPath 路径 或 CGMutablePath 复合路径
    ///   1. path 只对 CALayer 对应的 anchorPoint | position 起作用 若是设置了 path 则 keyValues 被忽略
    ///   - keyPath: 动画路径 其值参考基础动画 keyPath 说明
    ///   - keyValues: 关键帧集合
    ///   - keyTimes: 关键帧对应的时间点集合 取值 0-1 若没有设置该属性 则每一帧的时间平分
    ///   - duration: 动画持续时间 单位 s
    ///   - delay: 延迟时间 单位 s
    ///   - repeatCount: 动画重复次数
    ///   - fillMode: 动画填充模式 默认 forwards
    ///   1. forwards(对应 toValue 动画结束图层保持 toValue 状态)
    ///   2. backwards(对应 fromValue 动画开始前图层会一直保持 fromValue 状态)
    ///   3. both(对应 fromValue & toValue 是 forwards & backwards 结合)
    ///   4. removed(默认属性 对图层无影响 动画结束图层恢复原有的状态)
    ///   - speed: 动画速度 默认 1.0 若速度为 0 且设置对应的 timeOffset 则可暂停动画
    ///   - timeOffset: 附加的偏移量 默认 0
    ///   1. 若在动画时间内控件状态(a b c) 当其为 0 则执行顺序 a b c 当为 1 则执行顺序 b c a ...
    ///   - repeatDuration: 动画重复的时长 默认 0
    ///   - rotationMode: 沿着路径旋转模式 默认 none
    ///   - isCumulative: 是否累计动画 默认 false
    ///   - removedOnCompletion: 结束后是否回到原状态 默认 false
    ///   - option: 动画的控制方式
    ///   1. (linear: 匀速) | (easeIn: 慢进) | (easeOut: 慢出) | (easeInEaseOut: 慢进慢出) | (default: 慢进慢出)
    ///   - calculationMode: 物体在每个子路径下的运动模式
    ///   1. (linear: 匀速) | (discrete: 离散 无中间过程 但 keyTimes 依旧生效 控件会跳跃出现在各个关键帧)
    ///   2. (paced: 均速 但 keyTimes | timingFunction 设置无效) | (cubic: 同 paced 属性) | (cubicPaced:  同 paced 属性)
    public func keyframeAnimationKeyPath(
        path: CGPath?,
        keyPath: String,
        keyValues: [Any]?,
        keyTimes: [NSNumber]?,
        duration: TimeInterval = 2.0,
        delay: TimeInterval = 0,
        repeatCount: Float = 1,
        fillMode: CAMediaTimingFillMode = .forwards,
        speed: Float = 1.0,
        timeOffset: TimeInterval = 0,
        repeatDuration: TimeInterval = 0,
        rotationMode: CAAnimationRotationMode? = .none,
        isCumulative: Bool = false,
        removedOnCompletion: Bool = false,
        option: CAMediaTimingFunctionName = .default,
        calculationMode: CAAnimationCalculationMode = .linear
    ) {
        let animation = CAKeyframeAnimation(keyPath: keyPath)
        animation.beginTime = delay + base.convertTime(CACurrentMediaTime(), to: nil)
        
        if let kv = keyValues {
            animation.values = kv
        }
        if let kt = keyTimes {
            animation.keyTimes = kt
        }
        if let p = path {
            animation.path = p
            /// 指定一个恒定的速度
            animation.calculationMode = .cubicPaced
            animation.rotationMode = rotationMode
        }
        animation.duration = duration
        animation.fillMode = fillMode
        animation.repeatCount = repeatCount
        
        animation.speed = speed
        animation.timeOffset = timeOffset
        animation.repeatDuration = repeatDuration
        
        animation.isCumulative = isCumulative
        animation.isRemovedOnCompletion = removedOnCompletion
        animation.timingFunction = CAMediaTimingFunction(name: option)
        base.add(animation, forKey: nil)
    }
    
    // MARK: - CAAnimationGroup 组动画
    
    /// 组动画配置
    /// - Parameters:
    ///   - animations: 动画组
    ///   - duration: 动画持续时间 单位 s
    ///   - delay: 延迟时间 单位 s
    ///   - repeatCount: 动画重复次数
    ///   - fillMode: 动画填充模式 默认 forwards
    ///   1. forwards(对应 toValue 动画结束图层保持 toValue 状态)
    ///   2. backwards(对应 fromValue 动画开始前图层会一直保持 fromValue 状态)
    ///   3. both(对应 fromValue & toValue 是 forwards & backwards 结合)
    ///   4. removed(默认属性 对图层无影响 动画结束图层恢复原有的状态)
    ///   - speed: 动画速度 默认 1.0 若速度为 0 且设置对应的 timeOffset 则可暂停动画
    ///   - timeOffset: 附加的偏移量 默认 0
    ///   1. 若在动画时间内控件状态(a b c) 当其为 0 则执行顺序 a b c 当为 1 则执行顺序 b c a ...
    ///   - repeatDuration: 动画重复的时长 默认 0
    ///   - removedOnCompletion: 结束后是否回到原状态 默认 false
    ///   - option: 动画的控制方式
    ///   1. (linear: 匀速) | (easeIn: 慢进) | (easeOut: 慢出) | (easeInEaseOut: 慢进慢出) | (default: 慢进慢出)
    public func animationGroup(
        animations: [CAAnimation]?,
        duration: TimeInterval = 2.0,
        delay: TimeInterval = 0,
        repeatCount: Float = 1,
        fillMode: CAMediaTimingFillMode = .forwards,
        speed: Float = 1.0,
        timeOffset: TimeInterval = 0,
        repeatDuration: TimeInterval = 0,
        removedOnCompletion: Bool = false,
        option: CAMediaTimingFunctionName = .default
    ) {
        let group = CAAnimationGroup()
        group.beginTime = delay + base.convertTime(CACurrentMediaTime(), to: nil)
        group.duration = duration
        group.fillMode = fillMode
        group.animations = animations
        group.repeatCount = repeatCount
        
        group.speed = speed
        group.timeOffset = timeOffset
        group.repeatDuration = repeatDuration
        
        group.isRemovedOnCompletion = removedOnCompletion
        group.timingFunction = CAMediaTimingFunction(name: option)
        base.add(group, forKey: nil)
    }
    
    //MARK: - CATransition 转场动画
    
    /// 转场动画配置
    /// - Parameters:
    ///   - type: 过渡动画类型 其取值
    ///   1. 自有的类型 fade(渐变淡化) | moveIn(移动覆盖) | push(新视图将旧视图推出) | reveal (底部先出来 移除揭开)
    ///   2. 私有的类型 cube(立方体) | suckEffect(吸收) | oglFlip(翻转)  | pageCurl(翻页) | pageUnCurl(反翻页)
    ///             curlUp(上翻页) | curlDown(下翻页) | flipFromLeft(左翻转) | flipFromRight(右翻转)
    ///             cameraIrisHollowOpen(开镜头) | cameraIrisHollowClose(关镜头) | rippleEffect(波纹)
    ///   - subtype: 过渡动画方向 其取值
    ///   1. fromLeft(默认) | fromTop | fromBottom | fromRight
    ///   - duration: 动画持续时间 单位 s
    ///   - delay: 延迟时间 单位 s
    public func transitionAnimation(
        type: CATransitionType,
        subtype: CATransitionSubtype? = .fromLeft,
        duration: TimeInterval = 2.0,
        delay: TimeInterval = 0
    ) {
        let transition = CATransition()
        transition.beginTime = delay + base.convertTime(CACurrentMediaTime(), to: nil)
        transition.type = type
        transition.subtype = subtype
        transition.duration = duration
        base.add(transition, forKey: nil)
    }
    
    //MARK: - CASpringAnimation 弹簧动画
    
    /// 弹簧动画配置
    /// 1. 弹簧动画时长根据其参数估算不需设置
    /// 2. 因弹簧动画时长已由参数确定 即设置 repeatCount 参数无效
    /// - Parameters:
    ///   - keyPath: 动画路径 其值参考基础动画 keyPath 说明
    ///   - toValue: 目标值
    ///   - delay: 延迟时间 单位 s
    ///   - initialVelocity: 初始速率  若初始速率为0 表示忽略该属性
    ///   1. 弹簧运动的初始方向与初始速率的正负一致
    ///   2. 其速率值正数时速度方向与运动方向一致 速率值为负数时速度方向与运动方向相反
    ///   - fillMode: 动画填充模式 默认 forwards
    ///   1. forwards(对应 toValue 动画结束图层保持 toValue 状态)
    ///   2. backwards(对应 fromValue 动画开始前图层会一直保持 fromValue 状态)
    ///   3. both(对应 fromValue & toValue 是 forwards & backwards 结合)
    ///   4. removed(默认属性 对图层无影响 动画结束图层恢复原有的状态)
    ///   - mass: 质量 质量越大 弹簧惯性越大 运动速度变慢且幅度越大
    ///   - stiffness: 弹性系数 弹性系数越大 弹簧的运动越快
    ///   - damping: 阻尼系数 阻尼系数越大 弹簧的停止越快
    ///   - removedOnCompletion: 结束后是否回到原状态 默认 false
    ///   - option: 动画的控制方式
    ///   1. (linear: 匀速) | (easeIn: 慢进) | (easeOut: 慢出) | (easeInEaseOut: 慢进慢出) | (default: 慢进慢出)
    public func springAnimationKeyPath(
        keyPath: String?,
        toValue: Any?,
        delay: TimeInterval = 0,
        initialVelocity: CGFloat = 5,
        fillMode: CAMediaTimingFillMode = .forwards,
        mass: CGFloat = 10.0,
        stiffness: CGFloat = 5000,
        damping: CGFloat = 100.0,
        removedOnCompletion: Bool = false,
        option: CAMediaTimingFunctionName = .default
    ) {
        let animation = CASpringAnimation(keyPath: keyPath)
        animation.beginTime = delay + base.convertTime(CACurrentMediaTime(), to: nil)
        
        animation.toValue = toValue
        animation.fillMode = fillMode
        animation.initialVelocity = initialVelocity
        animation.duration = animation.settlingDuration
        
        animation.mass = mass
        animation.damping = damping
        animation.stiffness = stiffness
        
        animation.isRemovedOnCompletion = removedOnCompletion
        animation.timingFunction = CAMediaTimingFunction(name: option)
        base.add(animation, forKey: nil)
    }
}
