//
//  UIProgressView+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/9/13.
//

import UIKit

//MARK: - 链式属性函数
/** 
 * UIProgressView 视图设置具体的高度是无效的 若要改变其高度 可通过形变缩放实现
 * case: progressView.transform = CGAffineTransformMakeScale(1.0, 2.0)
 */
extension UIProgressView {
    
    /// 设置样式
    /// - Parameter style: 样式
    /// - Returns: 自身
    @discardableResult
    public func style(_ style: UIProgressView.Style) -> Self {
        progressViewStyle = style
        return self
    }
    
    /// 进度 [0.0 - 1.0] 进度动画 进度默认 0
    /// - Parameter progress: 进度
    /// - Parameter animated: 动画
    /// - Returns: 自身
    @discardableResult
    public func progress(_ progress: Float = 0.0, animated: Bool = true) -> Self {
        setProgress(progress, animated: animated)
        return self
    }
    
    /// 已有进度颜色
    /// - Parameter color: 颜色
    /// - Returns: 自身
    @discardableResult
    public func progressTintColor(_ color: UIColor?) -> Self {
        progressTintColor = color
        return self
    }
    
    /// 剩余进度颜色
    /// - Parameter color: 颜色
    /// - Returns: 自身
    @discardableResult
    public func trackTintColor(_ color: UIColor?) -> Self {
        trackTintColor = color
        return self
    }
    
    /// 已有进度图片
    /// - Parameter image: 图片
    /// - Returns: 自身
    @discardableResult
    public func progressImage(_ image: UIImage?) -> Self {
        progressImage = image
        return self
    }
    
    /// 剩余进度图片
    /// - Parameter image: 图片
    /// - Returns: 自身
    @discardableResult
    public func trackImage(_ image: UIImage?) -> Self {
        trackImage = image
        return self
    }
}
