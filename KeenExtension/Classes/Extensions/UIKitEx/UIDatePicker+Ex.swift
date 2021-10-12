//
//  UIDatePicker+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/8/30.
//

import UIKit

//MARK: - 链式属性函数
extension UIDatePicker {
    
    /// 显示模式 默认 dateAndTime
    /// - Parameter mode: 模式
    /// 1. date(x年 x月 x 日) | dateAndTime(x月x日 周 x 上午|下午 0-12 0-59)
    /// 2. time(上午|下午 0-12 0-59) | countDownTimer(0-23 hours 0-59 min)
    /// - Returns: 自身
    @discardableResult
    public func datePickerMode(_ mode: UIDatePicker.Mode = .dateAndTime) -> Self {
        datePickerMode = mode
        return self
    }
    
    /// 设置时间
    /// - Parameters:
    ///   - date: 时间
    /// - Returns: 自身
    @discardableResult
    public func date(_ date: Date) -> Self {
        self.date = date
        return self
    }
    
    /// 时间时区
    /// - Parameters:
    ///   - zone: 时区
    /// - Returns: 自身
    @discardableResult
    public func timeZone(_ zone: TimeZone? = nil) -> Self {
        timeZone = zone
        return self
    }
    
    /// 地区  默认 "zh_CN"
    /// - Parameters:
    ///   - local: 地区
    /// - Returns: 自身
    @discardableResult
    public func locale(_ identifier: String = "zh_CN") -> Self {
        locale = Locale(identifier: identifier)
        return self
    }
    
    /// 最小选择值
    /// - Parameters:
    ///   - min: 时间最小值
    /// - Returns: 自身
    @discardableResult
    public func minimumDate(_ min: Date?) -> Self {
        minimumDate = min
        return self
    }

    /// 最大选择值
    /// - Parameters:
    ///   - max: 时间最大值
    /// - Returns: 自身
    @discardableResult
    public func maximumDate(_ max: Date?) -> Self {
        maximumDate = max
        return self
    }
    
    /// 倒计时 默认 0.0
    /// - Parameters:
    ///   - duration: 倒计时
    /// - Returns: 自身
    @discardableResult
    public func countDownDuration(_ duration: TimeInterval = 0.0) -> Self {
        countDownDuration = duration
        return self
    }
    
    /// 分钟间隔 范围[1-30]  默认 1
    /// - Parameters:
    ///   - interval: 分钟间隔
    /// - Returns: 自身
    @discardableResult
    public func minuteInterval(_ interval: Int = 1) -> Self {
        minuteInterval = interval
        return self
    }
    
    /// 日期样式
    /// - Parameters:
    ///   - style: 日期模式
    /// - Returns: 自身
    @available(iOS 13.4, *)
    @discardableResult
    public func preferredDatePickerStyle(_ style: UIDatePickerStyle) -> Self {
        preferredDatePickerStyle = style
        return self
    }
}
