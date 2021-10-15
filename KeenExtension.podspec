
Pod::Spec.new do |s|
  s.name          = 'KeenExtension'
  s.version       = '1.2.2'
  s.summary       = '对 UIKit、Foundation 等系统库中常见控件属性、函数的扩展'
  s.homepage      = 'https://github.com/chongzone/KeenExtension'
  s.license       = { :type => 'MIT', :file => 'LICENSE' }
  s.author        = { 'chongzone' => 'chongzone@163.com' }
  
  s.requires_arc  = true
  s.swift_version = '5.0'
  s.ios.deployment_target = '10.0'
  s.source = { :git => 'https://github.com/chongzone/KeenExtension.git', :tag => s.version }
  
  s.subspec 'Extensions' do |ex|
    ex.dependency 'KeenExtension/Utils'
    ex.source_files = 'KeenExtension/Classes/Extensions/**/*.swift'
  end
  
  s.subspec 'SnapKitEx' do |sn|
    sn.dependency 'SnapKit'
    sn.source_files = 'KeenExtension/Classes/SnapKitEx/*.swift'
  end
  
  s.subspec 'Utils' do |ut|
    ut.source_files = 'KeenExtension/Classes/Utils/*.swift'
  end
  
#  s.resource_bundles = {
#      'KeenExtension' => ['KeenExtension/Assets/*.png']
#  }
  
end
