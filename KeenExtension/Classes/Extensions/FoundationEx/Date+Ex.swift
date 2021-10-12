//
//  Date+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/7/8.
//

import Foundation

extension DateFormatter {
    
    /// 初始化
    public convenience init(format: String) {
        self.init()
        dateFormat = format
    }
}

//MARK: - 基础功能
extension Date: KcPrefixWrapperCompatibleValue {}

extension KcPrefixWrapper where Base == Date {
    
    /// 对应的年份(∞)
    public var dateYear: Int {
        return Calendar.current.component(.year, from: base)
    }
    
    /// 对应的月份(1 - 12)
    public var dateMonth: Int {
        return Calendar.current.component(.month, from: base)
    }
    
    /// 对应月份的几号(1 - 31)
    public var dateDay: Int {
        return Calendar.current.component(.day, from: base)
    }
    
    /// 对应的小时数(0 - 24)
    public var dateHour: Int {
        return Calendar.current.component(.hour, from: base)
    }
    
    /// 对应的分钟数(0 - 60)
    public var dateMinute: Int {
        return Calendar.current.component(.minute, from: base)
    }
    
    /// 对应的秒数(0 - 60)
    public var dateSecond: Int {
        return Calendar.current.component(.second, from: base)
    }
    
    /// 对应的毫秒数(9 位数字)
    public var dateNanosecond: Int {
        return Calendar.current.component(.nanosecond, from: base)
    }
    
    /// 对应的刻钟(1 - 4)  其中 1 刻钟为 15 分钟
    public var dateQuarter: Int {
        return Calendar.current.component(.quarter, from: base)
    }
    
    /// 对应月份的第一天是周几(0 - 6) 0 周日 1 周一 ...
    public var dateFirstWeekDay: Int {
        /// 默认 1 代表周日 即一周第一天序号为 1 日历中约定为 0
        return Calendar.current.ordinality(
            of: .weekday,
            in: .weekOfMonth,
            for: base.kc.currentMonthDate()
        )! - 1
    }
    
    /// 对应日期的周几(0 - 6)  0 周日 1 周一 ...
    public var dateWeekday: Int {
        /// 默认 1 代表周日 即一周第一天序号为 1 日历中约定为 0
        return Calendar.current.component(.weekday, from: base) - 1
    }
    
    /// 对应月份内的第几周(1 - 5) 与日历排列无关  -- 以 7 天为一周, 其中 1-7 号为第一周 以此类推
    public var dateWeek: Int {
        return Calendar.current.component(.weekdayOrdinal, from: base)
    }
    
    /// 对应月份内的第几周(1 - 6) 与日历排列有关
    public var weekOfMonth: Int {
        return Calendar.current.component(.weekOfMonth, from: base)
    }
    
    /// 对应年份内的第几周(1 - 53)
    public var weekOfYear: Int {
        return Calendar.current.component(.weekOfYear, from: base)
    }
    
    /// 对应月份的总天数(28 - 31)
    public var dateTotalDays: Int {
        return Calendar.current.range(of: .day, in: .month, for: base)!.count
    }
    
    /// 对应的年份(数字)
    public var dateYearString: String {
        return DateFormatter(format: "yyyy").string(from: base)
    }
    
    /// 对应的月份(英文)
    public var dateMonthString: String {
        return DateFormatter(format: "MMMM").string(from: base)
    }
    
    /// 对应的天数(数字)
    public var dateDayString: String {
        return DateFormatter(format: "dd").string(from: base)
    }
    
    /// 对应的周数(英文)
    public var dateWeekString: String {
        return DateFormatter(format: "EEEE").string(from: base)
    }
    
    /// 前天
    public var dateBeforeYesterDay: Date? { addDate(day: -2) }
    /// 昨天
    public var dateYesterDay: Date? { addDate(day: -1) }
    /// 明天
    public var dateTomorrow: Date? { addDate(day: 1) }
    /// 后天
    public var dateAfterTomorrow: Date? { addDate(day: 2) }
    
    /// 是否今天
    public var isToday: Bool {
        let date = Date()
        if Date.kc.dateToString(Date(), format: "yyyyMMdd") == Date.kc.dateToString(date, format: "yyyyMMdd") {
            return true
        }
        return false
    }
    
    /// 是否前天
    public var isTheDayBeforeYesterday: Bool  {
        guard let date = Date().kc.dateBeforeYesterDay else {
            return false
        }
        return isSameYMD(date, Date())
    }
    
    /// 是否昨天
    public var isYesterday: Bool {
        guard let date = Date().kc.dateYesterDay else {
            return false
        }
        return isSameYMD(date, Date())
    }
    
    /// 是否明天
    public var isTomorrow: Bool {
        guard let date = Date().kc.dateTomorrow else {
            return false
        }
        return isSameYMD(date, Date())
    }
    
    /// 是否后天
    public var isAfterTomorrow: Bool  {
        guard let date = Date().kc.dateAfterTomorrow else {
            return false
        }
        return isSameYMD(date, Date())
    }
    
    /// 是否今年
    public var isThisYear: Bool  {
        let calendar = Calendar.current
        let lhsYear = calendar.dateComponents([.year], from: base)
        let rhsYear = calendar.dateComponents([.year], from: Date())
        return lhsYear.year == rhsYear.year
    }
    
    /// 是否同周
    public var isThisWeek: Bool {
        let calendar = Calendar.current
        let lhsWeek = calendar.dateComponents([.weekOfYear], from: base)
        let rhsWeek = calendar.dateComponents([.weekOfYear], from: Date())
        return lhsWeek == rhsWeek
    }
}

//MARK: - 常见功能
extension KcPrefixWrapper where Base == Date {
    
    /// 获取年月 默认格式 yyyy年M月
    /// - Parameter format: 格式化符号
    /// - Returns: 字符串
    public func dateYM(format: String = "yyyy年M月") -> String {
        return Date.kc.stringToNewstring(
            "\(dateYear).\(dateMonth)",
            originFormat: "yyyy.M",
            newFormat: format
        )
    }
    
    /// 获取年月日 默认格式 yyyy年M月d日
    /// - Parameter format: 格式化符号
    /// - Returns: 字符串
    public func dateYMD(format: String = "yyyy年M月d日") -> String {
        return Date.kc.stringToNewstring(
            "\(dateYear).\(dateMonth).\(dateDay)",
            originFormat: "yyyy.M.d",
            newFormat: format
        )
    }
    
    /// 当月日期 默认月初日期
    /// - Parameter isEnd: 是否月末日期
    /// - Returns: 日期
    public func currentMonthDate(_ isEnd: Bool = false) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: base)
        components.day = isEnd ? dateTotalDays : 1
        return calendar.date(from: components)!
    }
    
    /// 上月日期 默认月初日期
    /// - Parameter isEnd: 是否月末日期
    /// - Returns: 日期
    public func previousMonthDate(_ isEnd: Bool) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: base)
        if components.month! == 1 {
            components.month! = 12
            components.year! = components.year! - 1
        }else {
            components.month! = components.month! - 1
        }
        components.day = isEnd ? dateTotalDays : 1
        return calendar.date(from: components)!
    }
    
    /// 下月日期 默认月初日期
    /// - Parameter isEnd: 是否月末日期
    /// - Returns: 日期
    public func nextMonthDate(_ isEnd: Bool) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: base)
        if components.month! == 12 {
            components.month! = 1
            components.year! = components.year! + 1
        }else {
            components.month! = components.month! + 1
        }
        components.day = isEnd ? dateTotalDays : 1
        return calendar.date(from: components)!
    }
    
    /// 日期是否相同(同年同月同日)
    /// - Parameters:
    ///   - lhs: 比较的日期
    ///   - rhs: 比较的日期
    /// - Returns: Bool 值
    public func isSameYMD(_ lhs: Date, _ rhs: Date) -> Bool {
        let oneDate = Calendar.current.dateComponents(
            [.year, .month, .day],
            from: lhs
        )
        let twoDate = Calendar.current.dateComponents(
            [.year, .month, .day],
            from: rhs
        )
        return (oneDate.day == twoDate.day &&
                oneDate.month == twoDate.month &&
                oneDate.year == twoDate.year)
    }
    
    /// 对应的月份第一天
    /// - Returns: 第一天的日期
    public func dateFirstDay() -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: base)
        components.day = 1
        let date = calendar.date(from: components)
        let seconds = TimeZone.current.secondsFromGMT(for: date!)
        return date!.addingTimeInterval(Double(seconds))
    }
    
    /// 对应的月份最后一天
    /// - Parameter flag: 标识 false 显示00:00:00  true 显示 23:59:59
    /// - Returns: 最后一天的日期
    public func dateEndDay(_ flag: Bool = false) -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = 1
        flag ? (components.second = -1) : (components.day = -1)
        return calendar.date(byAdding: components, to: dateFirstDay())!
    }
    
    /// 距离当前 N 天的日期
    /// - Parameter day: 正数(N 天后的日期) 负数(N 天前的日期)
    /// - Returns: 日期 Date
    public func addDate(day: Int) -> Date? {
        return Calendar.current.date(byAdding: DateComponents(day:day), to: Date())
    }
    
    /// 每周对应的开始&结束时间 默认周一作为一周开始
    /// - Parameters:
    ///   - num: 周数序号(0 第一周 1 第二周 2 第三周 3 第四周 4 第五周)
    ///   - firstWeekday: 每周第一天从周几开始  0(周日) 1(周一) 以此类推
    ///   - format: 日期格式 默认 'M.d' 即去掉十分位的 0
    /// - Returns: 每周开始&结束时间集合
    public func weeksNumber(_ num: Int, firstWeekday: Int = 1, format: String = "M.d") -> [String] {
        let day = 24 * 60 * 60
        var calendar = Calendar.current
        calendar.minimumDaysInFirstWeek = 1
        calendar.firstWeekday = firstWeekday + 1 // 默认从 1 开始
        let date = base.addingTimeInterval(Double(7 * day * num))
        let components = calendar.dateComponents([.weekday, .day], from: date)
        let startWeek = date.addingTimeInterval(Double(-(components.weekday! - calendar.firstWeekday) * day))
        let endWeek = date.addingTimeInterval(Double((6 - (components.weekday! - calendar.firstWeekday)) * day))
        let startComponents = calendar.dateComponents([.year, .month, .day], from: startWeek)
        let endComponents = calendar.dateComponents([.year, .month, .day], from: endWeek)
        
        let startDate = Date.kc.dateToString(
            calendar.date(from: startComponents)!,
            format: format
        )
        let endDate = Date.kc.dateToString(
            calendar.date(from: endComponents)!,
            format: format
        )
        
        return [startDate, endDate]
    }
    
    /// 每周对应的具体时间集合 默认周一作为一周开始
    /// - Parameters:
    ///   - num: 周数序号(0 第一周 1 第二周 2 第三周 3 第四周 4 第五周)
    ///   - firstWeekday: 每周第一天从周几开始  0(周日) 1(周一) 以此类推
    ///   - format: 日期格式 默认 'M.d' 即去掉十分位的 0
    /// - Returns: 每周具体的时间集合
    public func weeksDetailNumber(_ num: Int, firstWeekday: Int = 1, format: String = "M.d") -> [String] {
        let day = 24 * 60 * 60
        var calendar = Calendar.current
        calendar.minimumDaysInFirstWeek = 1
        calendar.firstWeekday = firstWeekday + 1 // 默认从 1 开始
        let date = base.addingTimeInterval(Double(7 * day * num))
        let components = calendar.dateComponents([.year, .month, .day, .weekday], from: date)
        let startDay: Int = calendar.firstWeekday - components.weekday!
        let endDay: Int = 6 - (components.weekday! - calendar.firstWeekday)
        
        var items = [String]()
        for idx in startDay...endDay {
            let seconds = idx * day
            let newDate = date.addingTimeInterval(Double(seconds))
            items.append(Date.kc.dateToString(newDate, format: format))
        }
        
        return items
    }
}

//MARK: - 日期|字符串转换
extension KcPrefixWrapper where Base == Date {
    
    /// 时间戳 默认长度 10 位
    /// - Parameter isSecond: 是否秒级 10 位长度 毫秒级 13 位长度
    /// - Returns: 时间戳字符串
    public static func timestamp(_ isSecond: Bool = true) -> String {
        let interval: TimeInterval = Date.init(timeIntervalSinceNow: 0).timeIntervalSince1970
        if isSecond {
            return "\(Int(interval))"
        }else {
            let second = CLongLong(round(interval*1000))
            return "\(second)"
        }
    }
    
    /// 时间戳转 Date
    /// - Parameter timestamp: 时间戳
    /// - Returns: Date
    public static func timestampToDate(_ timestamp: String) -> Date {
        guard timestamp.count == 10 ||  timestamp.count == 13 else {
            #if DEBUG
            fatalError("时间戳长度错误")
            #else
            return Date()
            #endif
        }
        let value = timestamp.count == 10 ? timestamp.kc.toDouble : timestamp.kc.toDouble / 1000
        return Date(timeIntervalSince1970: value)
    }
    
    /// 时间戳转字符串 默认格式 yyyy-MM-dd HH:mm:ss
    /// - Parameters:
    ///   - timestamp: 时间戳
    ///   - format: 格式
    /// - Returns: 对应格式的字符串
    public static func timestampToString(
        _ timestamp: String,
        format: String = "yyyy-MM-dd HH:mm:ss"
    ) -> String {
        let date = timestampToDate(timestamp)
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh-CN")
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    /// Date 转评论时间条
    /// - Parameter date: 对应的时间
    /// - Returns: 时间字符串
    public static func dateToCommentBar(_ date: Date) -> String {
        var interval = Date().timeIntervalSince(date)
        if interval < 0 {
            return "刚刚"
        }
        interval = fabs(interval)
        let minute = interval/60
        let second = interval/(60*60)
        let day = interval/(60*60*24)
        let month = interval/(60*60*24*30)
        let year = interval/(60*60*24*30*12)
        
        var time:String!
        if second < 1 {
            let m = NSNumber(value: minute as Double).intValue
            if m == 0 {
                time = "刚刚"
            } else {
                time = "\(m)分钟前"
            }
        }else if day < 1 {
            let h = NSNumber(value: second as Double).intValue
            time = "\(h)小时前"
        }else if month < 1 {
            let d = NSNumber(value: day as Double).intValue
            time = "\(d)天前"
        }else if year < 1 {
            let m = NSNumber(value: month as Double).intValue
            time = "\(m)个月前"
        }else {
            let y = NSNumber(value: year as Double).intValue
            time = "\(y)年前"
        }
        return time
    }
    
    /// Date 转时间戳 默认秒级 10 位长度
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
    
    /// Date 转时间字符串 默认格式 yyyy-MM-dd HH:mm:ss
    /// - Parameters:
    ///   - date: 日期
    ///   - format: 转换格式
    /// - Returns: 转换后的字符串
    public static func dateToString(_ date: Date, format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh-CN")
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    /// 时间字符串转 Date 默认格式 yyyy-MM-dd HH:mm:ss
    /// - Parameters:
    ///   - aString: 时间字符串
    ///   - format: 转换格式
    /// - Returns: 转换后的字符串
    public static func stringToDate(_ aString: String, format: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = format
        guard let date = formatter.date(from: aString) else {
            #if DEBUG
            fatalError("时间转换错误")
            #else
            return Date()
            #endif
        }
        return date
    }
    
    /// 时间字符串转时间戳
    /// - Parameters:
    ///   - aString: 时间字符串
    ///   - format: 转换格式
    ///   - isSecond: 是否秒级 10 位长度 毫秒级 13 位长度
    /// - Returns: 时间戳字符串
    public static func stringToTimestamp(_ aString: String, format: String, isSecond: Bool = true) -> String {
        let date = stringToDate(aString, format: format)
        if isSecond {
            return "\(Int(date.timeIntervalSince1970))"
        }
        return "\(Int((date.timeIntervalSince1970) * 1000))"
    }
    
    /// 原时间字符串转新时间字符串
    /// - Parameters:
    ///   - aString: 时间字符串
    ///   - originFormat: 原时间格式
    ///   - newFormat: 新时间格式
    /// - Returns: 新的时间字符串
    public static func stringToNewstring(_ aString: String, originFormat: String, newFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN") // 英文 "en_CN"
        formatter.dateFormat = originFormat
        guard let date = formatter.date(from: aString) else {
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
