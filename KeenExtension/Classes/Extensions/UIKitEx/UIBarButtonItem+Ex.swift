//
//  UIBarButtonItem+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/12/4.
//

import UIKit

//MARK: - 初始化
extension UIBarButtonItem {
    
    /// 创建 UIBarButtonItem  默认字体 15pt 色值 #333333
    /// - Parameters:
    ///   - name: 按钮内容
    ///   - action: 事件
    /// - Returns: UIBarButtonItem
    public static func createBarbuttonItem(
        name: String,
        action: @escaping ((_ button: UIButton) -> ())
    ) -> UIBarButtonItem {
        return createBarbuttonItem(
            name: name,
            fontSize: 15,
            hexString: "#333333",
            imageName: nil,
            selectedImageName: nil,
            disableImageName: nil,
            action: action
        )
    }
    
    /// 创建 UIBarButtonItem
    /// - Parameters:
    ///   - name: 按钮内容
    ///   - fontSize: 字体大小
    ///   - hexString: 十六进制字符串色值
    ///   - action: 事件
    /// - Returns: UIBarButtonItem
    public static func createBarbuttonItem(
        name: String,
        fontSize: CGFloat,
        hexString: String,
        action: @escaping ((_ button: UIButton) -> ())
    ) -> UIBarButtonItem {
        return createBarbuttonItem(
            name: name,
            fontSize: fontSize,
            hexString: hexString,
            imageName: nil,
            selectedImageName: nil,
            disableImageName: nil,
            action: action
        )
    }
    
    /// 创建 UIBarButtonItem
    /// - Parameters:
    ///   - imageName: 按钮的图片
    ///   - action: 事件
    /// - Returns: UIBarButtonItem
    public static func createBarbuttonItem(
        imageName: String,
        action: @escaping ((_ button: UIButton) -> ())
    ) -> UIBarButtonItem {
        return createBarbuttonItem(
            name: nil,
            fontSize: 15,
            hexString: "#333333",
            imageName: imageName,
            selectedImageName: nil,
            disableImageName: nil,
            action: action
        )
    }
    
    /// 创建 UIBarButtonItem
    /// - Parameters:
    ///   - imageName: 按钮的图片
    ///   - selectedImageName: 按钮被选择的图片
    ///   - action: 事件
    /// - Returns: UIBarButtonItem
    public static func createBarbuttonItem(
        imageName: String,
        selectedImageName: String,
        action: @escaping ((_ button: UIButton) -> ())
    ) -> UIBarButtonItem {
        return createBarbuttonItem(
            name: nil,
            fontSize: 15,
            hexString: "#333333",
            imageName: imageName,
            selectedImageName: selectedImageName,
            disableImageName: nil,
            action: action
        )
    }
    
    /// 创建 UIBarButtonItem
    /// - Parameters:
    ///   - imageName: 按钮的图片
    ///   - disableImageName: 按钮不可点击的图片
    ///   - action: 事件
    /// - Returns: UIBarButtonItem
    public static func createBarbuttonItem(
        imageName: String,
        disableImageName: String,
        action: @escaping ((_ button: UIButton) -> ())
    ) -> UIBarButtonItem {
        return createBarbuttonItem(
            name: nil,
            fontSize: 15,
            hexString: "#333333",
            imageName: imageName,
            selectedImageName: nil,
            disableImageName: disableImageName,
            action: action
        )
    }
    
    /// 创建 UIBarButtonItem
    /// - Parameters:
    ///   - name: 按钮内容
    ///   - fontSize: 字体大小  默认 15 号
    ///   - hexString: 十六进制字符串色值 默认 #333333
    ///   - imageName: 按钮的图片
    ///   - selectedImageName: 按钮被选择的图片
    ///   - disableImageName: 按钮不可点击的图片
    ///   - action: 事件
    /// - Returns: UIBarButtonItem
    private static func createBarbuttonItem(
        name: String?,
        fontSize: CGFloat,
        hexString: String?,
        imageName: String?,
        selectedImageName: String?,
        disableImageName: String?,
        action: @escaping ((_ button: UIButton) -> ())
    ) -> UIBarButtonItem {
        let btn = UIButton(type: .custom)
            .title(name, .highlighted)
            .title(name, .normal)
            .font(fontSize, .normal)
        if let hex = hexString {
            btn.titleColor(UIColor.kc.color(hexString: hex), .normal)
                .titleColor(UIColor.kc.color(hexString: hex), .highlighted)
        }
        if let imgName = imageName {
            btn.image(UIImage(named: imgName), .normal)
                .image(UIImage(named: imgName), .highlighted)
        }
        if let selectedImgName = selectedImageName {
            btn.image(UIImage(named: selectedImgName), .selected)
        }
        if let disableImgName = disableImageName {
            btn.image(UIImage(named: disableImgName), .disabled)
        }
        btn.clickEvent(
            .touchUpInside,
            { action($0 as! UIButton) },
            interval: 0.5,
            isExclusion: true
        )
        return UIBarButtonItem(customView:btn)
    }
}
