//
//  UITextView+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/9/5.
//

import UIKit

//MARK: - 链式属性函数
extension UITextView {
    
    /// 代理
    /// - Parameter delegate: 代理
    /// - Returns: 自身
    @discardableResult
    public func delegate(_ delegate: UITextViewDelegate?) -> Self {
        self.delegate = delegate
        return self
    }
    
    /// 文本
    /// - Parameters:
    ///   - text: 文本
    /// - Returns: 自身
    @discardableResult
    public func text(_ text: String) -> Self {
        self.text = text
        return self
    }
    
    /// 富文本
    /// - Parameter attributedText: 富文本
    /// - Returns: 自身
    @discardableResult
    public func attributedText(_ attributedText: NSAttributedString) -> Self {
        self.attributedText = attributedText
        return self
    }
    
    /// 文本占位符
    /// - Parameter text: 占位符
    /// - Returns: 自身
    @discardableResult
    public func placeholder(_ text: String?) -> Self {
        placeholder = text
        return self
    }
    
    /// 字体
    /// - Parameter font: 字体
    /// - Returns: 自身
    @discardableResult
    public func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    /// 字体 默认常规
    /// - Parameters:
    ///   - fontSize: 字体大小
    ///   - style: 字体样式  默认常规
    /// - Returns: 自身
    @discardableResult
    public func font(_ fontSize: CGFloat, _ style: UIFont.FontStyle = .normal) -> Self {
        font = UIFont.fontSizeAdapter(fontSize, style)
        return self
    }
    
    /// 占位符字体
    /// - Parameter font: 字体
    /// - Returns: 自身
    @discardableResult
    public func placeholdFont(_ font: UIFont) -> Self {
        placeholdFont = font
        return self
    }
    
    /// 文本颜色
    /// - Parameter color: 颜色
    /// - Returns: 自身
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
    
    /// 占位符颜色
    /// - Parameter color: 颜色
    /// - Returns: 自身
    @discardableResult
    public func placeholdColor(_ color: UIColor) -> Self {
        placeholdColor = color
        return self
    }
    
    /// 占位符原始位置
    /// - Parameter origin: 位置
    /// - Returns: 自身
    @discardableResult
    public func placeholderOrigin(_ origin: CGPoint) -> Self {
        placeholderOrigin = origin
        return self
    }
    
    /// 高度是否根据其内容自动适应
    /// - Parameter auto: 是否高度自适应
    /// - Returns: 自身
    @discardableResult
    public func autoHeight(_ auto: Bool) -> Self {
        autoHeight = auto
        return self
    }
    
    /// 对齐方式 默认靠左
    /// - Parameter alignment: 对齐方式
    /// - Returns: 自身
    @discardableResult
    public func alignment(_ alignment: NSTextAlignment = .left) -> Self {
        textAlignment = alignment
        return self
    }
    
    /// 是否可编辑
    /// - Parameter able: 是否可编辑
    /// - Returns: 自身
    @discardableResult
    public func isEditable(_ able: Bool) -> Self {
        isEditable = able
        return self
    }
    
    /// 是否可被选
    /// - Parameter able: 是否可被选
    /// - Returns: 自身
    @discardableResult
    public func isSelectable(_ able: Bool) -> Self {
        isSelectable = able
        return self
    }
    
    /// 选择区域
    /// - Parameter range: 区域
    /// - Returns: 自身
    @discardableResult
    public func selectedRange(_ range: NSRange) -> Self {
        selectedRange = range
        return self
    }
    
    /// 内边距
    /// - Parameter edge: 内边距
    /// - Returns: 自身
    @discardableResult
    public func textInset(_ edge: UIEdgeInsets) -> Self {
        textContainerInset = edge
        return self
    }
    
    /// 是否自动给特殊字符加上链接 默认都不加链接
    /// - Parameter type: 特殊字符类型
    /// - Returns: 自身
    @discardableResult
    public func dataDetectorTypes(_ type: UIDataDetectorTypes = []) -> Self {
        dataDetectorTypes = type
        return self
    }
    
    /// 是否允许编辑富文本 默认 false
    /// - Parameter enable: 是否允许编辑
    /// - Returns: 自身
    @discardableResult
    public func allowsEditingTextAttributes(_ enable: Bool = false) -> Self {
        allowsEditingTextAttributes = enable
        return self
    }
    
    /// 键盘自定义视图
    /// - Parameter inputView: 自定义视图
    /// - Returns: 自身
    @discardableResult
    public func inputView(_ inputView: UIView?) -> Self {
        self.inputView = inputView
        return self
    }
    
    /// 依附在键盘上的辅助视图
    /// - Parameter accessoryView: 自定义的视图
    /// - Returns: 自身
    @discardableResult
    public func inputAccessoryView(_ accessoryView: UIView?) -> Self {
        inputAccessoryView = accessoryView
        return self
    }
    
    /// 监听文本框内容变化
    /// - Parameter selector: 响应回调
    /// - Returns: 自身
    @discardableResult
    public func textDidChangeEvent(selector: Selector) -> Self {
        NotificationCenter.default
            .addObserver(
                self,
                selector: selector,
                name: UITextField.textDidChangeNotification,
                object: nil
            )
        return self
    }
}

//MARK: - 基本功能
extension KcPrefixWrapper where Base: UITextView {
    
    /// 获取文本内容 默认去除所有的空格换行
    /// - Parameter trimAll: YES(去除所有的空格换行) NO(仅去除文本前后的空格换行)
    /// - Returns: 文本内容
    public func content(_ trimAll: Bool = true) -> String? {
        return base.text?.kc.trim(trimAll)
    }
}

//MARK: - 常见功能
extension UITextView {
    
    /// 占位符内容
    public var placeholder: String? {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedPlaceholder
            ) as? String
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedPlaceholder,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            __configPlaceholder(newValue!)
        }
    }
    
    /// 占位符字体  默认常规 15pt
    public var placeholdFont: UIFont {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedPlaceholdFont
            ) as? UIFont ?? .font_15
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedPlaceholdFont,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            if placeholderLabel != nil {
                placeholderLabel!.font = newValue
            }
        }
    }
    
    /// 占位符颜色 默认 #999999
    public var placeholdColor: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedPlaceholdColor
            ) as? UIColor ?? .color03
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedPlaceholdColor,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            if placeholderLabel != nil {
                placeholderLabel!.textColor = newValue
            }
        }
    }
    
    /// 占位符 Origin 默认 CGPoint(x: 7, y: 7)
    public var placeholderOrigin: CGPoint {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedPlaceholderOrigin
            ) as? CGPoint ?? CGPoint(x: 7, y: 7)
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedPlaceholderOrigin,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            if placeholderLabel != nil {
                placeholderLabel!.kc.origin = newValue
            }
        }
    }
    
    /// 高度是否自动变化 默认 false 针对文本框内容的实际高度大于其初始设定的高度的情况
    public var autoHeight: Bool {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedAutoHeight
            ) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedAutoHeight,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// 允许输入的最大内容字数 优先级高于 maxLinesCount
    public var maxKernCount: NSNumber? {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedMaxKernCount
            ) as? NSNumber
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedMaxKernCount,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            __configKernCountLabel(newValue!)
        }
    }
    
    /// 允许输入的最大行数 优先级低于 maxKernCount
    public var maxLinesCount: NSNumber? {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedMaxLinesCount
            ) as? NSNumber
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedMaxLinesCount,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(limitEvent),
                name: UITextView.textDidChangeNotification,
                object: nil
            )
        }
    }
    
    /// 右下角的字数统计控件字体  默认常规 15pt
    public var kernCountFont: UIFont {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedKernCountFont
            ) as? UIFont ?? .font_15
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedKernCountFont,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            if kernCountLabel != nil {
                kernCountLabel!.font = newValue
            }
        }
    }
    
    /// 右下角的字数统计控件颜色 默认 #333333
    public var kernCountColor: UIColor {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedKernCountColor
            ) as? UIColor ?? .color01
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedKernCountColor,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            if kernCountLabel != nil {
                kernCountLabel!.textColor = newValue
            }
        }
    }
    
    /// 占位符控件
    private var placeholderLabel: UILabel? {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedPlaceholderLabel
            ) as? UILabel
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedPlaceholderLabel,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// 右下角的字数统计控件
    private var kernCountLabel: UILabel? {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedKernCountLabel
            ) as? UILabel
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedKernCountLabel,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// 原始 frame
    private var originalFrame: CGRect? {
        get {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.associatedOriginalFrame
            ) as? CGRect
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.associatedOriginalFrame,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// 占位符控件
    /// - Parameter placeholder: 占位符内容
    private func __configPlaceholder(_ placeholder: String) {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textChange(_:)),
            name: UITextView.textDidChangeNotification,
            object: self
        )
        if placeholderLabel != nil { placeholderLabel?.removeFromSuperview() }
        placeholderLabel = UILabel()
            .numberOfLines(0)
            .font(placeholdFont)
            .textColor(placeholdColor)
            .lineMode(.byTruncatingTail)
            .isHidden(text.count > 0 ? true : false)
            .text(placeholder)
            .addViewTo(self)
        
        let labelW = self.kc.width - placeholderOrigin.x * 2
        let size = placeholder.kc.calculateSize(font: placeholdFont, width: labelW)
        placeholderLabel!.frame = CGRect(
            x: placeholderOrigin.x,
            y: placeholderOrigin.y,
            width: labelW,
            height: size.height
        )
        originalFrame = frame
    }
    
    /// 右下角的字数统计控件
    /// - Parameter maxCount: 字数最大个数
    private func __configKernCountLabel(_ maxCount: NSNumber) {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(limitEvent),
            name: UITextView.textDidChangeNotification,
            object: nil
        )
        if kernCountLabel != nil { kernCountLabel?.removeFromSuperview() }
        kernCountLabel = UILabel()
            .alignment(.right)
            .textColor(kernCountColor)
            .font(kernCountFont)
            .text("\(text.count)/\(maxCount)")
            .frame(CGRect(x: self.kc.x, y: self.kc.bottom - 20, width: self.kc.width - 10, height: 20))
        
        if let sView = self.superview {
            /// 固定到其父视图 保证其不会随着 textView 滑动
            kernCountLabel?.addViewTo(sView)
        }else {
            kernCountLabel?.addViewTo(self)
        }
        if text.count > maxCount.kc.toInt {
            text = text.kc.substring(to: maxCount.kc.toInt)
        }
    }
    
    /// 监听文本输入事件
    @objc private func textChange(_ notification : Notification) {
        let textView = notification.object as! UITextView;
        text = textView.text;
        if placeholder != nil {
            placeholderLabel?.isHidden = text.count == 0 ? false : true
        }
        if maxKernCount != nil {
            var kernCount = text.count
            if kernCount > (maxKernCount?.kc.toInt)! {
                kernCount = (maxKernCount?.kc.toInt)!
            }
            let limitCount = maxKernCount?.kc.toString
            kernCountLabel?.text = "\(kernCount)/\(limitCount!)"
        }
        /// 高度自动变化处理
        if autoHeight == true {
            let size = text.kc.calculateSize(font: font!, width: contentSize.width - textContainer.lineFragmentPadding * 2)
            UIView.animate(withDuration: 0.15) { [weak self] in
                guard let wself = self else { return }
                let padding = wself.placeholderOrigin.y * 2
                let originH = wself.originalFrame!.height
                wself.frame = CGRect(
                    x: wself.kc.x,
                    y: wself.kc.y,
                    width: wself.kc.width,
                    height: size.height + padding < originH ? originH : size.height + padding
                )
                if wself.kernCountLabel != nil {
                    wself.kernCountLabel?.kc.y = wself.kc.bottom - 20
                }
            }
        }
    }
    
    /// 字数限制监听事件
    @objc private func limitEvent() {
        /// 字符数限制
        if maxKernCount != nil {
            if text.count > (maxKernCount?.kc.toInt)! && maxKernCount != nil {
                text = text.kc.substring(to: (maxKernCount?.kc.toInt)!)
            }
        }else {
            /// 行数限制
            if (maxLinesCount != nil) {
                var size = text.kc.calculateSize(font: font!, width: contentSize.width - 10)
                let height = font!.lineHeight * CGFloat(maxLinesCount!.kc.toFloat)
                if (size.height > height) {
                    while size.height > height {
                        text = text.kc.substring(to: text.count - 1)
                        size = text.kc.calculateSize(font: font!, width: contentSize.width - 10)
                    }
                }
            }
        }
    }
    
    private struct AssociatedKey {
        static var associatedPlaceholder: Void?
        static var associatedPlaceholdFont: Void?
        static var associatedPlaceholdColor: Void?
        static var associatedPlaceholderOrigin: Void?
        
        static var associatedAutoHeight: Void?
        static var associatedMaxKernCount: Void?
        static var associatedMaxLinesCount: Void?
        static var associatedKernCountFont: Void?
        static var associatedKernCountColor: Void?
        static var associatedOriginalFrame: Void?
        
        static var associatedPlaceholderLabel: Void?
        static var associatedKernCountLabel: Void?
    }
}
