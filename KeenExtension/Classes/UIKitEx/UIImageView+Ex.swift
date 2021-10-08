//
//  UIImageView+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/10/22.
//

import UIKit

//MARK: - 链式属性函数
extension UIImageView {
    
    /// 设置图片
    /// - Parameter image: 图片
    /// - Returns: 自身
    @discardableResult
    public func image(_ image: UIImage?) -> Self {
        self.image = image
        return self
    }
    
    /// 动画数组
    /// - Parameter images: 图片动画数组
    /// - Returns: 自身
    @discardableResult
    public func animationImages(_ images: [UIImage]) -> Self {
        animationImages = images
        return self
    }
    
    /// 动画时长
    /// - Parameter duration: 动画时长
    /// - Returns: 自身
    @discardableResult
    public func animationDuration(_ duration: TimeInterval) -> Self {
        animationDuration = duration
        return self
    }
    
    /// 动画重复次数 默认 0
    /// - Parameter count: 重复次数
    /// - Returns: 自身
    @discardableResult
    public func animationRepeatCount(_ count: Int = 0) -> Self {
        animationRepeatCount = count
        return self
    }
}
