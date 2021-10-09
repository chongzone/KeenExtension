
Pod::Spec.new do |s|
  s.name          = 'KeenExtension'
  s.version       = '1.0.7'
  s.summary       = '对 UIKit、Foundation 等系统库中常见控件属性、函数的扩展'
  s.homepage      = 'https://github.com/chongzone/KeenExtension'
  s.license       = { :type => 'MIT', :file => 'LICENSE' }
  s.author        = { 'chongzone' => 'chongzone@163.com' }
  
  s.requires_arc  = true
  s.swift_version = '5.0'
  s.ios.deployment_target = '10.0'
  s.source = { :git => 'https://github.com/chongzone/KeenExtension.git', :tag => s.version }
  
  s.source_files = 'KeenExtension/Classes/**/*'
#  s.resource_bundles = {
#      'KeenExtension' => ['KeenExtension/Assets/*.png']
#  }
  
end
