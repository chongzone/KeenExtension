//
//  UIButton+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/8/11.
//

import UIKit

extension UIButton {
    
    /// 按钮图片位置类型
    public enum ImagePosition: Int {
        case top
        case left
        case bottom
        case right
    }
}

//MARK: - 链式属性函数
extension UIButton {
    
    /// 按钮文字 状态默认 normal
    /// - Parameters:
    ///   - title: 文案
    ///   - state: 状态
    /// - Returns: 自身
    @discardableResult
    public func title(_ title: String?, _ state: UIControl.State = .normal) -> Self {
        setTitle(title, for: state)
        return self
    }
    
    /// 按钮富文本 状态默认 normal
    /// - Parameters:
    ///   - title: 文案
    ///   - state: 状态
    /// - Returns: 自身
    @discardableResult
    public func title(_ title: NSAttributedString?, _ state: UIControl.State = .normal) -> Self {
        setAttributedTitle(title, for: state)
        return self
    }
    
    /// 按钮字体
    /// - Parameter font: 字体
    /// - Returns: 自身
    @discardableResult
    public func font(_ font: UIFont) -> Self {
        titleLabel?.font = font
        return self
    }
    
    /// 按钮字体 默认常规
    /// - Parameters:
    ///   - fontSize: 字体大小
    ///   - style: 字体样式
    /// - Returns: 自身
    @discardableResult
    public func font(_ fontSize: CGFloat, _ style: UIFont.FontStyle = .normal) -> Self {
        titleLabel?.font = UIFont.fontSizeAdapter(fontSize, style)
        return self
    }
    
    /// 按钮文字颜色 状态默认 normal
    /// - Parameters:
    ///   - color: 文案颜色
    ///   - state: 状态
    /// - Returns: 自身
    @discardableResult
    public func titleColor(_ color: UIColor, _ state: UIControl.State = .normal) -> Self {
        setTitleColor(color, for: state)
        return self
    }
    
    /// 按钮文字阴影色 状态默认 normal
    /// - Parameters:
    ///   - color: 阴影色
    ///   - state: 状态
    /// - Returns: 自身
    @discardableResult
    public func shadowColor(_ color: UIColor, _ state: UIControl.State = .normal) -> Self {
        setTitleShadowColor(color, for: state)
        return self
    }
    
    /// 按钮图片 状态默认 normal
    /// - Parameters:
    ///   - image: 图片
    ///   - state: 状态
    /// - Returns: 自身
    @discardableResult
    public func image(_ image: UIImage?, _ state: UIControl.State = .normal) -> Self {
        setImage(image, for: state)
        return self
    }
    
    /// 按钮背景图片 状态默认 normal
    /// - Parameters:
    ///   - image: 图片
    ///   - state: 状态
    /// - Returns: 自身
    @discardableResult
    public func backImage(_ image: UIImage?, _ state: UIControl.State = .normal) -> Self {
        setBackgroundImage(image, for: state)
        return self
    }
    
    /// 按钮内容内边距
    /// - Parameters:
    ///   - edge: 边距
    /// - Returns: 自身
    @discardableResult
    public func contentEdgeInsets(_ edge: UIEdgeInsets = .zero) -> Self {
        contentEdgeInsets = edge
        return self
    }
    
    /// 按钮文字内边距
    /// - Parameters:
    ///   - edge: 边距
    /// - Returns: 自身
    @discardableResult
    public func titleEdgeInsets(_ edge: UIEdgeInsets = .zero) -> Self {
        titleEdgeInsets = edge
        return self
    }
    
    /// 按钮图片内边距
    /// - Parameters:
    ///   - edge: 边距
    /// - Returns: 自身
    @discardableResult
    public func imageEdgeInsets(_ edge: UIEdgeInsets = .zero) -> Self {
        imageEdgeInsets = edge
        return self
    }
    
    /// 按钮高亮状态下图片是否会变暗 默认 true
    /// - Parameters:
    ///   - flag: 是否变暗
    /// - Returns: 自身
    @discardableResult
    public func adjustsImageWhenHighlighted(_ flag: Bool = true) -> Self {
        adjustsImageWhenHighlighted = flag
        return self
    }
    
    /// 按钮失效状态下图片是否会变亮 默认 true
    /// - Parameters:
    ///   - flag: 是否变暗
    /// - Returns: 自身
    @discardableResult
    public func adjustsImageWhenDisabled(_ flag: Bool = true) -> Self {
        adjustsImageWhenDisabled = flag
        return self
    }
    
    /// 图片&文字的布局 默认水平 图片在左文字在右 图片、文字间隔 5pt
    /// - Parameters:
    ///   - position: 按钮布局方式
    ///   - space: 图片、文字间隔 默认 5pt
    /// - Returns: 自身
    @discardableResult
    public func imagePosition(_ position: UIButton.ImagePosition = .left, space: CGFloat = 5) -> Self {
        buttonImagePosition(position, space: space)
        return self
    }
}

//MARK: - 常见功能
extension UIButton {
    
    /// 创建按钮 类型默认 .custom
    /// - Parameter type: 按钮类型 默认 .custom
    /// - Returns: 按钮实例
    public static func createButton(_ type: UIButton.ButtonType = .custom) -> UIButton {
        return UIButton(type: type)
    }
    
    /// 按钮图片和文字的布局 默认水平布局 图片在左文字在右 图片和文字间隔 5pt
    /// - Parameters:
    ///   - position: 按钮布局方式  默认水平 图片在左文字在右
    ///   - space: 图片和文字间隔 默认 5pt
    public func buttonImagePosition(_ position: UIButton.ImagePosition = .left, space: CGFloat = 5) {
        switch position {
        case .top: layoutPosition((false, false, 0), (true, true, space))
        case .left: layoutPosition((true, true, space), (false, false, 0))
        case .bottom: layoutPosition((false, false, 0), (true, false, space))
        case .right: layoutPosition((true, false, space), (false, false, 0))
        }
    }
    
    /// 按钮图片和文字的布局 默认水平布局 图片在左文字在右 图片和文字间隔 5pt
    /// - Parameters:
    ///   - horizontal: 水平配置
    ///   1. 参数 flag(表示是否水平布局) isLeft(图片是否在左边) space(图片和文字的间隔)
    ///   - vertical: 垂直配置
    ///   1. 1. 参数 flag(表示是否垂直布局) isTop(图片是否在上边) space(图片和文字的间隔)
    private func layoutPosition(
        _ horizontal: (flag: Bool, isLeft: Bool, space: CGFloat) = (true, true, 5),
        _ vertical: (flag: Bool, isTop: Bool, space: CGFloat) = (false, false, 0)
    ) {
        assert((horizontal.flag && !vertical.flag) || !horizontal.flag && vertical.flag, "布局设置错误, 请正确配置")
        /// 水平布局
        if horizontal.flag {
            let hSpace = horizontal.space * 0.5
            imageEdgeInsets(UIEdgeInsets(tb: (0, 0), lr: (-hSpace, hSpace)))
                .titleEdgeInsets(UIEdgeInsets(tb: (0, 0), lr: (hSpace, -hSpace)))
            if !horizontal.isLeft {
                transform = CGAffineTransform(scaleX: -1, y: 1)
                imageView?.transform  = CGAffineTransform(scaleX: -1, y: 1)
                titleLabel?.transform = CGAffineTransform(scaleX: -1, y: 1)
            }
            contentEdgeInsets(UIEdgeInsets(tb: (0, 0), lr: (hSpace, hSpace)))
        }
        /// 垂直布局
        if vertical.flag {
            guard let imgSize = imageView?.image?.size,
                  let text = titleLabel?.text,
                  let font = titleLabel?.font
                else { return }
            let titleSize     = NSString(string:text).size(withAttributes:[.font:font])
            let imgVOffset    = (titleSize.height + vertical.space) * 0.5
            let titleVOffset  = (imgSize.height + vertical.space) * 0.5
            let imgHOffset    = (titleSize.width) * 0.5
            let titleHOffset  = (imgSize.width) * 0.5
            let flag: CGFloat = vertical.isTop ? 1 : -1
            
            let lr = (imgHOffset, -imgHOffset)
            let tb = (-imgVOffset * flag, imgVOffset * flag)
            let lr_title = (-titleHOffset, titleHOffset)
            let tb_title = (titleVOffset * flag, -titleVOffset * flag)
            
            imageEdgeInsets(UIEdgeInsets(tb: tb, lr: lr))
                .titleEdgeInsets(UIEdgeInsets(tb: tb_title, lr: lr_title))
            
            let offset = (min(imgSize.height, titleSize.height) + vertical.space) * 0.5
            contentEdgeInsets(UIEdgeInsets(tb: (offset, offset), lr: (0, 0)))
        }
    }
}
