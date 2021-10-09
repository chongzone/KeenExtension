//
//  UIViewController+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/12/5.
//

import UIKit

//MARK: - 链式属性函数
extension UIViewController {
    
    /// 导航栏是否半透明 半透明且页面边缘向四周延伸的话 则页面从 (0, 0) 开始布局 默认非半透明
    /// 若从导航栏下进行布局 设置 isTranslucent  = false 或 设置页面四周无延伸 即  vc.edgesForExtendedLayout = []
    /// - Parameter enable: 是否半透明
    /// - Returns: 自身
    @discardableResult
    public func navIsTranslucent(_ enable: Bool = false) -> Self {
        navigationController?.navigationBar.isTranslucent = enable
        return self
    }
    
    /// 导航栏是否显示下划线 默认显示
    /// - Parameter show: 是否显示
    /// - Returns: 自身
    @discardableResult
    public func navShowUnderline(_ show: Bool = true) -> Self {
        navigationController?.navigationBar.showUnderline = show
        return self
    }
    
    /// 导航栏背景颜色 默认白色 不会出现色差
    /// - Parameter color: 颜色
    /// - Returns: 自身
    @discardableResult
    public func navBackColor(_ color: UIColor = .white) -> Self {
        navigationController?.navigationBar.backColor = color
        return self
    }
    
    /// 导航栏背景颜色 可能会出现色差  默认 nil
    /// 通过这个直接设置会导致色差 因为在 navigationBar 上面还覆盖着一个 visualeffectView 会对其进行模糊渲染
    /// 去除色差可同步关闭导航栏半透明(页面布局从导航栏下开始) 或 通过设置 setBackgroundImage( : , for : ) 处理
    /// - Parameter color: 背景色
    /// - Returns: 自身
    @discardableResult
    public func navBarTintColor(_ color: UIColor?) -> Self {
        navigationController?.navigationBar.barTintColor = color
        return self
    }
    
    /// 导航栏标题颜色 默认黑色
    /// - Parameter color: 颜色
    /// - Returns: 自身
    @discardableResult
    public func navTitleColor(_ color: UIColor = .black) -> Self {
        navigationController?.navigationBar.titleColor = color
        return self
    }
    
    /// 导航栏标题字体 默认加粗 18 pt
    /// - Parameter font: 字体
    /// - Returns: 自身
    @discardableResult
    public func navTitleFont(_ font: UIFont = .font_medium_18) -> Self {
        navigationController?.navigationBar.titleFont = font
        return self
    }
    
    /// 导航栏标题字体&颜色 字体默认加粗(18 pt) 颜色(黑色)
    /// - Parameter font: 字体
    /// - Parameter color: 颜色
    /// - Returns: 自身
    @discardableResult
    public func navTitleAttributes(_ font: UIFont = .font_medium_18, _ color: UIColor = .black) -> Self {
        navigationController?.navigationBar.titleAttributes = (font, color)
        return self
    }
    
    /// 导航栏左右 item 颜色 默认黑色
    /// - Parameter color: 颜色
    /// - Returns: 自身
    @discardableResult
    public func navBarColor(_ color: UIColor = .black) -> Self {
        navigationController?.navigationBar.barColor = color
        return self
    }
}

//MARK: - 常见功能
extension KcPrefixWrapper where Base: UIViewController {
    
    /// 栈容器是否存在模态跳转的 Vc
    public var isExistModel: Bool { base.presentingViewController != nil }
    
    /// 控制器是否正在显示
    public var isShowing: Bool {
        let keyWindow = UIDevice.kc.keyWindow
        let newFrame = keyWindow!.convert(base.view.frame, from: base.view.superview)
        let isIntersects = newFrame.intersects(keyWindow!.bounds);
        return !base.view.isHidden && base.view.alpha > 0.01 && base.view.window == keyWindow && isIntersects
    }
    
    /// 返回顶部控制器
    public static func topViewController() -> UIViewController? {
        let window = UIDevice.kc.keyWindow
        if var win = window {
            if win.windowLevel != .normal {
                let windows = UIDevice.kc.windows
                for w in windows {
                    if w.windowLevel == .normal {
                        win = w
                        break
                    }
                }
            }
            var topVc = win.rootViewController
            while topVc?.presentedViewController != nil {
                topVc = topVc?.presentedViewController
            }
            if ((topVc?.isKind(of: UITabBarController.self)) != false) {
                topVc = (topVc as? UITabBarController)?.selectedViewController
            }
            if ((topVc?.isKind(of: UINavigationController.self)) != false) {
                topVc = (topVc as? UINavigationController)?.topViewController
            }
            return topVc
        }else {
            return nil
        }
    }
    
    /// 跳转控制器
    /// - Parameters:
    ///   - vc: 目的控制器
    ///   - isModel: 是否模态
    ///   - animated: 是否动画
    public func show(
        _ vc: UIViewController,
        _ isModel: Bool = false,
        animated: Bool = true
    ) {
        if isModel {
            base.navigationController?.present(vc, animated: animated, completion: nil)
        }else {
            base.navigationController?.pushViewController(vc, animated: animated)
        }
    }
    
    /// 关闭当前控制器
    public func dismiss() {
        guard let nav = base.navigationController else {
            base.dismiss(animated: true, completion: nil)
            return
        }
        if nav.viewControllers.count > 1 {
            nav.popViewController(animated: true)
        }else if let _ = nav.presentingViewController {
            nav.dismiss(animated: true, completion: nil)
        }
    }
    
    /// 返回到指定控制器 默认动画
    /// - Parameters:
    ///   - vcClass: 控制器类型
    ///   - animated: 是否动画
    public func dismiss(to vcClass: AnyClass, animated: Bool = true) {
        guard let nav = base.navigationController else {
            return
        }
        for vc in nav.viewControllers.reversed() {
            if vc.isMember(of: vcClass) {
                nav.popToViewController(vc, animated: animated)
            }
        }
    }
    
    /// 关闭前面几个控制器(默认 1 个)  默认动画
    /// - Parameters:
    ///   - count: 关闭的控制器数量
    ///   - animated: 是否动画
    public func dismiss(_ count: Int = 1, animated: Bool = true) {
        guard let nav = base.navigationController, count >= 1 else {
            return
        }
        let vcsCount = nav.viewControllers.count
        if count >= vcsCount {
            nav.popToRootViewController(animated: animated)
            return
        }
        let vc = nav.viewControllers[vcsCount - count - 1]
        nav.popToViewController(vc, animated: animated)
    }
    
    /// 关闭掉前面几个控制器后再 push 到某个控制器 默认动画
    /// - Parameters:
    ///   - count: 控制器数量
    ///   - vc: 某个控制器
    ///   - animated: 是否动画
    public func dismiss(
        _ count: Int,
        to vc: UIViewController,
        animated: Bool = true
    ) {
        guard let nav = base.navigationController, count >= 1 else { return }
        let vcsCount = nav.viewControllers.count
        if count >= vcsCount {
            if let first = nav.viewControllers.first {
                nav.setViewControllers([first, vc], animated: animated)
            }
            return
        }
        var vcs = nav.viewControllers[0...(vcsCount - count - 1)]
        vcs.append(vc)
        nav.setViewControllers(Array(vcs), animated: animated)
    }
}
