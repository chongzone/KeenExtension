//
//  UICollectionView+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/11/26.
//

import UIKit

//MARK: - 链式属性函数
extension UICollectionView {
    
    /// 代理
    /// - Parameter delegate: 代理
    /// - Returns: 自身
    @discardableResult
    public func delegate(_ delegate: UICollectionViewDelegate?) -> Self {
        self.delegate = delegate
        return self
    }
    
    /// 数据源
    /// - Parameter dataSource: 数据源
    /// - Returns: 自身
    @discardableResult
    public func dataSource(_ dataSource: UICollectionViewDataSource?) -> Self {
        self.dataSource = dataSource
        return self
    }
    
    /// 预加载数据源
    /// - Parameter dataSource: 预加载数据源
    /// - Returns: 自身
    @discardableResult
    @available(iOS 10.0, *)
    public func preDataSource(_ dataSource: UICollectionViewDataSourcePrefetching?) -> Self {
        prefetchDataSource = dataSource
        return self
    }
    
    /// 是否允许预加载
    /// - Parameter enable: 是否允许预加载
    /// - Returns: 自身
    @discardableResult
    @available(iOS 10.0, *)
    public func isPreEnable(_ enable: Bool) -> Self {
        isPrefetchingEnabled = enable
        return self
    }
    
    /// 编辑状态
    /// - Parameter editing: 编辑状态
    /// - Returns: 自身
    @discardableResult
    @available(iOS 14.0, *)
    public func isEditing(_ editing: Bool) -> Self {
        isEditing = editing
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
    @available(iOS 14.0, *)
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
    @available(iOS 14.0, *)
    public func allowsMultipleSelectionDuringEditing(_ allow: Bool = false) -> Self {
        allowsMultipleSelectionDuringEditing = allow
        return self
    }
    
    /// 设置布局
    /// - Parameter layout: 布局对象
    /// - Returns: 自身
    @discardableResult
    public func layout(_ layout: UICollectionViewLayout) -> Self {
        collectionViewLayout = layout
        return self
    }
    
    /// 设置布局 默认动画
    /// - Parameters:
    ///   - layout: 布局对象
    ///   - completion: 完成事件
    ///   - animated: 是否动画
    /// - Returns: 自身
    @discardableResult
    public func layout(_ layout: UICollectionViewLayout, _ completion: ((Bool) -> Void)? = nil, animated: Bool = true) -> Self {
        setCollectionViewLayout(layout, animated: animated, completion: completion)
        return self
    }
    
    /// 注册 cell
    /// - Parameter cellClass: cell 类
    /// - Parameter identifier: 复用标识符
    /// - Returns: 自身
    @discardableResult
    public func register(_ cellClass: AnyClass?, identifier: String) -> Self {
        register(cellClass, forCellWithReuseIdentifier: identifier)
        return self
    }
    
    /// 注册头部尾部
    /// - Parameters:
    ///   - aClass: 视图类
    ///   - elementKind: 头部|尾部
    ///   - identifier: 复用标识符
    /// - Returns: 自身
    @discardableResult
    public func register(_ aClass: AnyClass?, elementKind: String, identifier: String) -> Self {
        register(aClass, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
        return self
    }
    
    /// 滚动到特定的 item 默认滚动方向水平
    /// - Parameters:
    ///   - indexPath: 第几个IndexPath
    ///   - scrollPosition: 滚动方式
    ///   - animated: 是否动画 默认 true
    /// - Returns: 自身
    @discardableResult
    public func scroll(
        to indexPath: IndexPath,
        at scrollPosition: UICollectionView.ScrollPosition = .centeredHorizontally,
        animated: Bool = true
    ) -> Self {
        if indexPath.row < 0 ||
            indexPath.section < 0 ||
            indexPath.section > self.numberOfSections
            || indexPath.row > self.numberOfItems (inSection: indexPath.section) {
            return self
        }
        scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
        return self
    }
    
    /// 滚动到特定的分区分行 默认滚动方向水平
    /// - Parameters:
    ///   - item: 第几item
    ///   - section: 第几 section
    ///   - scrollPosition: 滚动方式
    ///   - animated: 是否动画 默认 true
    /// - Returns: 自身
    @discardableResult
    public func scroll(
        item: Int,
        section: Int = 0,
        at scrollPosition: UICollectionView.ScrollPosition = .centeredHorizontally,
        animated: Bool = true
    ) -> Self {
        return scroll(to: IndexPath(item: item, section: section), at: scrollPosition, animated: animated)
    }
}

//MARK: - 初始化
extension UICollectionView {
    
    /// 初始化
    /// - Parameters:
    ///   - origin: origin 点
    ///   - size: size 大小
    ///   - layout: 布局对象
    public convenience init(origin: CGPoint, size: CGSize, layout: UICollectionViewLayout) {
        self.init(frame: CGRect(origin: origin, size: size), collectionViewLayout: layout)
    }
    
    /// 初始化
    /// - Parameters:
    ///   - x: x 坐标
    ///   - y: y 坐标
    ///   - width: 宽度大小
    ///   - height: 高度大小
    ///   - layout: 布局对象
    public convenience init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, layout: UICollectionViewLayout) {
        self.init(frame: CGRect(x: x, y: y, width: width, height: height), collectionViewLayout: layout)
    }
    
    /// 初始化 默认内边距 0
    /// - Parameters:
    ///   - superView: 父视图
    ///   - layout: 布局对象
    ///   - padding: 内边距
    public convenience init(superView: UIView, layout: UICollectionViewLayout, padding: CGFloat = 0) {
        self.init(frame: CGRect(
                    x: superView.kc.x + padding,
                    y: superView.kc.y + padding,
                    width: superView.kc.width - padding*2,
                    height: superView.kc.height - padding*2),
                  collectionViewLayout: layout
        )
    }
}
