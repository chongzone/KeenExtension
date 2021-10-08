//
//  UITextField+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/9/5.
//

import UIKit

extension UITextField {
    
    /// 文本框格式化的类型
    public enum FormatType: Int {
        /// 手机号 索引 [3, 8] 添加空格 限制 11 位
        case mobilePhone
        /// 身份证 索引 [6, 15] 添加空格 限制 18 位
        case identityCard
        /// 银行卡 索引 [4, 9, 14, 19] 添加空格 限制 19 位
        case bankCard
        /// 数字验证码|交易密码 限制 6 位
        case codeUnit
        /// 金额 限制 2 位小数
        case decimal
    }
}

//MARK: - 链式属性函数
extension UITextField {
    
    /// 代理
    /// - Parameter delegate: 代理
    /// - Returns: 自身
    @discardableResult
    public func delegate(_ delegate: UITextFieldDelegate?) -> Self {
        self.delegate = delegate
        return self
    }
    
    /// 文本
    /// - Parameter text: 文本
    /// - Returns: 自身
    @discardableResult
    public func text(_ text: String?) -> Self {
        self.text = text
        return self
    }
    
    /// 富文本
    /// - Parameter attributedString: 富文本
    /// - Returns: 自身
    @discardableResult
    public func attributedText(_ attributedString: NSAttributedString?) -> Self {
        attributedText = attributedString
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
    
    /// 富文本占位符
    /// - Parameter attributedString: 富文本
    /// - Returns: 自身
    @discardableResult
    public func attributedPlaceholder(_ attributedString: NSAttributedString?) -> Self {
        attributedPlaceholder = attributedString
        return self
    }
    
    /// 富文本的占位符
    /// - Parameters:
    ///   - placeHolder: 占位符内容
    ///   - font: 占位符字体
    ///   - color: 占位符颜色
    /// - Returns: 自身
    @discardableResult
    public func attributedPlaceholder(_ placeHolder: String, font: UIFont, color: UIColor) -> Self {
        let arrStr = NSMutableAttributedString(
            string: placeHolder,
            attributes: [.foregroundColor: color, .font: font]
        )
        attributedPlaceholder = arrStr
        return self
    }
    
    /// 字体 默认系统 12pt 字体
    /// - Parameter font: 字体
    /// - Returns: 自身
    @discardableResult
    public func font(_ font: UIFont?) -> Self {
        self.font = font
        return self
    }
    
    /// 字体 默认常规
    /// - Parameters:
    ///   - fontSize: 字体大小
    ///   - style: 字体样式
    /// - Returns: 自身
    @discardableResult
    public func font(_ fontSize: CGFloat, _ style: UIFont.FontStyle = .normal) -> Self {
        font = UIFont.fontSizeAdapter(fontSize, style)
        return self
    }
    
    /// 文本颜色
    /// - Parameter color: 颜色
    /// - Returns:  自身
    @discardableResult
    public func textColor(_ color: UIColor?) -> Self {
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
    
    /// 对齐方式  默认靠左
    /// - Parameter alignment: 对齐方式
    /// - Returns: 自身
    @discardableResult
    public func alignment(_ alignment: NSTextAlignment = .left) -> Self {
        textAlignment = alignment
        return self
    }
    
    /// 边框样式
    /// - Parameter style: 边框样式
    /// - Returns: 自身
    @discardableResult
    public func borderStyle(_ style: UITextField.BorderStyle = .none) -> Self {
        borderStyle = style;
        return self
    }
    
    /// 键盘样式
    /// - Parameter type: 键盘样式
    /// - Returns: 自身
    @discardableResult
    public func keyboardType(_ type: UIKeyboardType) -> Self {
        keyboardType = type
        return self
    }
    
    /// 键盘 return 键样式
    /// - Parameter type: 样式
    /// - Returns: 自身
    @discardableResult
    public func returnKeyType(_ type: UIReturnKeyType) -> Self {
        returnKeyType = type
        return self
    }
    
    /// 清除按钮模式 默认 never
    /// - Parameter mode: 模式
    /// - Returns: 自身
    @discardableResult
    public func clearButtonMode(_ mode: UITextField.ViewMode = .never) -> Self {
        clearButtonMode = mode
        return self
    }
    
    /// 再次编辑是否清空原有内容 默认  false
    /// - Parameter isClear: 是否清空原有内容
    /// - Returns: 自身
    @discardableResult
    public func clearsOnBeginEditing(_ isClear: Bool = false) -> Self{
        clearsOnBeginEditing = isClear
        return self
    }
    
    /// 文本加密 默认 false
    /// - Parameter isSecure: 是否加密
    /// - Returns: 自身
    @discardableResult
    public func isSecureText(_ isSecure: Bool = false) -> Self {
        isSecureTextEntry = isSecure
        return self
    }
    
    /// 是否纠错 默认 default
    /// - Parameter type: 类型
    /// - Returns: 自身
    @discardableResult
    public func autocorrectionType(_ type: UITextAutocorrectionType = .default) -> Self {
        autocorrectionType = type
        return self
    }
    
    /// 是否首字母大写 默认 none
    /// - Parameter type: 类型
    /// 1. none(默认) | words(单次首字母大写) | sentences(句子首字母大写) | allCharacters(所有字母大写)
    /// - Returns: 自身
    @discardableResult
    public func autocapitalizationType(_ type: UITextAutocapitalizationType = .none) -> Self {
        autocapitalizationType = type
        return self
    }
     
    /// 是否根据宽度字体自适应 默认 false
    /// - Parameter isAdjust: 是否自适应
    /// - Returns: 自身
    @discardableResult
    public func adjustsFontSizeToFitWidth(_ isAdjust: Bool = false) -> Self {
        adjustsFontSizeToFitWidth = isAdjust
        return self
    }
    
    /// 字体最小的缩放系数 默认 0.0
    /// - Parameter scale: 缩放系数
    /// - Returns: 自身
    @discardableResult
    public func minimumFontSize(_ scale: CGFloat = 0.0) -> Self {
        minimumFontSize = scale
        return self
    }
    
    /// 正常状态下的背景图片
    /// - Parameter image: 背景图片 应可拉伸
    /// - Returns: 自身
    @discardableResult
    public func background(_ image: UIImage?) -> Self {
        borderStyle(.none)
        background = image
        return self
    }
    
    /// 失效状态下的背景图片
    /// - Parameter image: 背景图片 应可拉伸
    /// - Returns: 自身
    @discardableResult
    public func disabledBackground(_ image: UIImage?) -> Self {
        disabledBackground = image
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
extension KcPrefixWrapper where Base: UITextField {
    
    /// 获取文本内容 默认去除所有的空格换行
    /// - Parameter trimAll: YES(去除所有的空格换行) NO(仅去除文本前后的空格换行)
    /// - Returns: 文本内容
    public func content(_ trimAll: Bool = true) -> String? {
        return base.text?.kc.trim(trimAll)
    }
    
    /// 设置左视图的边距
    /// - Parameter padding: 边距
    public func leftView(_ padding: CGFloat) {
        base.leftView = UIView(x: 0, y: 0, width: padding, height: base.kc.height)
        base.leftViewMode = UITextField.ViewMode.always
    }
    
    /// 设置左视图的图片
    /// - Parameters:
    ///   - image: 图片名称
    ///   - viewWidth: 左视图的宽度
    ///   - imageSize: 图片大小
    public func leftView(_ image: UIImage?, viewWidth: CGFloat, imageSize: CGSize) {
        let view = UIView(x: 0, y: 0, width: viewWidth, height: base.kc.height)
        let imgView = UIImageView(image: image)
        imgView.frame = CGRect(
            x: viewWidth - imageSize.width - 8,
            y: midY(imageSize.height),
            width: imageSize.width,
            height: imageSize.height
        )
        view.addSubview(imgView)
        base.leftView = view
        base.leftViewMode = UITextField.ViewMode.always
    }
    
    /// 设置右视图的边距
    /// - Parameter padding: 边距
    public func rightView(_ padding: CGFloat) {
        base.rightView = UIView(x: 0, y: 0, width: padding, height: base.kc.height)
        base.rightViewMode = UITextField.ViewMode.always
    }
    
    /// 设置右视图的图片
    /// - Parameters:
    ///   - image: 图片名称
    ///   - viewWidth: 右视图的宽度
    ///   - imageSize: 图片大小
    public func rightView(_ image: UIImage?, viewWidth: CGFloat, imageSize: CGSize) {
        let view = UIView(x: 0, y: 0, width: viewWidth, height: base.kc.height)
        let imgView = UIImageView(image: image)
        imgView.frame = CGRect(
            x: viewWidth - imageSize.width - 8,
            y: midY(imageSize.height),
            width: imageSize.width,
            height: imageSize.height
        )
        view.addSubview(imgView)
        base.rightView = view
        base.rightViewMode = UITextField.ViewMode.always
    }
}

//MARK: - 文本格式化
extension KcPrefixWrapper where Base: UITextField {
    
    /// 控制文本框的输入格式化
    /// - Parameters:
    ///   - field: 文本框
    ///   - type: 文本框类型
    ///   - range: 字符串范围
    ///   - string: 新字符串
    /// - Returns: Bool 值
    public static func textField(
        _ field: UITextField,
        type: UITextField.FormatType,
        range: NSRange,
        replacementString string: String
    ) -> Bool {
        switch type {
        case .mobilePhone:
            return __configField(
                field,
                range: range,
                replacementString: string,
                locations: [3, 8],
                limitCount: 11
            )
        case .identityCard:
            return __configField(
                field,
                range: range,
                replacementString: string,
                locations: [6, 15],
                limitCount: 18
            )
        case .bankCard:
            return __configField(
                field,
                range: range,
                replacementString: string,
                locations: [4, 9, 14, 19],
                limitCount: 19
            )
        case .codeUnit:
            if range.location <= 5 {
                if string.count > 0 {
                    return string.kc.isExistDigit
                }else {
                    return true
                }
            }else {
                return false
            }
        case .decimal:
             return __configDecimalField(
                field,
                range: range,
                replacementString: string
             )
        }
    }
    
    /// 文本框的输入格式化
    /// - Parameters:
    ///   - field: 文本框
    ///   - range: 范围
    ///   - string: 新字符串
    ///   - locations: 格式化控制的位置集合
    ///   - limitCount: 限制位数
    /// - Returns: Bool 值
    private static func __configField(
        _ field: UITextField,
        range: NSRange,
        replacementString string: String,
        locations: Array<Int>,
        limitCount: Int
    ) -> Bool {
        var limit = true
        if (limitCount == 0) { limit = false }
        if string == "" { // 删除
            if range.length == 1 { // 删除一位
                if range.location == field.text!.count - 1 { // 最后位置
                    return true
                }else { // 不是最后位置
                    var offset = range.location
                    if range.location < field.text!.count,
                       field.text!.kc.char(at: range.location) == " ",
                       field.selectedTextRange!.isEmpty {
                        field.deleteBackward()
                        offset -= 1
                    }
                    field.deleteBackward()
                    field.text = insertString(field.text!, locations: locations)
                    __configCursorLocation(field, offset: offset)
                    return false
                }
            }else if range.length > 1 {
                var lastLocation = false;
                /// 是否最后一位
                if (range.location + range.length == field.text!.count) {
                    lastLocation = true;
                }
                field.deleteBackward()
                field.text = insertString(field.text!, locations: locations)
                if (lastLocation == false) {
                    __configCursorLocation(field, offset: range.location)
                }
                return false;
            }else {
                return true
            }
        }else if string.count > 0 {
            if limit {
                let newString = field.text!.kc.replace(of: " ", with: "")
                if (newString.count + string.count - range.length > limitCount) {
                    return false
                }
            }
            field.insertText(string)
            field.text = insertString(field.text!, locations: locations)
            var offset = range.location + string.kc.length
            for location in locations {
                if range.location == location {
                    offset += 1
                }
            }
            __configCursorLocation(field, offset: offset)
            return false
        }
        return true
    }
    
    /// 文本框数字的输入格式化
    /// - Parameters:
    ///   - field: 文本框
    ///   - range: 范围
    ///   - string: 新字符串
    /// - Returns: Bool 值
    private static func __configDecimalField(
        _ field: UITextField,
        range: NSRange,
        replacementString string: String
    ) -> Bool {
        let index = field.text!.kc.indexOf(".")
        /// 光标在点后面
        if field.kc.fieldSelectedRange().location > index, index != -1 {
            let subString = field.text?.kc.substring(form: index)
            if string != "" {
                /// 已有两位小数
                if let sub = subString, sub.count > 2, index != -1 {
                    return false
                }
            }
        }
        if string != "" {
            var numbers: CharacterSet?
            __configCursorLocation(field, offset: range.location)
            if index == -1, range.location != 0 {
                numbers = CharacterSet.init(charactersIn: "0123456789.\n").inverted
                if range.location >= 9 {
                    if string == ".", range.location == 9 {
                        return true
                    }else {
                        return false
                    }
                }else {
                    /// 保证两位小数
                    if string == ".", field.text!.count > range.location {
                        let str1 = field.text?.kc.insert(
                            string,
                            at: range.location
                        )
                        field.text = str1!.kc.substring(to: range.location+2)
                        return false
                    }
                }
            }else {
                numbers = CharacterSet(charactersIn: "0123456789\n").inverted
            }
            let zero = field.text!.kc.indexOf("0")
            if zero == 0 {
                if string != "0",
                   string != ".",
                   field.text!.count == 1 {
                    field.text = string
                    return false
                }else {
                    if index == -1 {
                        if string == "0" {
                            return false
                        }
                    }
                }
            }
            let component = string.components(separatedBy: numbers!).joined()
            if component != string {
                return false
            }
            if index != -1, range.location > index + 2 {
                return false
            }
            return field.text!.count <= 11
        }else {
            return true
        }
    }
    
    /// 光标位置
    /// - Parameters:
    ///   - field: 文本框
    ///   - offset: 文本偏移量
    private static func __configCursorLocation(_ field: UITextField, offset: Int) {
        let newPosition = field.position(from: field.beginningOfDocument, offset: offset)
        field.selectedTextRange = field.textRange(from: newPosition!, to: newPosition!)
    }
    
    /// 插入新字符串
    /// - Parameters:
    ///   - aString: 新字符串
    ///   - locations: 插入的位置集合
    /// - Returns: 新字符串
    private static func insertString(_ aString: String, locations: Array<Int>) -> String? {
        if aString.isEmpty { return nil }
        let newStr = aString.kc.replace(of: " ", with: "")
        var resultStr = newStr
        for location in locations {
            if resultStr.count > location {
                resultStr = resultStr.kc.insert(" ", at: location)
            }
        }
        return resultStr
    }
    
    private func fieldSelectedRange() -> NSRange {
        let from = base.selectedTextRange?.start
        let to = base.selectedTextRange?.end
        let location = base.offset(from: base.beginningOfDocument, to: from!)
        let length = base.offset(from: from!, to: to!)
        return NSRange(location: location, length: length)
    }
}
