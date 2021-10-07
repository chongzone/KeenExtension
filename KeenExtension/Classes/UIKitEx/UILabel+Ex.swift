//
//  UILabel+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/6/30.
//

import UIKit

//MARK: - 链式属性函数
extension UILabel {
    
    /// 文本
    /// - Parameters:
    ///   - text: 文本
    /// - Returns: 自身
    @discardableResult
    public func text(_ text: String?) -> Self {
        self.text = text
        return self
    }
    
    /// 富文本
    /// - Parameter attributedText: 富文本
    /// - Returns: 自身
    @discardableResult
    public func attributedText(_ attributedText: NSAttributedString?) -> Self {
        self.attributedText = attributedText
        return self
    }
    
    /// 文本字体
    /// - Parameter font: 字体
    /// - Returns: 自身
    @discardableResult
    public func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    /// 文本字体 默认常规
    /// - Parameters:
    ///   - fontSize: 字体大小
    ///   - style: 字体样式
    /// - Returns: 自身
    @discardableResult
    public func font(
        _ fontSize: CGFloat,
        _ style: UIFont.FontStyle = .normal
    ) -> Self {
        font = UIFont.fontSizeAdapter(fontSize, style)
        return self
    }
    
    /// 文本颜色
    /// - Parameter color: 颜色
    /// - Returns:  自身
    @discardableResult
    public func textColor(_ color: UIColor) -> Self {
        textColor = color
        return self
    }
    
    /// 文本颜色
    /// - Parameter hexValue: 色值
    /// - Returns: 自身
    @discardableResult
    public func textColor(_ hexValue: Int) -> Self {
        textColor = UIColor.kc.color(hexValue: hexValue)
        return self
    }
    
    /// 高亮状态的颜色
    /// - Parameter color: 颜色
    /// - Returns: 自身
    @discardableResult
    public func highlightedTextColor(_ color: UIColor?) -> Self {
        highlightedTextColor = color
        return self
    }
    
    /// 是否高亮 默认 false
    /// - Parameter highlighted: 是否高亮
    /// - Returns: 自身
    @discardableResult
    public func isHighlighted(_ highlighted: Bool = false) -> Self {
        isHighlighted = highlighted
        return self
    }
    
    /// 文本阴影色
    /// - Parameter color: 阴影色
    /// - Returns: 自身
    @discardableResult
    public func shadowColor(_ color: UIColor?) -> Self {
        shadowColor = color
        return self
    }
    
    /// 文本阴影偏移量 默认 CGSizeMake(0, -1)
    /// - Parameter offset: 阴影偏移量
    /// - Returns: 自身
    @discardableResult
    public func shadowOffset(_ offset: CGSize = CGSize(width: 0, height: -1)) -> Self {
        shadowOffset = offset
        return self
    }
    
    /// 行数 默认 1 行
    /// - Parameter number: 行数
    /// - Returns: 自身
    @discardableResult
    public func numberOfLines(_ number: Int = 1) -> Self {
        numberOfLines = number
        return self
    }
    
    /// 截取模式 默认 byTruncatingTail
    /// - Parameter mode: 模式
    /// 1. byWordWrapping(按词拆分) | byCharWrapping(按字符拆分) | byClipping(将多余的部分截断)
    /// 2. byTruncatingHead(省略头部文字) | byTruncatingTail(省略尾部文字) | byTruncatingMiddle(省略中间部分文字)
    /// - Returns: 自身
    @discardableResult
    public func lineMode(_ mode: NSLineBreakMode = .byTruncatingTail) -> Self {
        lineBreakMode = mode
        return self
    }
    
    /// 对齐方式
    /// - Parameter alignment: 对齐方式 默认靠左
    /// - Returns: 自身
    @discardableResult
    public func alignment(_ alignment: NSTextAlignment = .left) -> Self {
        textAlignment = alignment
        return self
    }
    
    /// 是否允许绘制 默认 true
    /// - Parameter enable: 是否允许
    /// - Returns: 自身
    @discardableResult
    public func isEnabled(_ enable: Bool = true) -> Self {
        isEnabled = enable
        return self
    }
    
    /// 是否根据宽度字体自适应 默认 false 配合 minimumScaleFactor & baselineAdjustment 实现
    /// - Parameter isAdjust: 是否自适应
    /// - Returns: 自身
    @discardableResult
    public func adjustsFontSizeToFitWidth(_ isAdjust: Bool = false) -> Self {
        adjustsFontSizeToFitWidth = isAdjust
        return self
    }
    
    /// 字体最小的缩放系数
    /// - Parameter scale: 缩放系数
    /// - Returns: 自身
    @discardableResult
    public func minimumScaleFactor(_ scale: CGFloat) -> Self {
        minimumScaleFactor = scale
        return self
    }
    
    /// 自适应的基线 默认 alignBaselines
    /// - Parameter adjustment: 类型
    /// - Returns: 自身
    @discardableResult
    public func baselineAdjustment(_ adjustment: UIBaselineAdjustment = .alignBaselines) -> Self {
        baselineAdjustment = adjustment
        return self
    }
    
    /// 多行标签时的最大布局宽度
    /// - Parameter maxWidth: 最大宽度
    /// - Returns: 自身
    @discardableResult
    public func preferredMaxLayoutWidth(_ maxWidth: CGFloat) -> Self {
        preferredMaxLayoutWidth = maxWidth
        return self
    }
}

//MARK: - 基础功能
extension KcPrefixWrapper where Base: UILabel {
    
    /// 文本是否被截取
    public func isLineBreak() -> Bool {
        guard let labelText = base.text else { return false }
        let labelSize = labelText.kc.calculateSize(font: base.font, width: base.kc.width)
        let labelLines = Int(ceil(CGFloat(labelSize.height) / base.font.lineHeight))
        var realLines = Int(floor(CGFloat(base.kc.height) / base.font.lineHeight))
        if base.numberOfLines != 0 {
            realLines = min(realLines, base.numberOfLines)
        }
        return labelLines > realLines
    }
    
    /// 文本大小
    /// - Parameters:
    ///   - width: 文本宽度
    ///   - height: 文本高度
    /// - Returns: 文本内容的 size
    public func labelSize(width: CGFloat, height: CGFloat) -> CGSize {
        return base.sizeThatFits(CGSize(width: width, height: height))
    }
    
    /// 首行缩进
    /// - Parameter indent: 缩进宽度
    public func firstLineHeadIndent(_ indent: CGFloat) {
        base.attributedText = base.attributedText?.kc.firstLineHeadIndent(indent)
    }
    
    /// 文本字符间距
    /// - Parameter kernSpace: 字符间距大小
    public func attributes(kernSpace: CGFloat) {
        guard let t = base.text else { return }
        base.attributedText = base.attributedText?.kc.attributes(
            t,
            attributes: [.kern: kernSpace]
        )
    }
    
    /// 文本行间距
    /// - Parameter lineSpace: 行间距大小
    public func attributes(lineSpace: CGFloat) {
        guard let t = base.text else { return }
        base.attributedText = base.attributedText?.kc.attributes(
            t,
            lineSpace: lineSpace,
            alignment: .left
        )
    }
    
    /// 文本字间距和行间距
    /// - Parameters:
    ///   - kernSpace: 字间距
    ///   - lineSpace: 行间距
    public func attributes(kernSpace: CGFloat, lineSpace: CGFloat) {
        guard let t = base.text else { return }
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpace
        base.attributedText = base.attributedText?.kc.attributes(
            t,
            attributes: [.kern: kernSpace, .paragraphStyle: style]
        )
    }
    
    /// 指定文本区域的字体
    /// - Parameters:
    ///   - font: 字体
    ///   - range: 区域范围
    public func attributes(font: UIFont, range: NSRange) {
        base.attributedText = base.attributedText?.kc.attributes(
            font: font,
            range: range
        )
    }
    
    /// 指定文本的字体
    /// - Parameters:
    ///   - text: 文本内容
    ///   - font: 字体
    public func attributes(_ text: String, font: UIFont) {
        base.attributedText = base.attributedText?.kc.attributes(text, font: font)
    }
    
    /// 指定文本区域的删除线 默认单线
    /// - Parameters:
    ///   - color: 删除线的颜色
    ///   - range: 区域范围
    ///   - style: 删除线的样式
    public func attributes(
        throughLineColor color: UIColor,
        range: NSRange,
        throughLineStyle style: NSUnderlineStyle = .single
    ) {
        base.attributedText = base.attributedText?.kc.attributes(
            throughLineColor: color,
            range: range,
            throughLineStyle: style
            
        )
    }
    
    /// 指定文本的删除线 默认单线
    /// - Parameters:
    ///   - text: 文本内容
    ///   - color: 删除线的颜色
    ///   - style: 删除线的样式
    public func attributes(
        _ text: String,
        throughLineColor color: UIColor,
        throughLineStyle style: NSUnderlineStyle = .single
    ) {
        base.attributedText = base.attributedText?.kc.attributes(
            text,
            throughLineColor: color,
            throughLineStyle: style
        )
    }
    
    /// 指定文本区域的下划线 默认单线
    /// - Parameters:
    ///   - color: 下划线的颜色
    ///   - range: 区域范围
    ///   - stytle: 下划线的样式
    public func attributes(
        underLineColor color: UIColor,
        range: NSRange,
        underLineStyle stytle: NSUnderlineStyle = .single) {
        base.attributedText = base.attributedText?.kc.attributes(
            underLineColor: color,
            range: range,
            underLineStyle: stytle
        )
    }
    
    /// 指定文本的下划线 默认单线
    /// - Parameters:
    ///   - text: 文本内容
    ///   - color: 下划线的颜色
    ///   - stytle: 下划线的样式
    public func attributes(
        _ text: String,
        underLineColor color: UIColor,
        underLineStyle stytle: NSUnderlineStyle = .single) {
        base.attributedText = base.attributedText?.kc.attributes(
            text,
            underLineColor: color,
            underLineStyle: stytle
        )
    }
    
    /// 插入附件(图文混排) 支持网络(完整路径)&本地(相对路径)
    /// - Parameters:
    ///   - attachPath: 附件路径
    ///   - attachIndex: 附件位置
    public func attributes(insert attachPath: String, attachIndex: Int) {
        let attrs = base.attributedText?.kc.attributes(
            font: base.font,
            insert: attachPath,
            attachIndex: attachIndex
        )
        base.lineMode(.byCharWrapping).attributedText(attrs)
    }
}
