![KeenExtension](https://raw.githubusercontent.com/chongzone/KeenExtension/master/Resources/KeenExtensionLogo.png)

![CI Status](https://img.shields.io/travis/chongzone/KeenExtension.svg?style=flat)
![](https://img.shields.io/badge/swift-5.0%2B-orange.svg?style=flat)
![](https://img.shields.io/badge/pod-v1.0.9-brightgreen.svg?style=flat)
![](https://img.shields.io/badge/platform-iOS-orange.svg?style=flat)
![](https://img.shields.io/badge/license-MIT-blue.svg)

## 功能介绍

#### `Foundation` 系统库
- [x] `Array` 添加元素、转化字符串
- [x] `Dictionary` 索引、转化字符串
- [x] `Collection` 集合类取值防越界处理 
- [x] `Bundle` app 名称、版本、标识符等
- [x] `NSObject` 类名获取、运行时运用等
- [x] `Data` 根据字节数据流得到图片类型 
- [x] `String` 索引、截取、字符串转换、有效性校验等
- [x] `DispatchQueue` 异步事件、延迟事件、主线程事件等
- [x] `UserDefaults`  对系统对象、自定义对象的增删改查等
- [x] `Date`  年份月份天数周数等具体日期、日期字符串转换等
- [x] `NSAttributedString` 链式属性、附件插入、富文本设置等
- [x] `FileManager` 文件路径、文件的读写拷贝移动、文件大小、属性等
- [x] `AVAssetExportSession` 本地视频压缩

#### `UIKit` 系统库
- [x] 基本类型转换、视觉适配等
- [x] `UIDevice` 设备信息、磁盘容量等
- [x] `UIFont` 字体获取、常见的视觉字体等
- [x] `UIColor` 色值获取、常见的视觉色值等
- [x] `CALayer` 链式属性、常见的动画等
- [x] `UILabel` 链式属性、富文本设置、获取文本大小等 
- [x] `UIControl` 链式属性、事件点击、扩大响应区域等 
- [x] `UIButton` 链式属性、按钮图片、文字的几种布局等 
- [x] `UIView` 链式属性、形变、阴影圆角、截屏、事件点击、添加手势事件、常见的动画等
- [x] `UITextView` 链式属性、占位符、限制输入字数、高度根据内容自动变化等
- [x] `UITextField` 链式属性、左右视图、文本格式化等
- [x] `UIImageView`  `UIDatePicker`  `UIProgressView`  链式属性 
- [x] `UIImage` 链式属性、合成渐变水印、裁剪缩放翻转、抠图滤镜马赛克、二维码条形码、Gif 图加载等 
- [x] `UIScrollView` 链式属性、适配 `iOS11` 以上、滚动事件等 
- [x] `UITableView` 链式属性、适配 `iOS11` 以上、初始化扩展等 
- [x] `UICollectionView` 链式属性、初始化扩展等
- [x] `UIBarButtonItem` 初始化 `item` 等
- [x] `UINavigationBar` 链式属性、导航栏下划线、标题属性、左右 `item` 属性等
- [x] `UIViewController` 链式属性、是否模态、返回指定控制器、跳转到指定控制器、栈顶控制器等
- [x] `UIGestureRecognizer` 链式属性、手势事件等扩展  

## 安装方式 

### CocoaPods

```ruby
platform :ios, '10.0'
use_frameworks!

target 'TargetName' do

pod 'KeenExtension'

end
```
> `Swift` 版本要求 `5.0+`

## License

KeenExtension is available under the MIT license. [See the LICENSE](https://github.com/chongzone/KeenExtension/blob/main/LICENSE) file for more info.
