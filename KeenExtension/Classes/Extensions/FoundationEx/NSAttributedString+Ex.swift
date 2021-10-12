//
//  NSAttributedString+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/6/30.
//

import UIKit

//MARK: - 链式属性函数
/**
 * 常见的富文本属性
 * .font 字体大小
 * .foregroundColor 字体颜色
 * .paragraphStyle 段落排版
 * .backgroundColor 背景色
 * .attachment 文本附件 用于图文混排
 *
 * .link 链接
 * .strikethroughStyle 删除线
 * .strikethroughColor 删除线颜色 默认黑色
 * .underlineStyle 下划线
 * .underlineColor 下划线颜色 默认黑色
 *
 * .shadow 阴影
 * .textEffect 文本特殊效果 取值 图版 |印刷
 * .strokeColor 填充部分颜色
 * .strokeWidth 笔画宽度属性 负值填充效果 正值中空效果
 *
 * .kern 字符间距 正值间距加宽 负值间距变窄
 * .ligature 连体属性 0 (没有连体字符) 1 (默认的连体字符)
 *
 * .baselineOffset 基线偏移值 正值上偏 负值下偏
 * .obliqueness 字形倾斜度 正值右倾 负值左倾
 * .expansion 文本横向拉伸属性 取值 正值横向拉伸 负值横向压缩
 *
 * .writingDirection 文字书写方向 取值 从左向右 | 从右向左
 * .verticalGlyphForm 文字排版方向 0 (横排文本) 1 (竖排文本)
 */
extension KcPrefixWrapper where Base: NSMutableAttributedString {
    
    /// 富文本颜色
    /// - Parameter color: 富文本颜色
    /// - Returns: 自身
    @discardableResult
    public func color(_ color: UIColor) -> Self {
        base.addAttributes(
            [.foregroundColor: color],
            range: NSMakeRange(0, base.length)
        )
        return self
    }
    
    /// 富文本颜色
    /// - Parameter hexValue: 富文本颜色
    /// - Returns: 自身
    @discardableResult
    public func color(_ hexValue: Int) -> Self {
        base.addAttributes(
            [.foregroundColor: UIColor.kc.color(hexValue: hexValue)],
            range: NSMakeRange(0, base.length)
        )
        return self
    }
    
    /// 富文本字体
    /// - Parameter font: 字体
    /// - Returns: 自身
    @discardableResult
    public func font(_ font: UIFont) -> Self {
        base.addAttributes(
            [.font: font],
            range: NSMakeRange(0, base.length)
        )
        return self
    }
    
    /// 富文本字体 默认常规
    /// - Parameters:
    ///   - fontSize: 字体大小
    ///   - style: 字体样式
    /// - Returns: 自身
    @discardableResult
    public func font(_ fontSize: CGFloat, _ style: UIFont.FontStyle = .normal) -> Self {
        base.addAttributes(
            [.font: UIFont.fontSizeAdapter(fontSize, style)],
            range: NSMakeRange(0, base.length)
        )
        return self
    }
    
    /// 富文本背景色
    /// - Parameter color: 富文本背景色
    /// - Returns: 自身
    @discardableResult
    public func backColor(_ color: UIColor) -> Self {
        base.addAttributes(
            [.backgroundColor: color],
            range: NSMakeRange(0, base.length)
        )
        return self
    }
    
    /// 富文本背景色
    /// - Parameter hexValue: 富文本背景色
    /// - Returns: 自身
    @discardableResult
    public func backColor(_ hexValue: Int) -> Self {
        base.addAttributes(
            [.backgroundColor: UIColor.kc.color(hexValue: hexValue)],
            range: NSMakeRange(0, base.length)
        )
        return self
    }
    
    /// 段落样式
    /// - Returns: 自身
    @discardableResult
    public func paragraphStyle(_ style: NSMutableParagraphStyle) -> Self {
        base.addAttributes(
            [.paragraphStyle: style],
            range: NSMakeRange(0, base.length)
        )
        return self
    }
    
    /// 删除线 默认单线
    /// - Parameters:
    ///   - color: 删除线的颜色
    ///   - style: 删除线的样式
    /// - Returns: 自身
    @discardableResult
    public func throughLine(_ color: UIColor = .black, style: NSUnderlineStyle) -> Self {
        base.addAttributes(
            [.strikethroughStyle: style,
             .strikethroughColor: color],
            range: NSMakeRange(0, base.length)
        )
        return self
    }
    
    /// 下划线 默认单线
    /// - Parameters:
    ///   - color: 下划线的颜色
    ///   - style: 下划线的样式
    /// - Returns: 自身
    @discardableResult
    public func underLine(_ color: UIColor = .black, style: NSUnderlineStyle) -> Self {
        base.addAttributes(
            [.underlineStyle: style,
             .underlineColor: color],
            range: NSMakeRange(0, base.length)
        )
        return self
    }
    
    /// 移除属性
    /// - Parameter name: 属性名称
    /// - Returns: 自身
    @discardableResult
    public func remove(_ name: NSAttributedString.Key) -> Self {
        base.removeAttribute(name, range: NSMakeRange(0, base.length))
        return self
    }
}

//MARK: - 基础功能
extension KcPrefixWrapper where Base: NSAttributedString {
    
    /// 首行缩进
    /// - Parameter indent: 缩进宽度
    /// - Returns: 富文本
    public func firstLineHeadIndent(_ indent: CGFloat) -> NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.firstLineHeadIndent = indent
        return attributes(
            attributes: [.paragraphStyle: style],
            range: NSRange(location: 0, length: base.length)
        )
    }
    
    /// 指定文本区域的字体
    /// - Parameters:
    ///   - font: 字体
    ///   - range: 区域范围
    /// - Returns: 富文本
    public func attributes(font: UIFont, range: NSRange) -> NSAttributedString {
        return attributes(attributes: [.font: font], range: range)
    }
    
    /// 指定文本的字体
    /// - Parameters:
    ///   - text: 文本内容
    ///   - font: 字体
    /// - Returns: 富文本
    public func attributes(_ text: String, font: UIFont) -> NSAttributedString {
        return attributes(text, attributes: [.font: font])
    }
    
    /// 指定文本区域的颜色
    /// - Parameters:
    ///   - color: 颜色
    ///   - range: 区域范围
    /// - Returns: 富文本
    public func attributes(color: UIColor, range: NSRange) -> NSAttributedString {
        return attributes(attributes: [.foregroundColor: color], range: range)
    }
    
    /// 指定文本的颜色
    /// - Parameters:
    ///   - text: 文本内容
    ///   - color: 颜色
    /// - Returns: 富文本
    public func attributes(_ text: String, color: UIColor) -> NSAttributedString {
        return attributes(text, attributes: [.foregroundColor: color])
    }
    
    /// 文本区域的行间距
    /// - Parameters:
    ///   - lineSpace: 行间距
    ///   - alignment: 对齐方式
    ///   - range: 区域范围
    /// - Returns: 富文本
    public func attributes(
        lineSpace: CGFloat,
        alignment: NSTextAlignment,
        range: NSRange
    ) -> NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpace
        style.alignment = alignment
        return attributes(attributes: [.paragraphStyle: style], range: range)
    }
    
    /// 指定文本的行间距
    /// - Parameters:
    ///   - text: 文本内容
    ///   - lineSpace: 行间距
    ///   - alignment: 对齐方式
    /// - Returns: 富文本
    public func attributes(
        _ text: String,
        lineSpace: CGFloat,
        alignment: NSTextAlignment
    ) -> NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpace
        style.alignment = alignment
        return attributes(text, attributes: [.paragraphStyle: style])
    }
    
    /// 指定文本区域的删除线 默认单线
    /// - Parameters:
    ///   - color: 删除线的颜色
    ///   - range: 区域范围
    ///   - style: 删除线的样式
    /// - Returns: 富文本
    public func attributes(
        throughLineColor color: UIColor,
        range: NSRange,
        throughLineStyle style: NSUnderlineStyle = .single
    ) -> NSAttributedString {
        return attributes(
            attributes: [.strikethroughStyle: style, .strikethroughColor: color],
            range: range
        )
    }
    
    /// 指定文本的删除线 默认单线
    /// - Parameters:
    ///   - text: 文本内容
    ///   - color: 删除线的颜色
    ///   - style: 删除线的样式
    /// - Returns: 富文本
    public func attributes(
        _ text: String,
        throughLineColor color: UIColor,
        throughLineStyle style: NSUnderlineStyle = .single
    ) -> NSAttributedString {
        return attributes(
            text,
            attributes: [.strikethroughStyle: style, .strikethroughColor: color]
        )
    }
    
    /// 指定文本区域的下划线 默认单线
    /// - Parameters:
    ///   - color: 下划线的颜色
    ///   - range: 区域范围
    ///   - style: 下划线的样式
    /// - Returns: 富文本
    public func attributes(
        underLineColor color: UIColor,
        range: NSRange,
        underLineStyle style: NSUnderlineStyle = .single
    ) -> NSAttributedString {
        return attributes(
            attributes: [.underlineStyle: style, .underlineColor: color],
            range: range
        )
    }
    
    /// 指定文本的下划线 默认单线
    /// - Parameters:
    ///   - text: 文本内容
    ///   - color: 下划线的颜色
    ///   - style: 下划线的样式
    /// - Returns: 富文本
    public func attributes(
        _ text: String,
        underLineColor color: UIColor,
        underLineStyle style: NSUnderlineStyle = .single
    ) -> NSAttributedString {
        return attributes(
            text,
            attributes: [.underlineStyle: style, .underlineColor: color]
        )
    }
    
    /// 指定文本的属性
    /// - Parameters:
    ///   - text: 文本内容
    ///   - attributes: 属性
    /// - Returns: 富文本
    public func attributes(
        _ text: String,
        attributes: Dictionary<NSAttributedString.Key, Any>
    ) -> NSAttributedString {
        let mAttrStr = NSMutableAttributedString(attributedString: base)
        let ranges = base.string.kc.toNSRanges(of: [text])
        if !ranges.isEmpty {
            for key in attributes.keys {
                for range in ranges {
                    mAttrStr.addAttribute(key, value: attributes[key] ?? "", range: range)
                }
            }
        }
        return mAttrStr
    }
    
    /// 指定文本区域的属性
    /// - Parameters:
    ///   - attributes: 属性
    ///   - range: 区域范围
    /// - Returns: 富文本
    public func attributes(
        attributes: Dictionary<NSAttributedString.Key, Any>,
        range: NSRange
    ) -> NSAttributedString {
        let mAttrStr = NSMutableAttributedString(attributedString: base)
        for key in attributes.keys {
            mAttrStr.addAttribute(key, value: attributes[key] ?? "", range: range)
        }
        return mAttrStr
    }
    
    /// 插入附件(图文混排) 支持网络(完整路径)&本地(相对路径)
    /// - Parameters:
    ///   - font: 文本字体
    ///   - attachPath: 附件路径 
    ///   - attachIndex: 附件位置
    /// - Returns: 富文本
    public func attributes(
        font: UIFont,
        insert attachPath: String,
        attachIndex: Int
    ) -> NSAttributedString {
        let attr = NSMutableAttributedString(attributedString: base)
        var image: UIImage?
        if attachPath.hasPrefix("http") {
            do {
                let imageData = try Data(contentsOf: URL(string: attachPath)!)
                image = UIImage(data: imageData)!
            } catch {
                image = nil
            }
        }else {
            image = UIImage(named: attachPath)
        }
        if let img = image {
            let attachment = NSTextAttachment()
            attachment.image = img
            attachment.bounds = CGRect(
                x: 0,
                y: round((font.capHeight - img.size.height) * 0.5),
                width: img.size.width,
                height: img.size.height
            )
            attr.insert(NSAttributedString(attachment: attachment), at: attachIndex)
        }
        return attr
    }
}
