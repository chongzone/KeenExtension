//
//  UITableView+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/11/26.
//

import UIKit

//MARK: - 链式属性函数
extension UITableView {
    
    /// 代理
    /// - Parameter delegate: 代理
    /// - Returns: 自身
    @discardableResult
    public func delegate(_ delegate: UITableViewDelegate?) -> Self {
        self.delegate = delegate
        return self
    }
    
    /// 数据源
    /// - Parameter dataSource: 数据源
    /// - Returns: 自身
    @discardableResult
    public func dataSource(_ dataSource: UITableViewDataSource?) -> Self {
        self.dataSource = dataSource
        return self
    }
    
    /// 行高
    /// - Parameter height: 行高
    /// - Returns: 自身
    @discardableResult
    public func rowHeight(_ height: CGFloat) -> Self {
        rowHeight = height
        return self
    }
    
    /// 分区头部高度
    /// - Parameter height: 高度
    /// - Returns: 自身
    @discardableResult
    public func sectionHeaderHeight(_ height: CGFloat) -> Self {
        sectionHeaderHeight = height
        return self
    }
    
    /// 分区尾部高度
    /// - Parameter height: 高度
    /// - Returns: 自身
    @discardableResult
    public func sectionFooterHeight(_ height: CGFloat) -> Self {
        sectionFooterHeight = height
        return self
    }
    
    /// 单元格预估高度
    /// - Parameter height: 预估高度
    /// - Returns: 自身
    @discardableResult
    public func estimatedRowHeight(_ height: CGFloat) -> Self {
        estimatedRowHeight = height
        return self
    }
    
    /// 分区头部预估高度
    /// - Parameter height: 预估高度
    /// - Returns: 自身
    @discardableResult
    public func estimatedSectionHeaderHeight(_ height: CGFloat) -> Self {
        self.estimatedSectionHeaderHeight = height
        return self
    }
    
    /// 分区尾部预估高度
    /// - Parameter height: 预估高度
    /// - Returns: 自身
    @discardableResult
    public func estimatedSectionFooterHeight(_ height: CGFloat) -> Self {
        self.estimatedSectionFooterHeight = height
        return self
    }
    
    /// 列表头部 tableHeaderView
    /// - Parameter head: 头部 View
    /// - Returns: 自身
    @discardableResult
    public func headerView(_ head: UIView?) -> Self {
        tableHeaderView = head
        return self
    }
    
    /// 列表尾部 tableFooterView
    /// - Parameter foot: 尾部 View
    /// - Returns: 自身
    @discardableResult
    public func footerView(_ foot: UIView?) -> Self {
        tableFooterView = foot
        return self
    }
    
    /// 单元格的分割线样式  默认 .singleLine
    /// - Parameter style: 分割线样式
    /// - Returns: 自身
    @discardableResult
    public func separatorStyle(_ style: UITableViewCell.SeparatorStyle = .singleLine) -> Self {
        separatorStyle = style
        return self
    }
    
    /// 单元格的分割线颜色
    /// - Parameter color: 分割线颜色
    /// - Returns: 自身
    @discardableResult
    public func separatorColor(_  color: UIColor?) -> Self {
        separatorColor = color
        return self
    }
    
    /// 单元格的分割线边距 默认 .zero
    /// - Parameter inset: 分割线边距
    /// - Returns: 自身
    @discardableResult
    public func separatorInset(_  inset: UIEdgeInsets = .zero) -> Self {
        separatorInset = inset
        return self
    }
    
    /// 编辑状态 默认动画
    /// - Parameters:
    ///   - editing: 是否编辑状态
    ///   - animated: 是否动画
    /// - Returns: 自身
    @discardableResult
    public func edit(_ editing: Bool, animated: Bool = true) -> Self {
        setEditing(editing, animated: animated)
        return self
    }
    
    /// 非编辑状态下是否可选择 cell 默认 true
    /// - Parameter allow: 是否允许
    /// - Returns: 自身
    @discardableResult
    public func allowsSelection(_ allow: Bool = true) -> Self {
        allowsSelection = allow
        return self
    }
    
    /// 编辑状态下是否可选择 cell 默认 false
    /// - Parameter allow: 是否允许
    /// - Returns: 自身
    @discardableResult
    public func allowsSelectionDuringEditing(_ allow: Bool = false) -> Self {
        allowsSelectionDuringEditing = allow
        return self
    }
    
    /// 多个 cell 是否同时可被选择 默认 false
    /// - Parameter allow: 是否允许
    /// - Returns: 自身
    @discardableResult
    public func allowsMultipleSelection(_ allow: Bool = false) -> Self {
        allowsMultipleSelection = allow
        return self
    }
    
    /// 多个 cell 在编辑状态下是否同时可被选择 默认 false
    /// - Parameter allow: 是否允许
    /// - Returns: 自身
    @discardableResult
    public func allowsMultipleSelectionDuringEditing(_ allow: Bool = false) -> Self {
        allowsMultipleSelectionDuringEditing = allow
        return self
    }
    
    /// 单元格 cell 行数小于具体多少展示索引 默认 0
    /// - Parameter count: 数量值
    /// - Returns: 自身
    @discardableResult
    public func sectionIndexMinimumDisplayRowCount(_ count: Int = 0) -> Self {
        sectionIndexMinimumDisplayRowCount = count
        return self
    }
    
    /// 索引文字的颜色
    /// - Parameter color: 颜色
    /// - Returns: 自身
    @discardableResult
    public func sectionIndexColor(_ color: UIColor?) -> Self {
        sectionIndexColor = color
        return self
    }
    
    /// 索引区域的背景色
    /// - Parameter color: 颜色
    /// - Returns: 自身
    @discardableResult
    public func sectionIndexBackgroundColor(_ color: UIColor?) -> Self {
        sectionIndexBackgroundColor = color
        return self
    }
    
    /// 选择索引时的背景颜色
    /// - Parameter color: 颜色
    /// - Returns: 自身
    @discardableResult
    public func sectionIndexTrackingBackgroundColor(_ color: UIColor?) -> Self {
        sectionIndexTrackingBackgroundColor = color
        return self
    }
    
    /// 注册 cell
    /// - Parameter cellClass: cell 类
    /// - Parameter identifier: 复用标识符
    /// - Returns: 自身
    @discardableResult
    public func register(_ cellClass: AnyClass?, identifier: String) -> Self {
        register(cellClass, forCellReuseIdentifier: identifier)
        return self
    }
    
    /// 注册头部尾部
    /// - Parameter aClass: 视图类
    /// - Parameter identifier: 复用标识符
    /// - Returns: 自身
    @discardableResult
    public func registerHeaderFooter(_ aClass: AnyClass?, identifier: String) -> Self {
        register(aClass, forHeaderFooterViewReuseIdentifier: identifier)
        return self
    }
    
    /// 滚动到特定的分区分行
    /// - Parameters:
    ///   - indexPath: 第几个IndexPath
    ///   - scrollPosition: 滚动方式
    ///   - animated: 是否动画 默认 true
    /// - Returns: 自身
    @discardableResult
    public func scroll(
        to indexPath: IndexPath,
        at scrollPosition: UITableView.ScrollPosition = .none,
        animated: Bool = true
    ) -> Self {
        if indexPath.row < 0 ||
            indexPath.section < 0 ||
            indexPath.section > self.numberOfSections
            || indexPath.row > self.numberOfRows (inSection: indexPath.section) {
            return self
        }
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
        return self
    }
    
    /// 滚动到特定的分区分行
    /// - Parameters:
    ///   - row: 第几 row
    ///   - section: 第几 section
    ///   - scrollPosition: 滚动方式
    ///   - animated: 是否动画 默认 true
    /// - Returns: 自身
    @discardableResult
    public func scroll(
        row: Int,
        section: Int = 0,
        at scrollPosition: UITableView.ScrollPosition = .none,
        animated: Bool = true
    ) -> Self {
        return scroll(to: IndexPath(row: row, section: section), at: scrollPosition, animated: animated)
    }
    
    /// 滚动到最近选中的 cell
    /// - Parameters:
    ///   - scrollPosition: 滚动方式
    ///   - animated: 是否动画 默认 true
    /// - Returns: 自身
    @discardableResult
    public func scrollToNearestSelectedCell(
        at scrollPosition: UITableView.ScrollPosition = .none,
        animated: Bool = true
    ) -> Self {
        scrollToNearestSelectedRow(at: scrollPosition, animated: animated)
        return self
    }
}

//MARK: - 初始化
extension UITableView {
    
    /// 初始化 默认列表样式 plain
    /// - Parameters:
    ///   - origin: origin 点
    ///   - size: size 大小
    ///   - style: 列表样式
    public convenience init(origin: CGPoint, size: CGSize, style: UITableView.Style = .plain) {
        self.init(frame: CGRect(origin: origin, size: size), style: style)
    }
    
    /// 初始化 默认列表样式 plain
    /// - Parameters:
    ///   - x: x 坐标
    ///   - y: y 坐标
    ///   - width: 宽度大小
    ///   - height: 高度大小
    ///   - style: 列表样式
    public convenience init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, style: UITableView.Style = .plain) {
        self.init(frame: CGRect(x: x, y: y, width: width, height: height), style: style)
    }
    
    /// 初始化 默认列表样式 plain 内边距 0
    /// - Parameters:
    ///   - superView: 父视图
    ///   - style: 列表样式
    ///   - padding: 内边距
    public convenience init(superView: UIView, style: UITableView.Style = .plain, padding: CGFloat = 0) {
        self.init(frame: CGRect(
                    x: superView.kc.x + padding,
                    y: superView.kc.y + padding,
                    width: superView.kc.width - padding*2,
                    height: superView.kc.height - padding*2),
                  style: style
        )
    }
}

//MARK: - 基础功能 
extension KcPrefixWrapper where Base: UITableView {
    
    /// 列表适配
    public func automaticallyAdjusts(_ vc: UIViewController) {
        if #available(iOS 11, *) {
            base.estimatedSectionFooterHeight = 0
            base.estimatedSectionHeaderHeight = 0
            base.contentInsetAdjustmentBehavior = .never
        }else {
            vc.automaticallyAdjustsScrollViewInsets = false
        }
    }
}
