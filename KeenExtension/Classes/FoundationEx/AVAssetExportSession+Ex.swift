//
//  AVAssetExportSession+Ex.swift
//  KeenExtension
//
//  Created by chongzone on 2020/8/18.
//

import Foundation
import AVFoundation

//MARK: - 常见功能
extension KcPrefixWrapper where Base: AVAssetExportSession {
    
    /// 本地视频压缩 默认导出 .MP4
    /// - Parameters:
    ///   - inputPath: 输入视频路径
    ///   - outputPath: 输出视频路径
    ///   - outputFileType: 导出视频类型 默认 MP4
    ///   - exportPresetMediumQuality: 压缩质量 默认 MediumQuality
    ///   - callback: 视频信息 元组对象(视频对象, 视频时长, 视频压缩后大小)
    public static func assetExportSession(
        inputPath: String,
        outputPath: String,
        outputFileType: AVFileType = .mp4,
        exportPresetMediumQuality: String = AVAssetExportPresetMediumQuality,
        callback: @escaping (AVAssetExportSession, Float64, String) -> Void
    ) {
        guard FileManager.kc.isExist(at: inputPath) else { return }
        FileManager.kc.removefile(at: outputPath)
        let avAsset = AVURLAsset(url: URL(fileURLWithPath: inputPath), options: nil)
        let assetTime = avAsset.duration
        /// 视频时长
        let duration = CMTimeGetSeconds(assetTime)
        /// 配置压缩参数
        let export = AVAssetExportSession(
            asset: avAsset,
            presetName: exportPresetMediumQuality
        )
        guard let exportSession = export else { return }
        exportSession.outputURL = URL(fileURLWithPath: outputPath)
        exportSession.outputFileType = outputFileType
        exportSession.shouldOptimizeForNetworkUse = true
        exportSession.exportAsynchronously {
            switch exportSession.status {
            case .completed:
                callback(
                    exportSession,
                    duration,
                    FileManager.kc.fileSize(at: outputPath)
                )
            case .waiting, .exporting, .cancelled, .failed:
                print(exportSession.error?.localizedDescription ?? "")
                fallthrough
            case .unknown:
                callback(exportSession, duration, "")
            @unknown default:
                callback(exportSession, duration, "")
            }
        }
    }
}

