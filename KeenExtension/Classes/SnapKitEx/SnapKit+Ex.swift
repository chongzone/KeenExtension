//
//  SnapKit+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2021/3/5.
//

import UIKit
import SnapKit

/// 数组属性扩展
extension Array {
    public var snp: ConstraintArrayDSL {
        return ConstraintArrayDSL(self as! [ConstraintView])
    }
}

/// 数组子控件布局类型
public enum ConstraintAxisStyle: Int {
    /// 横向布局
    case horizontal
    /// 纵向布局
    case vertical
}

//MARK: - 数组子控件布局
public struct ConstraintArrayDSL {
    
    public let array: [ConstraintView]
    
    public init(_ array: [ConstraintView]) {
        self.array = array
    }
    
    public func makeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        array.forEach { $0.snp.makeConstraints(closure) }
    }
    
    public func remakeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        array.forEach { $0.snp.remakeConstraints(closure) }
    }
    
    public func updateConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        array.forEach { $0.snp.updateConstraints(closure) }
    }
    
    public func removeConstraints() {
        array.forEach { $0.snp.removeConstraints() }
    }
}

//MARK: - 等间隔|九宫格等布局
extension ConstraintArrayDSL {
    
    /// 等间距布局控件 默认横向布局
    /// 若是横向 则子控件设置需Y轴和高度 若是纵向 则子控件需设置X轴和宽度
    /// - Parameters:
    ///   - axis: 布局样式 默认 横向
    ///   - fixedSpacing: 控件间的间距
    ///   - leadSpacing: 第一个控件距离父视图的间距
    ///   - tailSpacing: 最后一个控件距离父视图的间距
    public func distributeViewsAlongAxis(
        _ axis: ConstraintAxisStyle = .horizontal,
        fixedSpacing: CGFloat,
        leadSpacing: CGFloat,
        tailSpacing: CGFloat) {
        guard array.count > 1 else {
            fatalError("views to distribute need to bigger than one")
        }
        let tempSuperView = commonSuperviewOfViews()
        switch axis {
        case .horizontal:
            var preView : ConstraintView?
            for (idx, view) in array.enumerated() {
                view.snp.makeConstraints({ (make) in
                    if let prev = preView {
                        if (idx == array.count - 1) {
                            make.right.equalTo(tempSuperView).offset(-tailSpacing)
                        }
                        make.width.equalTo(prev)
                        make.left.equalTo(prev.snp.right).offset(fixedSpacing)
                    }else {
                        make.left.equalTo(tempSuperView).offset(leadSpacing)
                    }
                })
                preView = view
            }
        case .vertical:
            var preView : ConstraintView?
            for (idx, view) in array.enumerated() {
                view.snp.makeConstraints({ (make) in
                    if let prev = preView {
                        if (idx == array.count - 1) {
                            make.bottom.equalTo(tempSuperView).offset(-tailSpacing)
                        }
                        make.height.equalTo(prev)
                        make.top.equalTo(prev.snp.bottom).offset(fixedSpacing)
                    }else {
                        make.top.equalTo(tempSuperView).offset(leadSpacing)
                    }
                })
                preView = view
            }
        }
    }
    
    /// 等宽度|高度布局控件 默认横向布局
    /// 若是横向 则子控件设置需Y轴和高度 若是纵向 则子控件需设置X轴和宽度
    /// - Parameters:
    ///   - axis: 布局样式 默认 横向
    ///   - fixedItemLength: 控件的宽度|高度
    ///   - leadSpacing: 第一个控件距离父视图的间距
    ///   - tailSpacing: 最后一个控件距离父视图的间距
    public func distributeViewsAlongAxis(
        _ axis: ConstraintAxisStyle = .horizontal,
        fixedItemLength: CGFloat,
        leadSpacing: CGFloat,
        tailSpacing: CGFloat) {
        guard array.count > 1 else {
            fatalError("views to distribute need to bigger than one")
        }
        let tempSuperView = commonSuperviewOfViews()
        switch axis {
        case .horizontal:
            var preView : ConstraintView?
            for (idx, view) in array.enumerated() {
                view.snp.makeConstraints({ (make) in
                    make.width.equalTo(fixedItemLength)
                    if let _ = preView {
                        if (idx == array.count - 1) {
                            make.right.equalTo(tempSuperView).offset(-tailSpacing)
                        }else {
                            let multiplied = CGFloat(idx) / CGFloat(array.count - 1)
                            let totalTailSpacing = tailSpacing * multiplied
                            let totalItemLength = fixedItemLength + leadSpacing
                            let offset = (1 - multiplied) * totalItemLength - totalTailSpacing
                            make.right.equalTo(tempSuperView)
                                .multipliedBy(multiplied)
                                .offset(offset)
                        }
                    }else {
                        make.left.equalTo(tempSuperView).offset(leadSpacing)
                    }
                })
                preView = view
            }
        case .vertical:
            var preView : ConstraintView?
            for (idx, view) in self.array.enumerated() {
                view.snp.makeConstraints({ (make) in
                    make.height.equalTo(fixedItemLength)
                    guard let _ = preView else {
                        make.top.equalTo(tempSuperView).offset(leadSpacing)
                        return
                    }
                    if (idx == array.count - 1) {
                        make.bottom.equalTo(tempSuperView).offset(-tailSpacing)
                    }else {
                        let multiplied = CGFloat(idx) / CGFloat(array.count - 1)
                        let totalTailSpacing = tailSpacing * multiplied
                        let totalItemLength = fixedItemLength + leadSpacing
                        let offset = (1 - multiplied) * totalItemLength - totalTailSpacing
                        make.bottom.equalTo(tempSuperView)
                            .multipliedBy(multiplied)
                            .offset(offset)
                    }
                })
                preView = view
            }
        }
    }
    
    /// 九宫格布局 控件间距可变 控件宽高固定 默认内边距 0
    /// 数组内的子控件不需单独布局
    /// - Parameters:
    ///   - fixedItemWidth: 控件的宽度
    ///   - fixedItemHeight: 控件的高度
    ///   - numberOfPerLine: 每行的控件数
    ///   - edgeInset: 距离父视图的内边距
    public func distributeSudokuViews(
        fixedItemWidth: CGFloat,
        fixedItemHeight: CGFloat,
        numberOfPerLine: Int,
        edgeInset: UIEdgeInsets = .zero) {
        guard (array.count > 1) || (numberOfPerLine >= 1) else {
            fatalError("views to distribute need to bigger than one")
        }
        let tempSuperView = commonSuperviewOfViews()
        let rowCount = array.count % numberOfPerLine == 0 ? (array.count / numberOfPerLine) : (array.count / numberOfPerLine) + 1
        for (idx, view) in array.enumerated() {
            /// 当前行
            let currentRow = idx / numberOfPerLine
            /// 当前列
            let currentColumn = idx % numberOfPerLine
            view.snp.makeConstraints({ (make) in
                make.size.equalTo(CGSize(width: fixedItemWidth, height: fixedItemHeight))
                /// 行布局
                if currentRow == 0 {
                    make.top.equalTo(tempSuperView).offset(edgeInset.top)
                }else if currentRow == rowCount - 1 {
                    make.bottom.equalTo(tempSuperView).offset(-edgeInset.bottom)
                }else {
                    let multiplied = CGFloat(currentRow) / CGFloat(rowCount - 1)
                    let totalTailSpacing = edgeInset.bottom * multiplied
                    let totalItemLength = fixedItemHeight + edgeInset.top
                    let offset = (1 - multiplied) * totalItemLength - totalTailSpacing
                    make.bottom.equalTo(tempSuperView)
                        .multipliedBy(multiplied)
                        .offset(offset)
                }
                /// 列布局
                if currentColumn == 0 {
                    make.left.equalTo(tempSuperView).offset(edgeInset.left)
                }else if currentColumn == numberOfPerLine - 1 {
                    make.right.equalTo(tempSuperView).offset(-edgeInset.right)
                }else {
                    let multiplied = CGFloat(currentColumn) / CGFloat(numberOfPerLine - 1)
                    let totalTailSpacing = edgeInset.right * multiplied
                    let totalItemLength = fixedItemWidth + edgeInset.left
                    let offset = (1 - multiplied) * totalItemLength - totalTailSpacing
                    make.right.equalTo(tempSuperView)
                        .multipliedBy(multiplied)
                        .offset(offset)
                }
            })
        }
    }
    
    /// 九宫格布局 控件间距固定 控件宽高可变  默认内边距 0
    /// 数组内的子控件不需单独布局
    /// - Parameters:
    ///   - fixedLineSpacing: 控件的行间距
    ///   - fixedInteritemSpacing: 控件的列间距
    ///   - numberOfPerLine: 每行的控件数
    ///   - edgeInset: 距离父视图的内边距
    public func distributeSudokuViews(
        fixedLineSpacing: CGFloat,
        fixedInteritemSpacing: CGFloat,
        numberOfPerLine: Int,
        edgeInset: UIEdgeInsets = .zero) {
        guard (array.count > 1) || (numberOfPerLine >= 1) else {
            fatalError("views to distribute need to bigger than one")
        }
        let tempSuperView = commonSuperviewOfViews()
        var items: [ConstraintView] = array
        if numberOfPerLine > array.count {
            for _ in 0..<(numberOfPerLine-array.count) {
                let emptyView = UIView()
                tempSuperView.addSubview(emptyView)
                items.append(emptyView)
            }
        }
        var preView : ConstraintView?
        let rowCount = items.count % numberOfPerLine == 0 ? (items.count / numberOfPerLine) : (items.count / numberOfPerLine) + 1
        for (idx, view) in items.enumerated() {
            /// 当前行
            let currentRow = idx / numberOfPerLine
            /// 当前列
            let currentColumn = idx % numberOfPerLine
            view.snp.makeConstraints { make in
                guard let prev = preView else { // 仅一行一列
                    make.top.equalTo(tempSuperView).offset(edgeInset.top)
                    make.left.equalTo(tempSuperView).offset(edgeInset.left)
                    return
                }
                make.width.height.equalTo(prev)
                /// 行布局
                if currentRow == 0 {
                    make.top.equalTo(tempSuperView).offset(edgeInset.top)
                }
                if currentRow == rowCount - 1 {
                    if currentRow != 0, idx-numberOfPerLine >= 0 { // 仅一列
                        make.top.equalTo(items[(idx - numberOfPerLine)].snp.bottom).offset(fixedLineSpacing)
                    }
                    make.bottom.equalTo(tempSuperView).offset(-edgeInset.bottom)
                }
                if currentRow != 0, currentRow != rowCount - 1 {
                    make.top.equalTo(items[(idx - numberOfPerLine)].snp.bottom).offset(fixedLineSpacing)
                }
                /// 列布局
                if currentColumn == 0 {
                    make.left.equalTo(tempSuperView).offset(edgeInset.left)
                }
                if currentColumn == numberOfPerLine - 1 {
                    if numberOfPerLine != 0 { // 仅一行
                        make.left.equalTo(prev.snp.right).offset(fixedInteritemSpacing)
                    }
                    make.right.equalTo(tempSuperView).offset(-edgeInset.right)
                }
                if currentColumn != 0, currentColumn != numberOfPerLine - 1 {
                    make.left.equalTo(prev.snp.right).offset(fixedInteritemSpacing)
                }
            }
            preView = view
        }
    }
    
    /// 找出共有的父视图
    /// - Returns: 父视图
    private func commonSuperviewOfViews() -> ConstraintView {
        var commonSuperview : ConstraintView?
        var previousView : ConstraintView?
        array.forEach { view in
            if view.isKind(of: UIView.self) {
                if let _ = previousView {
                    commonSuperview = view.closestCommonSuperview(commonSuperview)
                }else {
                    commonSuperview = view
                }
                previousView = view
            }
        }
        guard let commonView = commonSuperview else {
            fatalError("Can't constrain views that do not share a common superview. Make sure that all the views in this array have been added into the same view hierarchy")
        }
        return commonView
    }
}

extension ConstraintView {
    
    fileprivate func closestCommonSuperview(_ view : ConstraintView?) -> ConstraintView? {
        var closestCommonSuperview: ConstraintView?
        var secondViewSuperview: ConstraintView? = view
        while (closestCommonSuperview == nil), let secondView = secondViewSuperview {
            var firstViewSuperview: ConstraintView? = self
            while (closestCommonSuperview == nil), let firstView = firstViewSuperview {
                if secondView == firstView {
                    closestCommonSuperview = secondView
                }
                firstViewSuperview = firstView.superview
            }
            secondViewSuperview = secondView.superview
        }
        return closestCommonSuperview
    }
}
