//
//  String+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/6/15.
//

import Foundation

extension String {
    
    /// 时间条样式
    public enum TimebarStyle: Int {
        case hour
        case minute
        case second
        case normal
    }
}

//MARK: - 索引扩展
extension String {
    
    /// 指定索引的字符 索引从 0 开始
    public subscript(_ idx: Int) -> Character {
        get {
            return self[index(startIndex, offsetBy: idx)]
        }
        set {
            var arr: [Character] = Array(self)
            arr[idx] = newValue
            self = String(arr)
        }
    }
    
    /// 指定索引位置的字符组成新的字符串 索引从 0 开始
    public subscript(_ idxs: Int...) -> String {
        var str: String = String()
        for idx in idxs {
            str.append(self[idx])
        }
        return str
    }
    
    /// 指定索引范围的字符组成新的字符串 [start..<end]
    public subscript(_ idxs: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: idxs.lowerBound)
        let end = index(startIndex, offsetBy: idxs.upperBound)
        return String(self[start..<end])
    }
    
    /// 指定索引范围的字符组成新的字符串 [start...end]
    public subscript(_ idxs: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: idxs.lowerBound)
        let end = index(startIndex, offsetBy: idxs.upperBound)
        return String(self[start...end])
    }
    
    /// 指定索引范围的字符组成新的字符串 [start...]
    public subscript(_ idxs: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: idxs.lowerBound)
        let end = index(startIndex, offsetBy: count - 1)
        return String(self[start...end])
    }
    
    /// 指定索引范围的字符组成新的字符串 [...end]
    public subscript(_ idxs: PartialRangeThrough<Int>) -> String    {
        let end = index(startIndex, offsetBy: min(idxs.upperBound, count - 1))
        return String(self[startIndex...end])
    }
    
    /// 指定索引范围的字符组成新的字符串 [..<end]
    public subscript(_ idxs: PartialRangeUpTo<Int>) -> String {
        let end = index(startIndex, offsetBy: min(idxs.upperBound, count))
        return String(self[startIndex..<end])
    }
}

//MARK: - 基础功能
extension String: KcPrefixWrapperCompatibleValue {}

extension KcPrefixWrapper where Base == String {
    
    /// 转 Int32
    public var toInt: Int32 { (base as NSString).intValue }
    /// 转 Int
    public var toInteger: Int { (base as NSString).integerValue }
    /// 转 Int64
    public var toLongLong: Int64 { (base as NSString).longLongValue }
    /// 转 Float
    public var toFloat: Float { (base as NSString).floatValue }
    /// 转 Double
    public var toDouble: Double { (base as NSString).doubleValue }
    /// 转 NSNumber
    public var toNumber: NSNumber { NSNumber(value: toDouble) }
    /// 转 Bool 默认 false
    public var toBool: Bool {
        if base.lowercased() == "true" {
            return (base as NSString).boolValue
        }
        return false
    }
    /// 是否 Null
    public var isNaN: Bool { toDouble.isNaN }
    /// 长度 处理含有 emoji 协议的字符
    public var length: Int { base.utf16.count }
    
    /// 首字符
    public var first: String { String(base[base.startIndex]) }
    /// 尾字符
    public var last: String { String(base[base.index(before: base.endIndex)]) }
    /// 首字符小写
    public var firstLower: String { base.kc.replace(with: first.lowercased(), 0...0) }
    /// 首字符大写
    public var firstUpper: String { base.kc.replace(with: first.uppercased(), 0...0) }
    /// 字符串字符对应的 ASCII 数字值
    public var ascii: Int { Int(base.unicodeScalars.first!.value) }
    /// 字符串数字对应的ASCII字符值
    public var ASCII: Character { Character(UnicodeScalar(Int(base)!)!) }
    
    /// 指定索引位置的字符 索引从 0 开始
    public func char(at location: Int) -> String {
        return String(base[base.index(base.startIndex, offsetBy: location)])
    }
    /// 转 NSString
    public var toNSString: NSString { base as NSString }
    
    /// 反转字符串
    public func reverse() -> String { String(base.reversed()) }
    
    /// 复制
    public func toCopy() {
        UIPasteboard.general.string = base
    }
    /// 转图片
    public var toImage: UIImage? {
        return UIImage(named: base)
    }
    
    /// 转数字百分比
    public var toPercentString: String {
        guard base.count >= 1 else {
            return base
        }
        guard base.hasPrefix("%") else {
            return base
        }
        return base + "%"
    }
    
    /// 转竖直样式的字符内容
    public var toVerticalText: String {
        let str = NSMutableString(string: base)
        for idx in 1..<base.count {
            str.insert("\n", at: idx*2-1)
        }
        return str as String
    }
    
    /// 转字符数组
    public var toArrs: [String] {
        if base.count == 0 {
            return [""]
        }
        var arrs = [String]()
        for idx in 0..<base.count {
            arrs.append(base[base.index(base.startIndex, offsetBy: idx)].description)
        }
        return arrs
    }
    
    /// 转 URL
    public var toURL: URL? {
        if let URL = URL(string: base) {
            return URL
        }
        let set = CharacterSet()
            .union(.urlHostAllowed)
            .union(.urlPathAllowed)
            .union(.urlQueryAllowed)
            .union(.urlFragmentAllowed)
        return base.addingPercentEncoding(withAllowedCharacters: set).flatMap { URL(string: $0) }
    }
    
    /// 十六进制转 int
    /// - Parameter hexString: 十六进制字符串
    /// - Returns: int
    public func toInt(hexString: String) -> Int {
        let str = hexString.uppercased()
        var sum = 0
        for i in str.utf8 {
            /// 0-9 从48开始
            sum = sum * 16 + Int(i) - 48
            /// A-Z 从65开始且初始值10 则应减去55
            if i >= 65 {
                sum -= 7
            }
        }
        return sum
    }
    
    /// 数字字符串加法
    /// - Parameter aString: 字符串
    /// - Returns: 字符串
    public func adding(_ aString: String?) -> String {
        var ln = NSDecimalNumber(string: base)
        var rn = NSDecimalNumber(string: aString)
        if ln.kc.isNaN { ln = .zero }
        if rn.kc.isNaN { rn = .zero }
        return ln.adding(rn).kc.toString
    }
    
    /// 数字字符串减法
    /// - Parameter aString: 字符串
    /// - Returns: 字符串
    public func subtracting(_ aString: String?) -> String {
        var ln = NSDecimalNumber(string: base)
        var rn = NSDecimalNumber(string: aString)
        if ln.kc.isNaN { ln = .zero }
        if rn.kc.isNaN { rn = .zero }
        return ln.subtracting(rn).kc.toString
    }
    
    /// 数字字符串乘法
    /// - Parameter aString: 字符串
    /// - Returns: 字符串
    public func multiplying(_ aString: String?) -> String {
        var ln = NSDecimalNumber(string: base)
        var rn = NSDecimalNumber(string: aString)
        if ln.kc.isNaN { ln = .zero }
        if rn.kc.isNaN { rn = .zero }
        return ln.multiplying(by: rn).kc.toString
    }
    
    /// 数字字符串除法
    /// - Parameter aString: 字符串
    /// - Returns: 字符串
    public func dividing(_ aString: String?) -> String {
        var ln = NSDecimalNumber(string: base)
        var rn = NSDecimalNumber(string: aString)
        if ln.kc.isNaN { ln = .zero }
        if rn.kc.isNaN || rn.kc.toDouble == 0 { rn = .one }
        return ln.dividing(by: rn).kc.toString
    }
    
    /// 数字字符串幂方 默认平方
    /// - Returns: 字符串
    public func raising(_ power: Int = 2) -> String {
        var ln = NSDecimalNumber(string: base)
        if ln.kc.isNaN { ln = .zero }
        return ln.raising(toPower: power).kc.toString
    }
}

//MARK: - 常见功能
extension KcPrefixWrapper where Base == String {
    
    /// 字符串首次|最后出现的索引位置 默认查找首次出现的位置
    /// - Parameters:
    ///   - aString: 字符串
    ///   - reversed: 是否首次|最后出现的索引
    /// - Returns: 对应的索引
    public func indexOf(_ aString: String, reversed: Bool = false) -> Int {
        var idx = -1
        if let r = base.range(of: aString, options: reversed ? .backwards : .literal) {
            if !r.isEmpty {
                idx = base.distance(from: base.startIndex, to: r.lowerBound)
            }
        }
        return idx
    }
    
    /// 取出字符串中的数字
    /// - Returns: 数字字符串
    public func digitString() -> String {
        let digits = CharacterSet.decimalDigits.inverted
        return base.components(separatedBy: digits).joined(separator: "")
    }
    
    /// 是否包含某个字符串 默认不区分大小写
    /// - Parameters:
    ///   - aString: 字符串
    ///   - ignore: 是否区分大小写
    /// - Returns: Bool 值
    public func contains(_ aString: String, ignore: Bool = true) -> Bool {
        if ignore {
            return base.range(of: aString, options: .caseInsensitive) != nil
        }else {
            return base.range(of: aString) != nil
        }
    }
    
    /// 是否包含 Emoji 表情
    /// - Returns: Bool 值
    public func containsEmoji() -> Bool {
        for i in 0...base.kc.length {
            let c: unichar = (base as NSString).character(at: i)
            if (0xD800 <= c && c <= 0xDBFF) || (0xDC00 <= c && c <= 0xDFFF) {
                return true
            }
        }
        return false
    }
    
    /// 是否以某个字符串开始 默认不区分大小写
    /// - Parameters:
    ///   - aString: 字符串
    ///   - ignore: 是否区分大小写
    /// - Returns: Bool 值
    public func start(with aString:String, ignore: Bool = true) -> Bool {
        if ignore {
            return NSPredicate(format: "SELF BEGINSWITH[cd] %@", aString).evaluate(with: base)
        }else {
            return NSPredicate(format: "SELF BEGINSWITH %@", aString).evaluate(with: base)
        }
    }
    
    /// 是否以某个字符串结尾 默认不区分大小写
    /// - Parameters:
    ///   - aString: 字符串
    ///   - ignore: 是否区分大小写
    /// - Returns: Bool 值
    public func end(with aString: String, ignore: Bool = true) -> Bool {
        if ignore {
            return NSPredicate(format: "SELF ENDSWITH[cd] %@", aString).evaluate(with: base)
        }else {
            return NSPredicate(format: "SELF ENDSWITH %@", aString).evaluate(with: base)
        }
    }
    
    /// 转整数 默认四舍五入
    /// - Parameter isRound: 否四舍五入 默认 true
    /// - Returns: 整型字符串
    public func toIntNumber(_ isRound: Bool = true) -> String {
        if isRound {
            return String(format: "%.f", base.kc.toFloat)
        }else {
            let newNumber = NSDecimalNumber(string: base).kc.toInt
            return NSNumber(value: newNumber).kc.toString
        }
    }
    
    /// 转 x 位小数 默认 2 位小数且四舍五入
    /// - Parameters:
    ///   - decimal: 默认 2 位小数
    ///   - isRound: 是否四舍五入 默认 true
    /// - Returns: x 位小数
    public func toDecimalNumber(
        _ decimal: Int = 2,
        _ isRound: Bool = true
    ) -> String {
        let result = NSDecimalNumber.kc.decimalNumber(
            base,
            decimal: decimal,
            isRound: isRound
        ).kc.toString
        return String(format: "%.\(decimal)f", result.kc.toDouble)
    }
    
    /// 转格式化数字 (3 位一组)
    /// - Parameters:
    ///   - decimal: 小数点位数 默认 2 当小数位 0 时 即只显示整数部分
    ///   - isRound: 是否四舍五入 默认 true
    /// - Returns: 格式化完成的字符串
    public func toFormatNumber(
        _ decimal: Int = 2,
        _ isRound: Bool = true
    ) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let number = NSDecimalNumber.kc.decimalNumber(base, decimal: 3, isRound: isRound)
        guard decimal > 0 else {
            return formatter.string(from: number)!.kc.split(".").first!
        }
        return formatter.string(from: number)!.kc.addDecimalZero(decimal)
    }
    
    /// 万单位转换规则(1 万以下直接显示 反之用万表示) 默认万以上数字保留 2 位小数
    /// - Parameter decimal: 几位小数 默认 2 位
    /// - Returns: 字符串
    public func toMillionString(_ decimal: Int = 2) -> String {
        if base.kc.toDouble < 0 {
            return "0"
        }else if base.kc.toDouble <= 9999 {
            return "\(base)"
        }else {
            let doub = base.kc.toDouble / 10000
            let str = String(format: "%.\(decimal)f", doub)
            let start_index = str.index(str.endIndex, offsetBy: -1)
            let suffix = String(str[start_index ..< str.endIndex])
            if suffix == "0" {
                let toIndex = str.index(str.endIndex, offsetBy: -2)
                return String(str[str.startIndex ..< toIndex]) + "万"
            } else {
                return str + "万"
            }
        }
    }
    
    /// 中文转拼音(搜索、通讯录等场景)
    /// - Parameter isVoice: 是否要声调 默认不需要
    /// - Returns: 拼音字符串
    public func toSpell(_ isVoice: Bool = false) -> String {
        let str = NSMutableString(string: base)
        /// 带声调拼音
        CFStringTransform(str, nil, kCFStringTransformToLatin, false)
        if isVoice == false {
            /// 不带声调拼音
            CFStringTransform(str, nil, kCFStringTransformStripDiacritics, false)
        }
        return String(str).kc.trim()
    }
    
    /// 每个中文首字母 默认大写
    /// - Parameter isUpper: 是否大写 默认大写
    /// - Returns: 首字母组成的字符串
    public func toSpellFirst(_ isUpper: Bool = true) -> String {
        let spell = toSpell(false).kc.split(" ")
        let initials = spell.compactMap { String(format: "%c", $0.cString(using:.utf8)![0]) }
        return isUpper ? initials.joined().uppercased() : initials.joined()
    }
    
    /// JSON字符串转字典
    /// - Returns: 字典
    public func toJson() -> [String : Any]? {
        let data = base.data(using: .utf8)
        if let dic = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String : Any] {
            return dic
        }
        return nil
    }
    
    /// JSON字符串转数组
    /// - Returns: 数组
    public func toJsons() -> [Any]? {
        let data = base.data(using: .utf8)
        if let array = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? Array<Any> {
            return array
        }
        return nil
    }
    
    /// Range 转 NSRange
    /// - Parameter range: Range
    /// - Returns: NSRange
    public func toNSRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: base.utf16)
        let to = range.upperBound.samePosition(in: base.utf16)
        return NSRange(
            location: base.utf16.distance(from: base.utf16.startIndex, to: from!),
            length: base.utf16.distance(from: from!, to: to!)
        )
    }
    
    /// NSRange 转 Range
    /// - Parameter nsRange: NSRange
    /// - Returns: Range
    public func toRange(from nsRange: NSRange) -> Range<String.Index>? {
        guard let from16 = base.utf16.index(
            base.utf16.startIndex,
            offsetBy: nsRange.location,
            limitedBy: base.utf16.endIndex
        ),
        let to16 = base.utf16.index(
            from16,
            offsetBy: nsRange.length,
            limitedBy: base.utf16.endIndex
        ),
        let from = Base.Index(from16, within: base),
        let to = Base.Index(to16, within: base)
        else { return nil }
        return from ..< to
    }
    
    /// 字符串数组转为对应的的 NSRange 数组
    /// - Parameter aStrings: 字符串数组
    /// - Returns: NSRange 数组
    public func toNSRanges(of aStrings: [String]) -> [NSRange] {
        var ranges = [NSRange]()
        for str in aStrings {
            if base.kc.contains(str) {
                var subIdx = 0
                let subs = base.kc.split(str)
                for i in 0 ..< (subs.count - 1) {
                    let sub = subs[i]
                    if i == 0 {
                        subIdx += (sub.lengthOfBytes(using: .unicode) / 2)
                    }else {
                        subIdx = (sub.lengthOfBytes(using: .unicode) / 2)
                        subIdx += (subIdx + str.lengthOfBytes(using: .unicode) / 2)
                    }
                    let newRange = NSRange(location: subIdx, length: str.count)
                    ranges.append(newRange)
                }
            }
        }
        return ranges
    }
    
    /// 字符串数组转为对应的的 range 数组
    /// - Parameter aStrings: 字符串数组
    /// - Returns: range 数组
    public func toRanges(of aStrings: Array<String>) -> [Range<String.Index>] {
        var ranges = [Range<String.Index>]()
        for str in aStrings {
            if base.kc.contains(str) {
                var subIdx = 0
                let subs = base.kc.split(str)
                for i in 0 ..< (subs.count - 1) {
                    let sub = subs[i]
                    if i == 0 {
                        subIdx += (sub.lengthOfBytes(using: .unicode) / 2)
                    }else {
                        subIdx = (sub.lengthOfBytes(using: .unicode) / 2)
                        subIdx += (subIdx + str.lengthOfBytes(using: .unicode) / 2)
                    }
                    let newRange = NSRange(location: subIdx, length: str.count)
                    ranges.append(base.kc.toRange(from: newRange)!)
                }
            }
        }
        return ranges
    }
    
    /// 计算字符串宽高
    /// - Parameters:
    ///   - font: 字体
    ///   - width: 设定的宽度
    ///   - height: 设定的高度
    ///   - kernSpace: 字符间距
    ///   - lineSpace: 行间距
    /// - Returns: CGSize 值
    public func calculateSize(
        font: UIFont,
        width: CGFloat = CGFloat.greatestFiniteMagnitude,
        height: CGFloat = CGFloat.greatestFiniteMagnitude,
        kernSpace: CGFloat = 0,
        lineSpace: CGFloat = 0
    ) -> CGSize {
        if kernSpace == 0, lineSpace == 0 {
            let rect = base.boundingRect(
                with: CGSize(width: width, height: height),
                options: .usesLineFragmentOrigin,
                attributes: [.font: font],
                context: nil
            )
            return CGSize(width: ceil(rect.width), height: ceil(rect.height))
        }else {
            let rect = CGRect(x: 0, y: 0, width: width, height: height)
            let label = UILabel(frame: rect).font(font).text(base).numberOfLines(0)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineSpace
            let attr = NSMutableAttributedString(
                string: base,
                attributes: [.kern : kernSpace]
            )
            attr.addAttribute(
                .paragraphStyle,
                value: style,
                range: NSMakeRange(0, base.count)
            )
            label.attributedText = attr
            return label.sizeThatFits(rect.size)
        }
    }
    
    /// 修饰字符串特定字符(数字字符)的字体&颜色
    /// - Parameters:
    ///   - font: 字符串字体
    ///   - color: 字符串颜色
    ///   - specificFont: 特定字符串的字体
    ///   - specificColor: 特定字符串的颜色
    /// - Returns: 富文本
    public func digitAttributes(
        normal font: UIFont,
        noramal color: UIColor,
        specificFont: UIFont,
        specificColor: UIColor
    ) -> NSMutableAttributedString {
        let attributeStr = NSMutableAttributedString(
            string: base,
            attributes: [.font: font, .foregroundColor: color]
        )
        for idx in 0..<base.count {
            let char = base.utf8[base.index(base.startIndex, offsetBy: idx)]
            if char > 47 && char < 58 {
                attributeStr.addAttributes(
                    [.font: specificFont, .foregroundColor: specificColor],
                    range: NSRange(location: idx, length: 1)
                )
            }
        }
        return attributeStr
    }
    
    /// 随机字符串  默认 字母+数字
    /// - Parameters:
    ///   - count: 随机字符串长度
    ///   - aString: 随机字符串范围 默认 字母和数字组成
    /// - Returns: 指定位数的随机字符串
    public static func randomString(
        _ count: Int,
        _ aString: String = "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    ) -> String {
        var result = ""
        for _ in 0..<count {
            result += aString.kc.substring(
                at: Int(arc4random()) % aString.count,
                length: 1
            )
        }
        return result
    }
    
    /// 隐藏手机号中间4位 默认用 * 代替
    /// - Parameter replaceStr: 替换的字符串
    /// - Returns: 隐藏的手机号
    public func hidePhone(_ replaceStr: String = "****") -> String {
        let phone = base.kc.trim()
        if phone.count >= 11 {
            return phone.kc.replace(with: replaceStr, 3...6)
        }else {
            return base
        }
    }
    
    /// 打电话
    public func callIPhone() {
        let str = "tel://"+base
        if let utlStr = URL(string: str) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(utlStr, options: [:], completionHandler: nil)
            }else {
                UIApplication.shared.openURL(utlStr)
            }
        }
    }
    
    /// 添加小数位
    /// - Parameter decimal: 小数位
    /// - Returns: 字符串
    private func addDecimalZero(_ decimal: Int) -> String {
        if decimal <= 0 { return base }
        let subStrings = base.kc.split(".")
        guard subStrings.count > 0 || subStrings.count <= 2  else { return base }
        if subStrings.count == 1 {
            var sub = subStrings[0] + "."
            for _ in 0..<decimal {
                sub += "0"
            }
            return sub
        }
        let sub_1 = subStrings[0]
        var sub_2 = subStrings[1]
        if sub_2.count == decimal {
            return base
        }
        let poor = decimal - sub_2.count
        if poor > 0 {
            for _ in 0..<poor {
                sub_2 += "0"
            }
        }
        return sub_1 + "." + sub_2
    }
}

//MARK: - 增删改查
extension KcPrefixWrapper where Base == String {
    
    /// 字符串拆分为字符串数组
    /// - Parameter aString: 拆分字符串的分隔符
    /// - Returns: 字符串数组
    public func split(_ aString: String) -> [String] {
        return base.components(separatedBy: aString)
    }
    
    /// 在任意位置插入字符串
    /// - Parameters:
    ///   - aString: 插入的内容
    ///   - location: 插入的位置
    /// - Returns: 插入后的新字符串
    public func insert(_ aString: String, at location: Int) -> String {
        if !(location < base.count) {
            assert(location < base.count, "越界, 检查设置的范围")
        }
        let str1 = substring(to: location - 1)
        let str2 = substring(form: location)
        return str1 + aString + str2
    }
    
    /// 截取从 index...endIndex 子字符串 索引从 0 开始
    /// - Parameter index: 开始位置
    /// - Returns: 字符串
    public func substring(form index: Int) -> String {
        if !(index < base.count) {
            assert(index < base.count, "越界, 检查设置的范围")
        }
        let rang = base.index(base.startIndex, offsetBy: index)..<base.endIndex
        return String(base[rang])
    }
    
    /// 截取从 startIndex...index 子字符串 索引从 0 开始
    /// - Parameter index: 结束位置
    /// - Returns: 字符串
    public func substring(to index: Int) -> String {
        if index > base.count {
            return base
        }
        let rang = ...base.index(base.startIndex, offsetBy: index)
        return String(base[rang])
    }
    
    /// 截取特定范围的字符串 索引从 0 开始
    /// - Parameter range: 闭区间
    /// - Returns: 字符串
    public func substring(with range: CountableClosedRange<Int>) -> String {
        let start = base.index(base.startIndex, offsetBy: max(0, range.lowerBound))
        let end   = base.index(
            base.startIndex,
            offsetBy: min(base.count, range.upperBound)
        )
        return String(base[start...end])
    }
    
    /// 截取特定范围的字符串 索引从 0 开始
    /// - Parameters:
    ///   - location: 开始的索引位置
    ///   - length: 截取长度
    /// - Returns: 字符串
    public func substring(at location: Int, length: Int) -> String {
        if location > base.count || (location+length > base.count) {
            assert(location < base.count && location+length <= base.count, "越界, 检查设置的范围")
        }
        var subStr: String = ""
        for idx in location..<(location+length) {
            subStr += base[base.index(base.startIndex, offsetBy: idx)].description
        }
        return subStr
    }
    
    /// 替换字符串(正则表达式)
    /// - Parameters:
    ///   - aString: 替换的字符串
    ///   - pattern: 正则表达式
    /// - Returns: 新的替换完成的字符串
    public func replace(with aString: String, pattern: String) -> String {
        do {
            let regex = try NSRegularExpression(
                pattern: pattern,
                options: .caseInsensitive
            )
            let result = regex.stringByReplacingMatches(
                in: base,
                options: NSRegularExpression.MatchingOptions(rawValue: 0),
                range: NSMakeRange(0, base.kc.length),
                withTemplate: aString
            )
            return result
        } catch {
            print(error)
        }
        return ""
    }
    
    /// 替换字符串
    /// - Parameters:
    ///   - aString: 原待替换字符串
    ///   - newString: 替换的字符串
    /// - Returns: 替换完成的字符串
    public func replace(of aString: String, with newString: String) -> String {
        return base.replacingOccurrences(of: aString, with: newString)
    }
    
    /// 替换指定范围的某些字符串 索引从 0 开始
    /// - Parameters:
    ///   - aString: 替换的字符串
    ///   - rang: 闭区间
    /// - Returns: 新的替换完成的字符串
    public func replace(
        with aString: String,
        _ range: CountableClosedRange<Int>
    ) -> String {
        let start = base.index(base.startIndex, offsetBy: max(0, range.lowerBound))
        let end   = base.index(
            base.startIndex,
            offsetBy: min(base.count, range.upperBound)
        )
        return base.replacingCharacters(in: start...end, with: aString)
    }
    
    /// 去除小数点尾部的 0
    /// - Returns: 字符串
    public func trimTailZero() -> String { base.kc.toDouble.kc.toString }
    
    /// 去除指定的字符串
    /// - Parameter aString: 指定的字符串
    /// - Returns: 字符串
    public func trimString(_ aString: String) -> String {
        return base.trimmingCharacters(in: CharacterSet(charactersIn: aString))
    }
    
    /// 去除换行符 默认去除所有换行符
    /// - Parameter isAll: 是否去除所有换行符 默认 true 否则去除其前后换行
    /// - Returns: 字符串
    public func trimLines(_ isAll: Bool = true) -> String {
        if isAll {
            return base.replacingOccurrences(of: "\n", with: "", options: .literal, range: nil)
        }else {
            return base.trimmingCharacters(in: .newlines)
        }
    }
    
    /// 去除空格符 默认去除所有空格符
    /// - Parameter isAll: 是否去除所有空格符 默认 true 否则去除其前后空格符
    /// - Returns: 字符串
    public func trimSpace(_ isAll: Bool = true) -> String {
        if isAll {
            return base.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        }else {
            return base.trimmingCharacters(in: .whitespaces)
        }
    }
    
    /// 去除空格和换行 默认去除所有空格和换行
    /// - Parameter isAll: 是否去除所有空格换行 默认 true 否则去除其前后空格换行
    /// - Returns: 字符串
    public func trim(_ isAll: Bool = true) -> String {
        return base.kc.trimLines(isAll).kc.trimSpace(isAll)
    }
    
    /// 去除指定格式的字符
    /// - Parameter character: 指定格式
    /// .controlCharacters(控制符) | .whitespaces(空格符) | .newlines(换行符) | .whitespacesAndNewlines(空格换行)
    /// .letters(所有英文字母 包含大小写 65-90 97-122) | .decimalDigits(数字 0-9) | .alphanumerics(字母&数字 包含大小写)
    /// .lowercaseLetters(小写英文字母 97-122) | .uppercaseLetters(大写英文字母 65-90) | .capitalizedLetters(首字母大写)
    /// .symbols(所有内容 运算符等) | .punctuationCharacters(标点、连接线、引号) | .decomposables(可分解)
    /// .nonBaseCharacters(非基础字符) | .illegalCharacters(非法 不合规字符) | .bitmapRepresentation(二进制)
    /// .urlQueryAllowed 编码字符 #%<>[\]^`{|}
    /// .urlHostAllowed 编码字符 #%/<>?@\^`{|}
    /// .urlUserAllowed 编码字符 #%/:<>?@[\]^`
    /// .urlPathAllowed 编码字符 #%;<>?[\]^`{|}
    /// .urlPasswordAllowed 编码字符 #%/:<>?@[\]^`{|}
    /// .urlFragmentAllowed 编码字符  #%<>[\]^`{|}
    /// .inverted 相反的字符集
    /// - Returns: 字符串
    public func trim(in character: CharacterSet) -> String {
        return base.trimmingCharacters(in: character)
    }
}

//MARK: - 日期|字符串转换
extension KcPrefixWrapper where Base == String {
    
    /// 时间戳 默认长度 10 位
    /// - Parameter isSecond: 是否秒级 10 位长度 毫秒级 13 位长度
    /// - Returns: 时间戳字符串
    public static func timestamp(_ isSecond: Bool = true) -> String {
        let interval = Date(timeIntervalSinceNow: 0).timeIntervalSince1970
        if isSecond {
            return "\(Int(interval))"
        }else {
            let second = CLongLong(round(interval*1000))
            return "\(second)"
        }
    }
    
    /// 时间戳转为 Date
    /// - Returns: Date
    public func timestampToDate() -> Date {
        guard base.count == 10 ||  base.count == 13 else {
            #if DEBUG
            fatalError("时间戳长度错误")
            #else
            return Date()
            #endif
        }
        let value = base.count == 10 ? base.kc.toDouble : base.kc.toDouble / 1000
        return Date(timeIntervalSince1970: value)
    }
    
    /// 时间戳转为字符串 默认格式 yyyy-MM-dd HH:mm:ss
    /// - Parameter format: 格式
    /// - Returns: 字符串
    public func timestampToString(_ format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let date = base.kc.timestampToDate()
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh-CN")
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    /// 时间戳转消息时间条
    /// - Returns: 字符串
    public func timestampToMessageBar() -> String {
        let date = Date(timeIntervalSince1970: base.kc.toDouble)
        let calendar = Calendar.current
        let components = calendar.dateComponents(
            [.day],
            from: Date(),
            to: date
        )
        if let d = components.day, d == 0 {
            return Base.kc.dateToString(date).kc.stringToNewstring(
                original: "yyyy-MM-dd HH:mm:ss",
                newFormat: "HH:mm"
            )
        }else if let d = components.day, d == 1 {
            return "昨天"
        }else {
            return Base.kc.dateToString(date).kc.stringToNewstring(
                original: "yyyy-MM-dd HH:mm:ss",
                newFormat: "yyyy-MM-dd HH:mm"
            )
        }
    }
    
    /// 时间戳转评论时间条
    /// - Returns: 字符串
    public func timestampToCommentBar() -> String {
        let date = Date(timeIntervalSince1970: base.kc.toDouble)
        let calendar = Calendar.current
        let components = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: date,
            to: Date()
        )
        let year = components.year, month = components.month, day = components.day;
        let hour = components.hour, minute = components.minute, second = components.second;
        
        if let y = year, y >= 1 {
            return "\(y)" + "年前"
        }else if let m = month, m >= 1 {
            return "\(m)" + "月前"
        }else if let d = day, d >= 1 {
            return "\(d)" + "天前"
        }else if let h = hour, h >= 1 {
            return "\(h)" + "小时前"
        }else if let minu = minute, minu >= 1 {
            return "\(minu)" + "分钟前"
        }else if let sec = second, sec >= 1 {
            return "\(sec)" + "秒前"
        }else {
            return "刚刚"
        }
    }
    
    /// 时间条转秒数  其中时间条格式(00:00:00)
    /// - Returns: 秒数
    public func timebarToSeconds() -> String {
        if base.isEmpty { return "0" }
        var seconds: Int = 0
        let arrs = base.kc.replace(of: "：", with: ":").kc.split(":")
        if arrs.count > 0, let hour = arrs[safe: 0] , hour.kc.isValidInt {
            if let h = Int(hour), h > 0 {
                seconds += h * 60 * 60
            }
        }
        if arrs.count > 1, let minute = arrs[safe: 1], minute.kc.isValidInt {
            if let m = Int(minute), m > 0 {
                seconds += m * 60
            }
        }
        if arrs.count > 2, let second = arrs[safe: 2], second.kc.isValidInt {
            if let s = Int(second), s > 0 {
                seconds += s
            }
        }
        return "\(seconds)"
    }
    
    /// 秒数转为时间条 其中时间条格式(00:00:00)
    /// - Parameter type: 转换类型
    /// - Returns: 时间条
    public func secondsToTimebar(_ type: String.TimebarStyle = .normal) -> String {
        let seconds = base.kc.toInteger
        if seconds <= 0{
            return "00：00"
        }
        let second = seconds % 60
        if type == .second {
            return String(format: "%02d", seconds)
        }
        var minute = Int(seconds / 60)
        if type == .minute {
            return String(format: "%02d:%02d", minute, second)
        }
        var hour = 0
        if minute >= 60 {
            hour = Int(minute / 60)
            minute = minute - hour * 60
        }
        if type == .hour {
            return String(format: "%02d:%02d:%02d", hour, minute, second)
        }
        if hour > 0 {
            return String(format: "%02d:%02d:%02d", hour, minute, second)
        }
        if minute > 0 {
            return String(format: "%02d:%02d", minute, second)
        }
        return String(format: "%02d", second)
    }
    
    /// Date 转为时间戳 默认秒级 10 位长度
    /// - Parameters:
    ///   - date: 时间
    ///   - isSecond: 是否秒级 10 位长度 毫秒级 13 位长度
    /// - Returns: 时间戳字符串
    public static func dateToTimestamp(_ date: Date, isSecond: Bool = true) -> String {
        if isSecond {
            return "\(Int(date.timeIntervalSince1970))"
        }
        return "\(Int((date.timeIntervalSince1970) * 1000))"
    }
    
    /// Date 转为时间字符串 默认格式 yyyy-MM-dd HH:mm:ss
    /// - Parameters:
    ///   - date: 日期
    ///   - format: 转换格式
    /// - Returns: 转换后的字符串
    public static func dateToString(
        _ date: Date,
        format: String = "yyyy-MM-dd HH:mm:ss"
    ) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh-CN")
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    /// 字符串转为 Date 默认格式 yyyy-MM-dd HH:mm:ss
    /// - Parameter format: 转换格式
    /// - Returns: 字符串
    public func stringToDate(_ format: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = format
        guard let date = formatter.date(from: base) else {
            #if DEBUG
            fatalError("时间转换错误")
            #else
            return Date()
            #endif
        }
        return date
    }

    /// 时间字符串转时间戳 默认格式 yyyy-MM-dd HH:mm:ss
    /// - Parameters:
    ///   - format: 转换格式
    ///   - isSecond: 是否秒级 10 位长度 毫秒级 13 位长度
    /// - Returns: 时间戳字符串
    public func stringToTimestamp(
        _ format: String = "yyyy-MM-dd HH:mm:ss",
        isSecond: Bool = true
    ) -> String {
        let date = stringToDate(format)
        if isSecond {
            return "\(Int(date.timeIntervalSince1970))"
        }
        return "\(Int((date.timeIntervalSince1970) * 1000))"
    }
    
    /// 原时间字符串转新时间字符串
    /// - Parameters:
    ///   - originFormat: 原时间格式
    ///   - newFormat: 新时间格式
    /// - Returns: 新的时间字符串
    public func stringToNewstring(original format: String, newFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN") // 英文 "en_CN"
        formatter.dateFormat = format
        guard let date = formatter.date(from: base) else {
            #if DEBUG
            fatalError("时间转换错误")
            #else
            return ""
            #endif
        }
        formatter.dateFormat = newFormat
        return formatter.string(from: date)
    }
}

//MARK: - 字符校验
extension KcPrefixWrapper where Base == String {
    
    /// 是否存在数字
    public var isExistDigit: Bool {
        for value in base {
            if ("0" <= value  && value <= "9") {
                return true
            }
        }
        return false
    }
    
    /// 是否存在字母
    public var isExistLetter: Bool {
        for value in base {
            if ("a" <= value  && value <= "z") || ("A" <= value  && value <= "Z") {
                return true
            }
        }
        return false
    }
    
    /// 是否存在中文
    public var isExistChinese: Bool {
        for value in base {
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        return false
    }
    
    /// 是否存在表情
    public var isExistEmoji: Bool {
        for scalar in base.unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F,
                 0x1F300...0x1F5FF,
                 0x1F680...0x1F6FF,
                 0x2600...0x26FF,
                 0x2700...0x27BF,
                 0xFE00...0xFE0F:
                return true
            default:
                continue
            }
        }
        return false
    }
    
    /// 是否存在特殊字符
    public var isExistSpeciaChar: Bool {
        return base.kc.predicate(format: ".*[`~!@#$^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？].*")
    }
    
    /// 是否整型
    public var isValidInt: Bool {
        return base.kc.predicate(format: "^\\-?([0-9]+)$")
    }
    
    /// 是否浮点型
    public var isValidFloat: Bool {
        return base.kc.predicate(format: "^\\-?([0-9]+)(\\.\\d*)$")
    }
    
    /// 是否纯英文
    public var isValidPureLetter: Bool {
        return base.kc.predicate(format: "^[A-Za-z]+$")
    }
    
    /// 是否纯中文
    public var isValidPureChinese: Bool {
        return base.kc.predicate(format: "^[\u{4e00}-\u{9fa5}]+$")
    }
    
    /// 验证手机号有效性
    public var isValidPhone: Bool {
        return base.kc.predicate(format: "^((1[3-9][0-9]))\\d{8}$")
    }
    
    /// 验证验证码有效性  仅考虑长度(6 位)
    public var isValidVerifyCode: Bool {
        return base.kc.predicate(format: "^\\d{6}$")
    }
    
    /// 验证密码有效性 密码含除换行符外任意字符 长度 6...20
    public var isValidLoginPassword: Bool {
        return base.kc.predicate(format: "^.{6,20}$")
    }
    
    /// 验证支付密码有效性 仅考虑长度(6 位)
    public var isValidPaypassword: Bool {
        return base.kc.predicate(format: "^\\d{6}$")
    }
    
    /// 验证支付密码有效性 考虑长度、数字不连续、数字不重叠
    public var isValidNonSerialPaypassword: Bool {
        let start  = "^"
        let serial = "0{6}|1{6}|2{6}|3{6}|4{6}|5{6}|6{6}|7{6}|8{6}|9{6}|"
        let fold   = "(012345)|(123456)|(234567)|(345678)|(456789)|(987654)|(876543)|(765432)|(654321)|(543210)"
        let end    = "$"
        return !base.kc.predicate(format: start+serial+fold+end)
    }
    
    /// 验证用户名的有效性 考虑字母、汉字
    public var isValidUserName: Bool {
        return base.kc.predicate(format: "^[a-zA-Z\\u4E00-\\u9FA5]{1,20}$")
    }
    
    /// 验证昵称的有效性 考虑字母、汉字、数字
    public var isValidNickName: Bool {
        return base.kc.predicate(format: "^[a-zA-Z\\u4E00-\\u9FA50-9]{1,20}$")
    }
    
    /// 验证是否两位小数
    public var isValid2Decimal: Bool {
        return base.kc.predicate(format: "^\\-?([1-9]\\d*|0)(\\.\\d{2})$")
    }
    
    /// 验证银行卡有效性  仅考虑长度 16 | 19
    public var isValidBankCard: Bool {
        return base.kc.predicate(format: "^(\\d{16}|\\d{19})$")
    }
    
    /// 本地验证银行卡有效性
    public var isValidBankCardLocal: Bool {
        guard base.count >= 16 && base.count <= 19 else { return false }
        var allSum = 0, evenSum = 0, oddSum = 0;
        let bankNo = base.kc.substring(to: base.count-1)
        for idx in stride(from: base.count-1, through: 1, by: -1) {
            var tmpValue = bankNo.kc.substring(at: idx-1, length: 1).kc.toInteger
            switch base.count % 2 {
            case 1:
                if idx % 2 == 0 {
                    tmpValue *= 2
                    if tmpValue >= 10 {
                        tmpValue -= 9
                    }
                    evenSum += tmpValue
                }else {
                    oddSum += tmpValue
                }
            default:
                if idx % 2 == 1 {
                    tmpValue *= 2
                    if tmpValue >= 10 {
                        tmpValue -= 9
                    }
                    evenSum += tmpValue
                }else {
                    oddSum += tmpValue
                }
            }
        }
        allSum = evenSum + oddSum
        allSum += base.kc.substring(form: base.count-1).kc.toInteger

        return allSum % 10 == 0
    }
    
    /// 验证身份证有效性
    public var isValidIdCard: Bool {
        return base.kc.predicate(format: "^[0-9]{17}([0-9]|X)$")
    }
    
    /// 本地验证身份证有效性
    public var isValidIdCardLocal: Bool {
        guard base.count == 18 else { return false }
        let idcardNo = base.trimmingCharacters(in: .whitespacesAndNewlines)
        // 区分是否为闰年
        let tdStr = "(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))"
        let leap_td = "0229", year = "(19|20)[0-9]{2}", leap_y = "(19|20)(0[48]|[2468][048]|[13579][26])";
        let ytd = year + tdStr, leapYtd = leap_y + leap_td;
        let regularYtd = String(format: "((%@)|(%@)|(%@))", ytd, leapYtd, "20000229")
        
        let area = "(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}"
        let regular = String(format: "%@%@%@", area, regularYtd, "[0-9]{3}[0-9Xx]")
        let predicate = NSPredicate(format:"SELF MATCHES %@", regular)
        
        guard predicate.evaluate(with: idcardNo) == true else {
            return false
        }
        let t1 = (idcardNo.kc.substring(at: 0, length: 1).kc.toInt+idcardNo.kc.substring(at: 10, length: 1).kc.toInt)*7
        let t2 = (idcardNo.kc.substring(at: 1, length: 1).kc.toInt+idcardNo.kc.substring(at: 11, length: 1).kc.toInt)*9
        let d1 = (idcardNo.kc.substring(at: 2, length: 1).kc.toInt+idcardNo.kc.substring(at: 12, length: 1).kc.toInt)*10
        let d2 = (idcardNo.kc.substring(at: 3, length: 1).kc.toInt+idcardNo.kc.substring(at: 13, length: 1).kc.toInt)*5
        let o1 = (idcardNo.kc.substring(at: 4, length: 1).kc.toInt+idcardNo.kc.substring(at: 14, length: 1).kc.toInt)*8
        let o2 = (idcardNo.kc.substring(at: 5, length: 1).kc.toInt+idcardNo.kc.substring(at: 15, length: 1).kc.toInt)*4
        let s1 = (idcardNo.kc.substring(at: 6, length: 1).kc.toInt+idcardNo.kc.substring(at: 16, length: 1).kc.toInt)*2
        
        let y1 = idcardNo.kc.substring(at: 7, length: 1).kc.toInt+idcardNo.kc.substring(at: 8, length: 1).kc.toInt*6
        let y2 = idcardNo.kc.substring(at: 9, length: 1).kc.toInt*3
        
        let lastCard = idcardNo.kc.substring(at: 17, length: 1)
        let checkBit = "10X98765432".kc.substring(
            at: Int((t1+t2+d1+d2+o1+o2+s1+y1+y2) % 11),
            length: 1
        )
        return checkBit == lastCard.uppercased()
    }
    
    /// 验证邮箱有效性
    public var isValidEmail: Bool {
        return base.kc.predicate(format: "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$")
    }
    
    /// 验证 URL 有效性
    public var isValidURL: Bool {
        return base.kc.predicate(format:
            "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
        )
    }
    
    /// 验证HTML有效性
    public var isValidHTML: Bool {
        return base.kc.predicate(format: "^<([a-z]+)([^<]+)*(?:>(.*)<\\/\\1>|\\s+\\/>)$")
    }
    
    /// 验证车牌有效性
    public var isValidCarNum: Bool {
        return base.kc.predicate(format: "^[A-Za-z]{1}[A-Za-z_0-9]{5}$")
    }
    
    /// 验证邮政编码有效性
    public var isValidPostalcode: Bool {
        return base.kc.predicate(format: "^[0-8]\\d{5}(?!\\d)$")
    }
    
    /// 验证 Mac 地址有效性
    public var isValidMacAddress: Bool {
        return base.kc.predicate(format: "([A-Fa-f0-9]{2}\\:){5}[A-Fa-f0-9]")
    }
    
    /// 验证 IP 有效性
    public var isValidIPAddress: Bool {
        return base.kc.predicate(format: "([1-9]{1,3}\\.){3}[1-9]")
    }
    
    private func predicate(format predicate: String) -> Bool {
        return NSPredicate(format:"SELF MATCHES %@", predicate).evaluate(with: base)
    }
}

