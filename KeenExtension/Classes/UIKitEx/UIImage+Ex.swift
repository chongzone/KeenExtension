//
//  UIImage+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/10/22.
//

import UIKit

extension UIImage {
    
    /// 线性渐变样式
    public enum LinearGradientStyle: Int {
        /// 从上到下
        case top_bottom
        /// 从左到右
        case left_right
        /// 从左上到右下
        case left_diagonal
        /// 从右上到左下
        case right_diagonal
    }
    
    /// 滤镜模式
    public enum FilterMode: Int {
        /// 黑白滤镜
        case effectNoir
        /// 棕褐色滤镜
        case sepiaTone
        /// 高斯模糊
        case blurEffect
    }
}

//MARK: - 索引扩展
extension UIImage {
    
    /// 指定像素点的颜色
    public subscript(x: Int, y: Int) -> UIColor? {
        if x < 0 || x > Int(size.width) || y < 0 || y > Int(size.height) {
            return nil
        }
        /// bitmap 数据
        let provider = self.cgImage!.dataProvider
        let data = CFDataGetBytePtr(provider!.data)
        
        let elementNum = 4
        let pixelData = ((Int(size.width) * y) + x) * elementNum
        
        let red   = CGFloat(data![pixelData])/255.0
        let green = CGFloat(data![pixelData+1])/255.0
        let blue  = CGFloat(data![pixelData+2])/255.0
        let alpha = CGFloat(data![pixelData+3])/255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

//MARK: - 链式属性函数
extension UIImage {
    
    /// 图片渲染模式
    /// 1. automatic(根据上下文自动渲染) 默认模式
    /// 2. alwaysOriginal(始终保持图片原始状态)
    /// 3. alwaysTemplate(始终根据其承载视图 UIImageView 对应的 tintColor 绘制图片)
    /// - Parameters:
    ///   - mode: 渲染模式
    /// - Returns: 自身
    @discardableResult
    public func renderingMode(_ mode: UIImage.RenderingMode = .automatic) -> Self {
        withRenderingMode(mode)
        return self
    }
    
    /// 调整图片 不适用图层边框
    /// - Parameters:
    ///   - alignmentInsets: 边距大小
    /// - Returns: 自身
    @discardableResult
    public func alignmentRectInsets(_ alignmentInsets: UIEdgeInsets) -> Self {
        withAlignmentRectInsets(alignmentInsets)
        return self
    }
    
    /// 调整图片 默认拉伸模式
    /// - Parameters:
    ///   - insets: 边距大小
    ///   - resizingMode: 模式
    /// - Returns: 自身
    @discardableResult
    public func resizableImage(_ insets: UIEdgeInsets, resizingMode: UIImage.ResizingMode = .stretch) -> Self {
        resizableImage(withCapInsets: insets, resizingMode: resizingMode)
        return self
    }
}

//MARK: - 基础功能
extension KcPrefixWrapper where Base: UIImage {
    
    /// 两个图片是否相同
    /// - Parameters:
    ///   - lhs: 图片
    ///   - rhs: 图片
    /// - Returns: 图片是否相同
    public static func isEqual (lhs: UIImage, rhs: UIImage) -> Bool {
        guard let data1 = lhs.pngData(),
              let data2 = rhs.pngData()
        else { return false }
        return data1 == data2
    }
    
    /// 两个图片是否相同
    /// - Parameter image: 目标图片
    /// - Returns: 图片是否相同
    public func isEqual(_ image: UIImage) -> Bool {
        guard let data1 = base.pngData(),
              let data2 = image.pngData()
        else { return false }
        return data1 == data2
    }
    
    /// 转 圆形图片
    public func toCircleImage() -> UIImage? {
        let radius = base.size.width > base.size.height ? base.size.height / 2.0 : base.size.width / 2.0
        return toCornerImage(
            size: base.size,
            radius: radius,
            byRoundingCorners: .allCorners
        )
    }
    
    /// 转 圆角图片 默认四周都有圆角 大小 2pt
    /// - Parameters:
    ///   - size: 图片大小
    ///   - radius: 圆角大小 默认 2.0
    ///   - corners: 圆角的方向
    /// - Returns: 圆角图片
    public func toCornerImage(
        size: CGSize,
        radius: CGFloat = 2.0,
        byRoundingCorners corners: UIRectCorner = .allCorners
    ) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, .screenScale)
        let context = UIGraphicsGetCurrentContext()
        guard let ctx = context else {
            UIGraphicsEndImageContext()
            return nil
        }
        let path = UIBezierPath(
            roundedRect:CGRect(origin: .zero, size: size),
            byRoundingCorners: .allCorners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        ctx.addPath(path.cgPath)
        ctx.clip()
        base.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        ctx.drawPath(using: .fillStroke)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 转 灰色图片
    /// - Returns: 灰色图片
    public func toGrayImage() -> UIImage? {
        let imageW = base.size.width, imageH = base.size.height;
        let colorSpace = CGColorSpaceCreateDeviceGray()
        /// 保留Alpha通道 避免透明区域变成黑色
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue).rawValue
        let context = CGContext(
            data: nil,
            width: Int(imageW),
            height: Int(imageH),
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: colorSpace,
            bitmapInfo: bitmapInfo
        )
        guard let ctx = context else {
            UIGraphicsEndImageContext()
            return nil
        }
        ctx.draw(base.cgImage!, in: CGRect(x: 0, y: 0, width: imageW, height: imageH))
        guard let cgImage = ctx.makeImage() else {
            UIGraphicsEndImageContext()
            return nil
        }
        return UIImage(cgImage: cgImage)
    }
}

//MARK: - 常见功能
extension KcPrefixWrapper where Base: UIImage {
    
    /// 由 RGB 生成图片 默认透明度 1.0
    /// - Parameters:
    ///   - r: 红色
    ///   - g: 绿色
    ///   - b: 蓝色
    ///   - a: 透明度
    /// - Returns: 图片
    public static func image(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) -> UIImage? {
        return image(color: UIColor.kc.color(r: r, g: g, b: b, a: a))
    }
    
    /// 由十六进制值生成图片 默认透明度 1.0
    /// - Parameters:
    ///   - hexValue: 色值  十六进制整型值
    ///   - alpha: 透明度
    /// - Returns: 图片
    public static func image(hexValue: Int, alpha: CGFloat = 1.0) -> UIImage? {
        return image(color: UIColor.kc.color(hexValue: hexValue, alpha: alpha))
    }
    
    /// 由十六进制字符生成图片 默认透明度 1.0
    /// - Parameters:
    ///   - hexString: 色值  十六进制字符串
    ///   - alpha: 透明度
    /// - Returns: 图片
    public static func image(hexString: String, alpha: CGFloat = 1.0) -> UIImage? {
        return image(color: UIColor.kc.color(hexString: hexString, alpha: alpha))
    }
    
    /// 由颜色生成图片
    /// - Parameter color: 颜色
    /// - Returns: 图片
    public static func image(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, .screenScale)
        let context = UIGraphicsGetCurrentContext()
        guard let ctx = context else {
            UIGraphicsEndImageContext()
            return nil
        }
        ctx.setFillColor(color.cgColor)
        ctx.fill(rect)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 由原图着色为指定颜色的图片
    /// - Parameters:
    ///   - tintColor: 图片着色的颜色
    /// - Returns: 特定颜色的图片
    public func image(tintColor: UIColor) -> UIImage? {
        let imgRect = CGRect(x: 0, y: 0, width: base.size.width, height: base.size.height)
        UIGraphicsBeginImageContextWithOptions(base.size, true, .screenScale)
        let context = UIGraphicsGetCurrentContext()
        guard let ctx = context else {
            UIGraphicsEndImageContext()
            return nil
        }
        ctx.translateBy(x: 0, y: base.size.height)
        ctx.scaleBy(x: 1.0, y: -1.0)
        ctx.clip(to: imgRect, mask: base.cgImage!)
        tintColor.setFill()
        ctx.fill(imgRect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 由颜色 & 图层混合生成新的图片
    /// - Parameters:
    ///   - tintColor: 图片着色的颜色
    ///   - blendMode: 混合模式 常用的有 destinationIn | overlay | normal | multiply
    ///   0. (R: 代表图层混合结果) | (S:  代表含 alpha 的原颜色) | (D: 代表含 alpha 的目标颜色) | (Ra, Sa, Da: 代表对应的 alpha)
    ///   1. (.normal: 默认) | (.multiply:  混合原色和背景色 最终色会变暗点) | (.hue: 色调) | (saturation: 饱和度)
    ///   2. (.screen: 滤色 把原色和背景色的颜色先反过来再混合) | (.overlay: 覆盖, 保留灰度信息(背景色信息))
    ///   3. (.lighten: 目标色变亮) | (.colorDodge: 目标色变淡) | (.exclusion: 排除) | (.softLight: 原色变柔和亮色)
    ///   4. (.hardLight: 原色加深) | (.colorBurn: 原色变亮) | (.darken: 原色加深) | (.difference: 插值)  | (.color: 颜色)
    ///   5.  (.luminosity: 亮度) | (.destinationIn: R = D*Sa 保留透明度信息) | (.clear: R = 0, 无色) | (.copy: R = S 原色)
    ///   6. (.sourceIn: S*Da & .sourceOut: R = S*(1 - Da) - 原色 & 目标色的 alpha 混合)
    ///   7. (.sourceAtop: R = S*Da + D*(1 - Sa),  原色 | 目标色的 alpha 混合 & 目标色色 | 原色的 alpha 混合)
    ///   8. (.destinationOver: R = S*(1 - Da) + D) | (.destinationOut: R = D*(1 - Sa)) | (.destinationAtop: R = S*(1 - Da) + D*Sa)
    ///   9. (.xor: R = S*(1 - Da) + D*(1 - Sa)) | (.plusDarker: R = MAX(0, (1 - D) + (1 - S))) | (.plusLighter: R = MIN(1, S + D))
    /// - Returns: 图片
    public func image(tintColor: UIColor, blendMode: CGBlendMode) -> UIImage? {
        let imgRect = CGRect(x: 0, y: 0, width: base.size.width, height: base.size.height)
        UIGraphicsBeginImageContextWithOptions(base.size, true, .screenScale)
        tintColor.setFill()
        UIRectFill(imgRect)
        base.draw(in: imgRect, blendMode: blendMode, alpha: 1.0)
        if blendMode != .destinationIn {
            base.draw(in: imgRect, blendMode: .destinationIn, alpha: 1.0)
        }
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 改变图片透明度
    /// - Parameter alpha: 透明度
    /// - Returns: 图片
    public func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(base.size, true, .screenScale)
        let context = UIGraphicsGetCurrentContext()
        guard let ctx = context else {
            UIGraphicsEndImageContext()
            return nil
        }
        let rect = CGRect(x: 0, y: 0, width: base.size.width, height: base.size.height)
        ctx.scaleBy(x: 1, y: -1)
        ctx.translateBy(x: 0, y: -rect.height)
        ctx.setBlendMode(.multiply)
        ctx.setAlpha(alpha)
        ctx.draw(base.cgImage!, in: rect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 调整图片 模式默认拉伸
    /// - Parameter mode: 调整模式
    /// 1.  stretch(拉伸) tile(平铺)
    /// - Returns: 图片
    public func image(resizingMode mode: UIImage.ResizingMode = .stretch) -> UIImage {
        let top = base.size.height * 0.5, bottom = base.size.height * 0.5;
        let left = base.size.width * 0.5, right = base.size.width * 0.5;
        let edgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return base.resizableImage(withCapInsets: edgeInsets, resizingMode: mode)
    }
    
    /// 图片合成
    /// - Parameters:
    ///   - images: 每个要合成图片的信息(图片、坐标 x|y、宽高 w|h)
    ///   - targetSize: 最终合成的图片宽高
    /// - Returns: 合成的图片
    public static func imageMerge(
        of images: [(UIImage, (CGFloat, CGFloat), (CGFloat, CGFloat))],
        to targetSize: CGSize
    ) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(targetSize, true, .screenScale)
        UIImage().draw(in: CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height))
        images.forEach {
            $0.0.draw(in: CGRect(x: $0.1.0, y: $0.1.1, width: $0.2.0, height: $0.2.1))
        }
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 由色值集合生成对应的线性渐变图片 默认渐变样式从左至右 无圆角
    /// - Parameters:
    ///   - colors: 色值数组
    ///   - size: 图片宽高
    ///   - radius: 图片圆角大小
    ///   - style: 渐变色的样式  默认从左至右
    /// - Returns: 对应宽高的线性渐变色图片
    public static func imageGradient(
        of colors: [String],
        size: CGSize,
        radius: CGFloat = 0,
        style: UIImage.LinearGradientStyle = .left_right
    ) -> UIImage? {
        if colors.count == 0 { return nil }
        if colors.count == 1 {
            return image(color: UIColor.kc.color(hexString: colors.first!))
        }
        var arrs = [CGColor]()
        colors.forEach { arrs.append(UIColor.kc.color(hexString: $0).cgColor) }
        UIGraphicsBeginImageContextWithOptions(size, true, .screenScale)
        let context = UIGraphicsGetCurrentContext()
        guard let ctx = context else {
            UIGraphicsEndImageContext()
            return nil
        }
        let path = UIBezierPath(
            roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height),
            cornerRadius: radius
        )
        path.addClip()
        ctx.addPath(path.cgPath)
        
        let colorSpace = (UIColor.kc.color(hexString: colors.last!).cgColor).colorSpace
        let gradient = CGGradient(
            colorsSpace: colorSpace,
            colors: arrs as CFArray,
            locations: nil
        )!
        var start = CGPoint.zero, end = CGPoint.zero;
        switch style {
        case .top_bottom:
            start = CGPoint(x: 0, y: 0)
            end   = CGPoint(x: 0, y: size.height)
        case .left_right:
            start = CGPoint(x: 0, y: 0)
            end   = CGPoint(x: size.width, y: 0)
        case .left_diagonal:
            start = CGPoint(x: 0, y: 0)
            end   = CGPoint(x: size.width, y: size.height)
        case .right_diagonal:
            start = CGPoint(x: size.width, y: 0)
            end   = CGPoint(x: 0, y: size.height)
        }
        ctx.drawLinearGradient(
            gradient,
            start: start,
            end: end,
            options: [.drawsBeforeStartLocation, .drawsAfterEndLocation]
        )
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 图片水印
    /// - Parameters:
    ///   - image: 图片
    ///   - origin:  x|y 坐标 (参考图片的实际大小)
    ///   - alpha: 透明度
    /// - Returns: 图片
    public func imageWatermark(
        _ image: UIImage,
        origin: CGPoint,
        alpha: CGFloat = 1.0
    ) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(base.size, true, .screenScale)
        base.draw(in: CGRect(x: 0, y: 0, width: base.size.width, height: base.size.height))
        image.draw(
            in: CGRect(x: origin.x, y: origin.y, width: image.size.width, height: image.size.height),
            blendMode: .normal,
            alpha: alpha
        )
        guard let img = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        return img
    }
    
    /// 文字水印
    /// - Parameters:
    ///   - text: 文字内容
    ///   - origin: x|y 坐标 (参考图片的实际大小)
    ///   - attributes: 文字属性
    /// - Returns: 图片
    public func imageWatermark(
        _ text: String,
        origin: CGPoint,
        attributes: [NSAttributedString.Key: Any]? = nil
    ) -> UIImage? {
        let drawStr = NSString(string: text)
        let itemsize = drawStr.size(withAttributes: attributes)
        UIGraphicsBeginImageContextWithOptions(base.size, true, .screenScale)
        base.draw(in: CGRect(x: 0, y: 0, width: base.size.width, height: base.size.height))
        drawStr.draw(
            in: CGRect(x: origin.x, y: origin.y, width: itemsize.width, height: itemsize.height),
            withAttributes: attributes
        )
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 调整图片方向
    public func imageOrientation() -> UIImage? {
        if base.imageOrientation == .up { return base }
        var transform: CGAffineTransform = CGAffineTransform.identity
        switch base.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: base.size.width, y: base.size.height)
            transform = transform.rotated(by: .pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: base.size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: base.size.height)
            transform = transform.rotated(by: -.pi / 2)
        default:
            break
        }
        switch base.imageOrientation {
        case .upMirrored, .downMirrored:
            transform.translatedBy(x: base.size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform.translatedBy(x: base.size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
        default:
            break
        }
        let context = CGContext(
            data: nil,
            width: base.size.width.kc.toInt,
            height: base.size.height.kc.toInt,
            bitsPerComponent: (base.cgImage?.bitsPerComponent)!,
            bytesPerRow: 0,
            space: (base.cgImage?.colorSpace)!,
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )
        guard let ctx = context else { return nil }
        ctx.concatenate(transform)
        switch base.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(base.cgImage!, in: CGRect(x: 0, y: 0, width: base.size.height, height: base.size.width))
        default:
            ctx.draw(base.cgImage!, in: CGRect(x: 0, y: 0, width: base.size.width, height: base.size.height))
        }
        guard let cgImg = ctx.makeImage() else {
            return nil
        }
        return UIImage(cgImage: cgImg)
    }
}

//MARK: - 裁剪|缩放|旋转|翻转
extension KcPrefixWrapper where Base: UIImage {
    
    /// 图片裁剪为指定的范围
    /// - Parameter rect: 裁剪范围
    /// - Returns: 图片
    public func imageCrop(in rect: CGRect) -> UIImage? {
        let cropRect = CGRect(
            x: rect.origin.x * base.scale,
            y: rect.origin.y * base.scale,
            width: rect.size.width * base.scale,
            height: rect.size.height * base.scale
        )
        if cropRect.size.width <= 0 || cropRect.size.height <= 0 {
            return nil
        }
        var image:UIImage?
        autoreleasepool {
            let cgImge: CGImage? = base.cgImage!.cropping(to: cropRect)
            if let cgImg = cgImge {
                image = UIImage(cgImage: cgImg)
            }
        }
        return image
    }
    
    /// 图片裁剪为指定的尺寸
    /// - Parameter targetSize: 指定尺寸
    /// - Returns: 图片
    public func imageCrop(to targetSize: CGSize) -> UIImage? {
        let imgRatio = max(targetSize.width/base.size.width, targetSize.height/base.size.height)
        var ctxRect = CGRect.zero
        ctxRect.size.width = base.size.width * imgRatio
        ctxRect.size.height = base.size.height * imgRatio
        ctxRect.origin.x = (targetSize.width - base.size.width * imgRatio) / 2.0
        ctxRect.origin.y = (targetSize.height - base.size.height * imgRatio) / 2.0
        if #available(iOS 10, *) {
            let renderer = UIGraphicsImageRenderer(size: targetSize)
            return renderer.image { ctx in
                base.draw(in: ctxRect)
            }
        }else {
            UIGraphicsBeginImageContextWithOptions(targetSize, true, .screenScale)
            base.draw(in: ctxRect)
            guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
                UIGraphicsEndImageContext()
                return nil
            }
            UIGraphicsEndImageContext()
            return image
        }
    }
    
    /// 图片按比例等比裁剪  保留图片宽高比
    /// - Parameter ratio: 比例
    /// - Returns: 图片
    public func imageCrop(at ratio: CGFloat) -> UIImage? {
        var newSize: CGSize!
        if base.size.width/base.size.height > ratio {
            newSize = CGSize(width: base.size.height * ratio, height: base.size.height)
        }else {
            newSize = CGSize(width: base.size.width, height: base.size.width / ratio)
        }
        var rect = CGRect.zero
        rect.size.width = base.size.width
        rect.size.height = base.size.height
        rect.origin.x = (newSize.width - base.size.width ) / 2.0
        rect.origin.y = (newSize.height - base.size.height ) / 2.0
        UIGraphicsBeginImageContextWithOptions(newSize, true, .screenScale)
        base.draw(in: rect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 图片等比缩放为指定的尺寸
    /// - Parameter targetSize: 缩放到的尺寸
    /// - Returns: 图片
    public func imageScale(to targetSize: CGSize) -> UIImage? {
        guard let cgImg = base.cgImage else { return nil }
        var imgW = CGFloat(cgImg.width)
        var imgH = CGFloat(cgImg.height)
        let vRadio = targetSize.height / imgH
        let hRadio = targetSize.width / imgW
        var radio: CGFloat = 1
        if vRadio > 1 && hRadio > 1 {
            radio = vRadio > hRadio ? hRadio : vRadio
        } else {
            radio = vRadio < hRadio ? vRadio : hRadio
        }
        imgW = imgW * radio
        imgH = imgH * radio
        let imgX = (targetSize.width - imgW) / 2.0
        let imgY = (targetSize.height - imgH) / 2.0
        UIGraphicsBeginImageContextWithOptions(targetSize, true, .screenScale)
        base.draw(in: CGRect(x: imgX, y: imgY, width: imgW, height: imgH))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 图片按比例等比缩放
    /// - Parameter radio: 缩放比例
    /// - Returns: 图片
    public func imageScale(at radio: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(base.size, true, .screenScale)
        base.draw(in: CGRect(x: 0, y: 0, width: base.size.width * radio, height: base.size.height * radio))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 图片旋转 取值 (0--360)
    /// - Parameter angle: 角度 0--360
    /// - Returns: 图片
    public func imageRotated(at angle: CGFloat) -> UIImage? {
        guard let cgImg = base.cgImage else { return nil }
        let view = UIView(origin: .zero, size: base.size)
        view.transform = CGAffineTransform(rotationAngle: angle.kc.toRadians)
        UIGraphicsBeginImageContextWithOptions(view.kc.size, true, .screenScale)
        let context = UIGraphicsGetCurrentContext()
        guard let ctx = context else {
            UIGraphicsEndImageContext()
            return nil
        }
        ctx.translateBy(x: view.kc.width / 2, y: view.kc.height / 2)
        ctx.rotate(by: angle.kc.toRadians)
        ctx.scaleBy(x: 1, y: -1)
        let rect = CGRect(
            x: -base.size.width / 2.0,
            y: -base.size.height / 2.0,
            width: base.size.width,
            height: base.size.height
        )
        ctx.draw(cgImg, in: rect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 图片翻转
    /// - Parameter orientation: 翻转方向
    /// 1. up(向上翻转) | down(向下翻转) left(向左翻转) | right(向右翻转)
    /// 1. leftMirrored(镜像向左翻转) | rightMirrored(镜像向右翻转)
    /// 3. upMirrored (水平翻转) | downMirrored(垂直翻转)
    /// - Returns: 图片
    public func imageFlip(to orientation: UIImage.Orientation) -> UIImage? {
        guard let cgImg = base.cgImage else { return nil }
        var transform: CGAffineTransform = .identity
        let rect = CGRect(x: 0, y: 0, width: cgImg.width, height: cgImg.height)
        var bounds = rect
        switch orientation {
        case .up:
            return base
        case .down:
            transform = CGAffineTransform(translationX: rect.size.width, y: rect.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        case .upMirrored:
            transform = CGAffineTransform(translationX: rect.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .downMirrored:
            transform = CGAffineTransform(translationX: 0, y: rect.size.height)
            transform = transform.scaledBy(x: 1, y: -1)
        case .left:
            imageSwapSize(in: &bounds)
            transform = CGAffineTransform(translationX:0 , y: rect.size.width)
            transform = transform.rotated(by: CGFloat(Double.pi * 1.5))
        case .right:
            imageSwapSize(in: &bounds)
            transform = CGAffineTransform(translationX:rect.size.height , y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2))
        case .leftMirrored:
            imageSwapSize(in: &bounds)
            transform = CGAffineTransform(translationX:rect.size.height , y: rect.size.width)
            transform = transform.scaledBy(x: -1, y: 1)
            transform = transform.rotated(by: CGFloat(Double.pi * 1.5))
        case .rightMirrored:
            imageSwapSize(in: &bounds)
            transform = transform.scaledBy(x: -1, y: 1)
            transform = transform.rotated(by: CGFloat(Double.pi / 2))
        default:
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, .screenScale)
        let context = UIGraphicsGetCurrentContext()
        guard let ctx = context  else {
            UIGraphicsEndImageContext()
            return nil
        }
        /// 绘制时进行修正
        switch orientation {
        case .left:
            fallthrough
        case .right:
            fallthrough
        case .leftMirrored:
            fallthrough
        case .rightMirrored:
            ctx.scaleBy(x: -1.0, y: 1.0)
            ctx.translateBy(x: -bounds.size.width, y: 0.0)
        default:
            ctx.scaleBy(x: 1.0, y: -1.0)
            ctx.translateBy(x: 0.0, y: -rect.size.height)
        }
        ctx.concatenate(transform)
        ctx.draw(cgImg, in: rect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 交换宽高
    /// - Parameter rect: 范围
    private func imageSwapSize(in rect: inout CGRect) {
        let swap = rect.size.width
        rect.size.width = rect.size.height
        rect.size.height = swap
    }
}

//MARK: - 滤镜|抠图|马赛克|人脸检测|二维码|条形码
/**
 * 通过 CoreImage 库可实现的主要功能: 滤镜 抠图 马赛克 人脸检测(不含面纹编码) 二维码检测 文本检测等
 * 其中滤镜 主要类: CIImage  & CIFilter & CIContext
 * CIImage: 处理的图片蓝本, 线程安全
 * CIFilter: 使用的滤镜, 其中对 CIImage 是使用滤镜链表形式, 不会立即进行滤镜渲染, 线程不安全, 不可供多个线程共享
 * CIContext: 滤镜渲染的上下文(分 CPU & GPU), 只有使用 CIContext 才真正渲染, 线程安全
 *         CPU 渲染: 速度较慢, 可后台执行, 场景: 非实时滤镜需求
 *         GPU渲染: 速度快, 不可后台执行, 场景: 实时性的滤镜渲染
 *
 * 其中图片抠图  CIColorCube 针对纯色处理较好
 * 其中图片马赛克 CIPixellate 原理主要是利用像素化滤镜
 * 其中图片二维码 CIQRCodeGenerator
 * 其中图片条形码 CICode128BarcodeGenerator
 * 其中图片检测: CIDetector
 * 1. 人脸检测 CIDetectorTypeFace  找出符合人脸特征的区域(人脸范围、眼睛、嘴巴等位置)
 * 2. 矩形检测 CIDetectorTypeRectangle
 * 3. 二维码检测 CIDetectorTypeQRCode
 * 4. 文本检测 CIDetectorTypeText
 * 图片检测参数:
 * 1. CIDetectorTracking: 特征跟踪
 * 2. CIDetectorMinFeatureSize: 设置识别特征的最小尺寸(即小于这个尺寸的特征将不识别), 取值 0~1
 *   对于人脸检测, 其值是基于输入图像短边长度的百分比, 有效范围 0.01~0.5 默认 0.15, 超过有效值仅用于提高性能
 *   对于矩形检测, 其值基于输入图像短边长度的百分比, 有效范围 0.2~1.0 默认 0.2
 *   对于文本检测, 其值基于输入图像高度的百分比, 有效范围 0~1 默认 10 / (图像高度)
 * 3. CIDetectorMaxFeatureCount: 针对矩形检测, 返回矩形特征的最多个数, 有效范围1~256 默认 1
 * 4. CIDetectorNumberOfAngles: 角度的个数, 取值 1、3、5、7、9、11
 * 5. CIDetectorImageOrientation: 设置识别方向, 取值 1~8 若值存在则基于这个方向进行
 * 6. CIDetectorEyeBlink: bool 类型 若取值 true 将提取眨眼特征
 * 7. CIDetectorFocalLength: 设置每帧焦距
 * 8. CIDetectorAspectRatio: 设置矩形的长宽比
 * 9. CIDetectorReturnSubFeatures: bool 类型 文本检测器是否应检测子特征 默认 false
 */
extension KcPrefixWrapper where Base: UIImage {
    
    /// 生成二维码
    /// - Parameters:
    ///   - qrcode: 二维码对应的字符串
    ///   - size: 二维码宽高
    ///   - centerIcon: 中心的图片
    ///   - centerSize: 中心图片宽高 默认(30, 30)
    ///   - qrcodeColor: 二维码颜色 默认黑色
    ///   - qrcodeBackColor: 二维码背景色  默认白色
    /// - Returns: 二维码图片
    public static func image(
        qrcode: String,
        size: CGSize,
        centerIcon: UIImage?,
        centerSize: CGSize = CGSize(width: 30, height: 30),
        qrcodeColor: UIColor = UIColor.black,
        qrcodeBackColor: UIColor = UIColor.white
    ) -> UIImage? {
        /// 二维码滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        /// 输入内容
        let inputData = qrcode.data(using: .utf8)
        filter?.setValue(inputData, forKey: "inputMessage")
        /// 不同级别的容错率 默认 L7% M15% Q25% H30% 默认 M
        filter?.setValue("M", forKey: "inputCorrectionLevel")
        guard let outputImage = filter?.outputImage else { return nil }
        /// 颜色滤镜
        let colorFilter = CIFilter(
            name: "CIFalseColor",
            parameters: [
                "inputImage": outputImage,
                "inputColor0": CIColor(cgColor: qrcodeColor.cgColor),
                "inputColor1": CIColor(cgColor: qrcodeBackColor.cgColor)
            ]
        )
        guard let outputColorImage = colorFilter?.outputImage else { return nil }
        let cgImage = CIContext().createCGImage(outputColorImage, from: outputColorImage.extent)
        /// 二维码
        UIGraphicsBeginImageContextWithOptions(size, true, .screenScale)
        let context = UIGraphicsGetCurrentContext()
        guard let ctx = context else { return nil }
        ctx.interpolationQuality = .none
        ctx.scaleBy(x: 1.0, y: -1.0)
        ctx.draw(cgImage!, in: ctx.boundingBoxOfClipPath)
        var image = UIGraphicsGetImageFromCurrentImageContext()!
        guard let centerImg = centerIcon else {
            UIGraphicsEndImageContext()
            return image
        }
        /// 中心图片
        UIGraphicsBeginImageContextWithOptions(image.size, true, .screenScale)
        let backW = image.size.width, backH = image.size.height;
        let centerW = centerSize.width, centerH = centerSize.height;
        let centerX = (backW - centerW)/2.0, centerY = (backH - centerH)/2.0;
        image.draw(in: CGRect(x: 0, y: 0, width: backW, height: backH))
        centerImg.draw(in: CGRect(x: centerX, y: centerY, width: centerW, height: centerH))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 生成条形码(一维码)
    /// - Parameters:
    ///   - barcode: 条形码对应的字符串
    ///   - width: 条形码宽度(高度按比例适应)
    ///   - barcodeColor: 条形码颜色
    ///   - barcodeBackColor: 条形码背景色
    /// - Returns: 条形码图片
    public static func image(
        barcode: String,
        width: CGFloat,
        barcodeColor: UIColor = UIColor.black,
        barcodeBackColor: UIColor = UIColor.white
    ) -> UIImage? {
        /// 条形码滤镜
        let filter = CIFilter(name: "CICode128BarcodeGenerator")
        filter?.setDefaults()
        /// 输入内容
        let inputData = barcode.data(using: .utf8)
        filter?.setValue(inputData, forKey: "inputMessage")
        guard let outputImage = filter?.outputImage else { return nil }
        /// 颜色滤镜
        let colorFilter = CIFilter(
            name: "CIFalseColor",
            parameters: [
                "inputImage": outputImage,
                "inputColor0": CIColor(cgColor: barcodeColor.cgColor),
                "inputColor1": CIColor(cgColor: barcodeBackColor.cgColor)
            ]
        )
        guard let outputColorImage = colorFilter?.outputImage else { return nil }
        let cgImage = CIContext().createCGImage(outputColorImage, from: outputColorImage.extent)
        let barcodeImg = UIImage(cgImage: cgImage!, scale: 1.0, orientation: .up)
        let rate = width/barcodeImg.size.width
        /// 条形码
        let imgW = barcodeImg.size.width * rate, imgH = barcodeImg.size.height * rate;
        let barcodeRect = CGRect(x: 0, y: 0, width: imgW, height: imgH)
        UIGraphicsBeginImageContextWithOptions(barcodeRect.size, true, .screenScale)
        let context = UIGraphicsGetCurrentContext()
        guard let ctx = context else {
            UIGraphicsEndImageContext()
            return nil
        }
        ctx.interpolationQuality = .none
        barcodeImg.draw(in: barcodeRect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 图片滤镜
    /// - Parameters:
    ///   - mode: 滤镜模式
    ///   - blurValue:  图像虚化值 一般设置 5~15
    ///   1. (.redEye: 修复红眼) | (.enhance: 修复红眼外的其他) | (.features: 增强饱和度)
    ///   2. (.crop: 修复裁剪) | (.level: 修复 level)
    ///   - options: 滤镜参数
    /// - Returns: 滤镜化图片
    public func image(
        filter mode: UIImage.FilterMode,
        blurValue: CGFloat = 10,
        options: [CIImageAutoAdjustmentOption : Any]? = nil
    ) -> UIImage? {
        var inputImage = CIImage(data: base.pngData()!)
        var filter: CIFilter!
        switch mode {
        case .effectNoir:
            filter = CIFilter(name:"CIPhotoEffectNoir")
        case .sepiaTone:
            filter = CIFilter(name:"CISepiaTone")
            filter!.setValue(0.8, forKey: "inputIntensity")
        case .blurEffect:
            filter = CIFilter(name:"CIGaussianBlur")
            /// 模糊半径值 值越大越明显
            filter.setValue(blurValue, forKey: kCIInputRadiusKey)
        }
        if let option = options {
            let filters = inputImage!.autoAdjustmentFilters(options: option)
            for filter: CIFilter in filters {
                filter.setValue(inputImage, forKey: kCIInputImageKey)
                inputImage = filter.outputImage
            }
        }
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        if let outputImage = filter.outputImage {
            /// 渲染上下文 CPU | GPU 都可以 没配置默认 CPU
            let context = CIContext(options:nil)
            /// 输出对象
            return UIImage(cgImage: context.createCGImage(outputImage, from: outputImage.extent)!)
        }
        return nil
    }
    
    /// 图片马赛克(全图|部分区域)
    /// 1. 全图马赛克: 像素化滤镜处理
    /// 2. 区域马赛克: 三个 CIImage 对象(全图马赛克 | 原图 | 蒙版) 通过 CIBlendWithMask 滤镜混合
    /// - Parameters:
    ///   - inputScale: 值越大则马赛克越明显 一般取值(5~25) 其中 5 以下不明显 25 以上会过于明显
    ///   - isFull: 是否全图马赛克
    ///   - region: 部分区域(相对其 bounds, 注意: 这里处理的单位参考像素,  则实际范围 bounds*2)
    /// - Returns: 马赛克图片
    public func image(
        mosaic inputScale: CGFloat = 0,
        isFull: Bool = true,
        region: (center: CGPoint, radius: CGFloat)? = nil
    ) -> UIImage? {
        let inputImage = CIImage(image: base)
        let filter = CIFilter(name: "CIPixellate")!
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        /// kCIInputScaleKey 对应的 Value 越大则马赛克越明显, 且 value 不能为 0 否则会清空像素色导致透明
        if inputScale > 0 {
            /// 若 inputScale == 0 则用系统默认 一般 value 范围是 5~25 (value 5 以下不明显, 25 以上过于明显)
            filter.setValue(inputScale, forKey: kCIInputScaleKey)
        }
        /// 区域马赛克
        var maskImage: CIImage!
        if isFull == false, let _ = region {
            /// 马赛克蒙版
            let temp = createMaskImage(inputImage!.extent, centerX: region!.center.x, centerY: region!.center.y, radius: region!.radius)
            if maskImage == nil {
                maskImage = temp
            }else {
                maskImage = CIFilter(
                   name: "CISourceOverCompositing",
                   parameters: [
                       kCIInputImageKey: temp,
                       kCIInputBackgroundImageKey: maskImage!
                   ]
               )!.outputImage!
            }
            if let outputImage = filter.outputImage {
                /// 混合图像输出
                let blendFilter = CIFilter(name: "CIBlendWithMask")!
                blendFilter.setValue(outputImage, forKey: kCIInputImageKey)
                blendFilter.setValue(inputImage, forKey: kCIInputBackgroundImageKey)
                blendFilter.setValue(maskImage, forKey: kCIInputMaskImageKey)
                if let outputImage = blendFilter.outputImage {
                    /// 渲染上下文 CPU | GPU 都可以 没配置默认 CPU
                    let context = CIContext(options:nil)
                    /// 输出对象
                    return UIImage(cgImage: context.createCGImage(outputImage, from: outputImage.extent)!)
                }
                return nil
            }
            return nil
        }
        if let outputImage = filter.outputImage {
            /// 渲染上下文 CPU | GPU 都可以 没配置默认 CPU
            let context = CIContext(options:nil)
            /// 输出对象
            return UIImage(cgImage: context.createCGImage(outputImage, from: outputImage.extent)!)
        }
        return nil
    }
    
    /// 检测二维码数据
    /// - Parameter options: 检测精度 默认高
    /// - Returns: 元组(二维码的个数 & 二维码内容)
    public func detectQRCode(
        _ options: [String: Any]? = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
    ) -> (count: Int, contents: [String]) {
        let inputImage = CIImage(image: base)
        /// 渲染上下文 CPU | GPU 都可以 没配置默认 CPU
        let context = CIContext(options:nil)
        let detector = CIDetector(
            ofType: CIDetectorTypeQRCode,
            context: context,
            options: options
        )
        var faceFeatures: [CIQRCodeFeature]!
        let orientation = inputImage!.properties[kCGImagePropertyOrientation as String]
        if orientation != nil {
            faceFeatures = detector!.features(
                in: inputImage!,
                options: [CIDetectorImageOrientation: orientation!]
            ) as? [CIQRCodeFeature]
        }else {
            faceFeatures = detector!.features(in: inputImage!) as? [CIQRCodeFeature]
        }
        var msgs: [String] = [String]()
        for faceFeature in faceFeatures {
            msgs.append(faceFeature.messageString ?? "")
        }
        return (faceFeatures.count, msgs)
    }
    
    /// 检测人脸图片  可对脸部区域进行标注
    /// - Parameters:
    ///   - borderColor: 边框颜色
    ///   - borderWidth: 边框宽度
    ///   - options: 检测精度 默认系统
    /// - Returns: 每个人脸的边框 view
    public func detectFace(
        borderColor: UIColor,
        borderWidth: CGFloat = 2,
        options: [String : Any]? = nil
    ) -> [UIView] {
        let inputImage = CIImage(image: base)
        /// 渲染上下文 CPU | GPU 都可以 没配置默认 CPU
        let context = CIContext(options:nil)
        let detector = CIDetector(
            ofType: CIDetectorTypeFace,
            context: context,
            options: options
        )
        var faceFeatures: [CIFaceFeature]!
        let orientation = inputImage!.properties[kCGImagePropertyOrientation as String]
        if orientation != nil {
            faceFeatures = detector!.features(
                in: inputImage!,
                options: [CIDetectorImageOrientation: orientation!]
            ) as? [CIFaceFeature]
        }else {
            faceFeatures = detector!.features(in: inputImage!) as? [CIFaceFeature]
        }
        /// 原图的缩放和 XY 偏移量
        let inputImageSize = inputImage!.extent.size
        var transform = CGAffineTransform.identity
        transform = transform.scaledBy(x: 1, y: -1)
        transform = transform.translatedBy(x: 0, y: -inputImageSize.height)
        /// 遍历全部的面部
        var views: Array = [UIView]()
        for faceFeature in faceFeatures {
            print(faceFeature)
            var faceBounds = faceFeature.bounds.applying(transform)
            /// 处理缩放和偏移量
            let scale = min(base.size.width/inputImageSize.width, base.size.height/inputImageSize.height)
            let offsetX = (base.size.width - inputImageSize.width * scale) / 2
            let offsetY = (base.size.height - inputImageSize.height * scale) / 2
            faceBounds = faceBounds.applying(CGAffineTransform(scaleX: scale, y: scale))
            faceBounds.origin.x += offsetX
            faceBounds.origin.y += offsetY
            /// 每个人脸对应一个边框
            let faceView = UIView(frame: faceBounds)
            faceView.layer.borderWidth = borderWidth
            faceView.layer.borderColor = borderColor.cgColor
            views.append(faceView)
        }
        return views
    }
    
    /// 检测人脸图片 可对脸部区域进行马赛克
    /// - Parameters:
    ///   - inputScale: 值越大则马赛克越明显 一般取值(5~25) 其中 5 以下不明显 25 以上会过于明显
    ///   - options: 检测精度 默认系统
    /// - Returns: 图片
    public func detectFace(
        inputScale: CGFloat,
        options: [String : Any]? = nil
    ) -> UIImage? {
        let inputImage = CIImage(image:  base)
        let filter = CIFilter(name: "CIPixellate")!
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        /// kCIInputScaleKey 对应的 Value 越大则马赛克越明显, 且 value 不能为 0 否则会清空像素色导致透明
        if inputScale > 0 {
            /// 若 inputScale == 0 则用系统默认 一般范围是 5~25 (5 以下不明显, 25 以上过于明显)
            filter.setValue(inputScale, forKey: kCIInputScaleKey)
        }
        /// 渲染上下文 CPU | GPU 都可以 没配置默认 CPU
        let context = CIContext(options:nil)
        let detector = CIDetector(
            ofType: CIDetectorTypeFace,
            context: context,
            options: options
        )
        var faceFeatures: [CIFaceFeature]!
        let orientation = inputImage!.properties[kCGImagePropertyOrientation as String]
        if orientation != nil {
            faceFeatures = detector!.features(
                in: inputImage!,
                options: [CIDetectorImageOrientation: orientation!]
            ) as? [CIFaceFeature]
        }else {
            faceFeatures = detector!.features(in: inputImage!) as? [CIFaceFeature]
        }
        var maskImage: CIImage!
        for faceFeature in faceFeatures {
            /// 为每张脸做层蒙版, 依据脸的宽度|高度等初始化 CIRadialGradient 滤镜
            let centerX = faceFeature.bounds.origin.x + faceFeature.bounds.size.width / 2
            let centerY = faceFeature.bounds.origin.y + faceFeature.bounds.size.height / 2
            let radius = min(faceFeature.bounds.size.width, faceFeature.bounds.size.height)
            /// 马赛克蒙版
            let temp = createMaskImage(inputImage!.extent, centerX: centerX, centerY: centerY, radius: radius)
            if maskImage == nil {
                maskImage = temp
            }else {
                maskImage = CIFilter(
                   name: "CISourceOverCompositing",
                   parameters: [
                       kCIInputImageKey: temp,
                       kCIInputBackgroundImageKey: maskImage!
                   ]
               )!.outputImage!
            }
            if let outputImage = filter.outputImage {
                /// 混合图像输出
                let blendFilter = CIFilter(name: "CIBlendWithMask")!
                blendFilter.setValue(outputImage, forKey: kCIInputImageKey)
                blendFilter.setValue(inputImage, forKey: kCIInputBackgroundImageKey)
                blendFilter.setValue(maskImage, forKey: kCIInputMaskImageKey)
                if let outputImage = blendFilter.outputImage {
                    /// 输出对象
                    return UIImage(cgImage: context.createCGImage(outputImage, from: outputImage.extent)!)
                }
                return nil
            }
            return nil
        }
        return nil
    }
    
    /// 图片蒙版区域
    /// - Parameters:
    ///   - rect: 范围
    ///   - centerX: 中心点 X
    ///   - centerY: 中心点 Y
    ///   - radius: 半径
    /// - Returns: CIImage 对象
    private func createMaskImage(
        _ rect: CGRect,
        centerX: CGFloat,
        centerY: CGFloat,
        radius:CGFloat
    ) -> CIImage {
        let filter = CIFilter(
            name: "CIRadialGradient",
            parameters: [
                "inputRadius0": radius,
                "inputRadius1": radius + 1,
                "inputColor0": CIColor(red: 0, green: 1, blue: 0, alpha: 1),
                "inputColor1": CIColor(red: 0, green: 0, blue: 0, alpha: 0),
                kCIInputCenterKey: CIVector(x: centerX, y: centerY)
            ]
        )
        /// CIRadialGradient 滤镜创建的图是无限大小的, 需对它进行裁剪
        return filter!.outputImage!.cropped(to: rect)
    }
}

//MARK: - 加载 Gif 图片
extension KcPrefixWrapper where Base: UIImage {
    
    /// 加载本地、网络等 gif 图片
    /// - Parameter url: 本地、网络路径
    /// - Returns: 图片
    public static func imageGif(url: String) -> UIImage? {
        guard let imgUrl = URL(string: url) else {
            if let localUrl = Bundle.main.url(forResource: url, withExtension: "gif") {
                guard let imgData = try? Data(contentsOf: localUrl) else {
                    return nil
                }
                return imageGif(data: imgData)
            }else {
                return nil
            }
        }
        guard let imgData = try? Data(contentsOf: imgUrl) else {
            return nil
        }
        return imageGif(data: imgData)
    }
    
    private static func imageGif(data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }
        return imageAnimatedWithSource(source)
    }
    
    private static func imageAnimatedWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        for index in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, index, nil) {
                images.append(image)
            }
            let delaySeconds = delayOfSourceIndex(Int(index), source: source)
            delays.append(Int(delaySeconds * 1000.0))
        }
        /// 时间 ms
        let duration: Int = {
            var sum = 0
            for val: Int in delays {
                sum += val
            }
            return sum
        }()
        /// 图片帧数据
        let picFrameCounts = picFrames(delays)
        var frame: UIImage
        var frameCount: Int
        var frames = [UIImage]()
        for index in 0..<count {
            frame = UIImage(cgImage: images[Int(index)])
            frameCount = Int(delays[Int(index)] / picFrameCounts)
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        let image = UIImage.animatedImage(
            with: frames,
            duration: Double(duration) / 1000.0
        )
        return image
    }
    
    private static func delayOfSourceIndex(_ index: Int, source: CGImageSource!) -> Double {
        /// 图像属性信息
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
        defer {
            gifPropertiesPointer.deallocate()
        }
        var delay = 0.1
        let unsafePointer = Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()
        if CFDictionaryGetValueIfPresent(
            cfProperties,
            unsafePointer,
            gifPropertiesPointer
        ) == false {
            return delay
        }
        let gifProperties: CFDictionary = unsafeBitCast(
            gifPropertiesPointer.pointee,
            to: CFDictionary.self
        )
        /// 延迟时间
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(
                gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()
            ), to: AnyObject.self
        )
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(
                CFDictionaryGetValue(
                    gifProperties,
                    Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()
                ), to: AnyObject.self
            )
        }
        if let delayObject = delayObject as? Double, delayObject > 0 {
            delay = delayObject
        }else {
            delay = 0.1
        }
        return delay
    }
    
    private static func picFrames(_ array: [Int]) -> Int {
        if array.isEmpty { return 1 }
        var frame = array[0]
        for val in array {
            frame = perPairFrame(val, frame)
        }
        return frame
    }
    
    private static func perPairFrame(_ lhs: Int?, _ rhs: Int?) -> Int {
        var lhs = lhs
        var rhs = rhs
        /// Check if one of them is nil
        if rhs == nil || lhs == nil {
            if rhs != nil {
                return rhs!
            }else if lhs != nil {
                return lhs!
            }else {
                return 0
            }
        }
        /// Swap for modulo
        if lhs! < rhs! {
            let ctp = lhs
            lhs = rhs
            rhs = ctp
        }
        /// Get greatest common divisor
        var rest: Int
        while true {
            rest = lhs! % rhs!
            if rest == 0 {
                return rhs!
            }else {
                lhs = rhs
                rhs = rest
            }
        }
    }
}

//MARK: - 相册操作
extension KcPrefixWrapper where Base: UIImage {
    
    /// 保存图片到相册
    public func saveImageToPhotoAlbum() {
        UIImageWriteToSavedPhotosAlbum(
            base,
            base,
            #selector(base.saveImage(image:didFinishSavingWithError:contextInfo:)),
            nil
        )
    }
}

extension UIImage {
    
    @discardableResult
    @objc fileprivate func saveImage(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) -> Bool {
        if error != nil {
            return false
        }else {
            return true
        }
    }
}
