//
//  UIDevice+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/6/27.
//

import UIKit

//MARK: - 设备信息
extension KcPrefixWrapper where Base: UIDevice {
    
    /// 是否 2x
    public static var is_2x: Bool { UIScreen.main.scale == 2.0 }
    /// 是否 3x
    public static var is_3x: Bool { UIScreen.main.scale == 3.0 }
    /// 是否 retina
    public static var isRetina: Bool { UIScreen.main.scale >= 2.0 }
    
    /// 是否模拟器
    public static var isSimulator: Bool {
        var isSim = false
        #if arch(i386) || arch(x86_64)
        isSim = true
        #endif
        return isSim
    }
    
    /// 是否 iPad
    public static var isIpad: Bool {
        if #available(iOS 13, *) {
            return UIDevice().userInterfaceIdiom == .pad
        }else {
            return UI_USER_INTERFACE_IDIOM() == .pad
        }
    }
    
    /// 是否 iPhone
    public static var isIPhone: Bool {
        if #available(iOS 13, *) {
            return UIDevice().userInterfaceIdiom == .phone
        }else {
            return UI_USER_INTERFACE_IDIOM() == .phone
        }
    }
    
    /// 是否 X 系列机型
    public static var isIPhoneXSeries: Bool {
        var iPhoneXSeries = false
        guard UIDevice.current.userInterfaceIdiom == .phone else { return iPhoneXSeries }
        if #available(iOS 11.0, *) {
            if let w = keyWindow {
                if w.safeAreaInsets.bottom > 0.0  {
                    iPhoneXSeries = true
                }
            }
        }
        return iPhoneXSeries
    }
    
    /// 是否越狱设备
    public static var isPrisonbreak: Bool {
        if self.isSimulator { return false }
        let paths = ["/Applications/Cydia.app",
                     "/private/var/lib/apt/",
                     "/private/var/lib/cydia",
                     "/private/var/stash"];
        for path in paths {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        let bash = fopen("/bin/bash", "r")
        if bash != nil {
            fclose(bash)
            return true
        }
        let path = String(format: "/private/%@", UIDevice.kc.uuid)
        do {
            try "test".write(toFile: path, atomically: true, encoding: .utf8)
            try FileManager.default.removeItem(atPath: path)
            return true
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
    
    /// windows
    public static var windows: [UIWindow] { UIApplication.shared.windows }
    /// 主屏幕
    public static var keyWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .first { $0.activationState == .foregroundActive }
                .map { $0 as? UIWindowScene }
                .map { $0?.windows.first } ?? UIApplication.shared.delegate?.window ?? nil
        }
        return UIApplication.shared.delegate?.window ?? nil
    }
    
    /// 设备名称
    public static var deviceName: String { UIDevice.current.name }
    /// 设备类型 如  iPhone、iPad、iPod touch 等
    public static var deviceType: String { UIDevice.current.model }
    /// 设备系统名称 如 iOS OS
    public static var systemName: String { UIDevice.current.systemName }
    /// 设备系统版本
    public static var systemVersion: String { UIDevice.current.systemVersion }
    /// 设备系统升级时间
    public static var systemUptime: Date {
        return Date(timeIntervalSinceNow: 0 - ProcessInfo.processInfo.systemUptime)
    }
    /// 设备当前方向
    public static var orientation: UIDeviceOrientation {
        return UIDevice.current.orientation
    }
    
    /// 设备唯一标识 UUID (长度 32 位数字 & 字母组合)
    /// 每次启动值都会变化
    public static var uuid: String {
        let cr_uuid = CFUUIDCreate(nil)
        let cf_uuid = CFUUIDCreateString(nil , cr_uuid)
        return (cf_uuid as String?)!
    }
    /// 设备唯一标识 (长度 32 位数字 & 字母组合)
    /// 每次启动值不会变(同一设备&同一供应商该值相同, 其他则不相同)
    public static var identifier: UUID? {
        return UIDevice.current.identifierForVendor
    }
    /// 设备区域化型号 如 A1533
    public static var localizedModel: String {
        return UIDevice.current.localizedModel
    }
    
    /// 设备型号 模拟器(x86_64) 真机(iPhonex,x  iPodx,x)
    /// 根据这个型号可拿到具体的手机型号
    public static var model: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    /// 设备具体的型号
    /// 具体可参考官网地址 https://www.theiphonewiki.com/wiki/Models
    public var detailModel: String {
        let identifier = UIDevice.kc.model
        switch identifier {
        // ---------------------------- iPhone ---------------------------------
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone8,4":                               return "iPhone SE 1nd Gen"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPhone11,2":                              return "iPhone XS"
        case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
        case "iPhone11,8":                              return "iPhone XR"
        case "iPhone12,1":                              return "iPhone 11"
        case "iPhone12,3":                              return "iPhone 11 Pro"
        case "iPhone12,5":                              return "iPhone 11 Pro Max"
        case "iPhone12,8":                              return "iPhone SE 2nd Gen"
        case "iPhone13,1":                              return "iPhone 12 mini"
        case "iPhone13,2":                              return "iPhone 12"
        case "iPhone13,3":                              return "iPhone 12 Pro"
        case "iPhone13,4":                              return "iPhone 12 Pro Max"
        case "iPhone14,4":                              return "iPhone 13 mini"
        case "iPhone14,5":                              return "iPhone 13"
        case "iPhone14,2":                              return "iPhone 13 Pro"
        case "iPhone14,3":                              return "iPhone 13 Pro Max"
            
        // ---------------------------- iPad ---------------------------------
        case "iPad2,1", "iPad2,2":                      return "iPad 2"
        case "iPad2,3", "iPad2,4":                      return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad7,5", "iPad7,6":                      return "iPad 6"
        case "iPad7,11", "iPad7,12":                    return "iPad 7"
        case "iPad11,6", "iPad11,7":                    return "iPad 8"
        case "iPad12,1", "iPad12,2":                    return "iPad 9"
            
        // ---------------------------- iPad Mini ---------------------------------
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad11,1", "iPad11,2":                    return "iPad Mini 5"
        case "iPad14,1", "iPad14,2":                    return "iPad Mini 6"
        
        // ---------------------------- iPad Air ---------------------------------
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad11,3", "iPad11,4":                    return "iPad Air 3"
        case "iPad13,1", "iPad13,2":                    return "iPad Air 4"
            
        // ---------------------------- iPad Pro ---------------------------------
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7-inch"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5-inch"
        case "iPad8,1", "iPad8,2":                      return "iPad Pro 11-inch"
        case "iPad8,3", "iPad8,4":                      return "iPad Pro 11-inch"
        case "iPad8,9", "iPad8,10":                     return "iPad Pro 11-inch 2"
        case "iPad13,4", "iPad13,5":                    return "iPad Pro 11-inch 3"
        case "iPad13,6", "iPad13,7":                    return "iPad Pro 11-inch 3"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9-inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9-inch 2"
        case "iPad8,5", "iPad8,6":                      return "iPad Pro 12.9-inch 3"
        case "iPad8,7", "iPad8,8":                      return "iPad Pro 12.9-inch 3"
        case "iPad8,11", "iPad8,12":                    return "iPad Pro 12.9-inch 4"
        case "iPad13,8", "iPad13,9":                    return "iPad Pro 12.9-inch 5"
        case "iPad13,10", "iPad13,11":                  return "iPad Pro 12.9-inch 5"
        
        // ---------------------------- iPod touch ---------------------------------
        case "iPod1,1":                  return "iPod touch"
        case "iPod2,1":                  return "iPod touch 2"
        case "iPod3,1":                  return "iPod touch 3"
        case "iPod4,1":                  return "iPod touch 4"
        case "iPod5,1":                  return "iPod touch 5"
        case "iPod7,1":                  return "iPod touch 6"
        case "iPod9,1":                  return "iPod touch 7"
            
        // ---------------------------- Simulator ---------------------------------
        case "i386", "x86_64":                          return "iPhone Simulator"
        default:                                        return identifier
        }
    }
    
    /// 设备网址 IP
    public static func iPAddress() -> String? {
        var addresses = [String]()
        var pointer : UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&pointer) == 0 {
            var ptr = pointer
            while (ptr != nil) {
                let flags = Int32(ptr!.pointee.ifa_flags)
                var addr = ptr!.pointee.ifa_addr.pointee
                if (flags & (IFF_UP | IFF_RUNNING | IFF_LOOPBACK)) == (IFF_UP | IFF_RUNNING) {
                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                            if let address = String(validatingUTF8:hostname) {
                                addresses.append(address)
                            }
                        }
                    }
                }
                ptr = ptr!.pointee.ifa_next
            }
            freeifaddrs(pointer)
        }
        return addresses.first
    }
    
    /// 设备总内存容量
    public static var memoryAllCapacity: UInt64 {
        return ProcessInfo.processInfo.physicalMemory
    }
    
    /// 设备总磁盘容量
    public static var diskAllCapacity: Int64 {
        if let attrs = try? FileManager.default.attributesOfFileSystem(
            forPath: NSHomeDirectory()
        ) {
            if let capacity: NSNumber = attrs[.systemSize] as? NSNumber {
                if capacity.int64Value > 0 {
                    return capacity.int64Value
                }
            }
        }
        return -1
    }
    
    /// 设备可用磁盘容量 -1 代表没可用的磁盘容量
    public static var diskLeaveCapacity: Int64 {
        if let attrs = try? FileManager.default.attributesOfFileSystem(
            forPath: NSHomeDirectory()
        ) {
            if let space: NSNumber = attrs[.systemFreeSize] as? NSNumber {
                if space.int64Value > 0 {
                    return space.int64Value
                }
            }
        }
        return -1
    }
    
    /// 设备已用的磁盘容量 -1代表磁盘没被使用过
    public static var diskUsedCapacity: Int64 {
        let all = diskAllCapacity
        let leave = diskLeaveCapacity
        guard all > 0 && leave > 0 else { return -1 }
        let used = all - leave
        guard used > 0 else { return -1 }
        return used
    }
}
