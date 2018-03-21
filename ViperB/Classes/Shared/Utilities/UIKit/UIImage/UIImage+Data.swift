//
//  UIIImage+Data.swift
//  NetsWhitelabelWalletApp
//
//  Created by Lukasz Marcin Margielewski on 22/12/2016.
//  Copyright © 2016 Unwire. All rights reserved.
//

import Foundation
import UIKit


fileprivate let imageSync = NSLock()
fileprivate let screenScale = UIScreen.main.scale


extension UIImage {

    public class func convertFromData(data: Data) -> UIImage? {
        let image = UIImage.safeImageWithData(data)
        return image
    }

    func imageByScalingToSize(toSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(toSize, !hasAlpha(), 0.0)
        draw(in: CGRect(x: 0, y: 0, width: toSize.width, height: toSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }

    func hasAlpha() -> Bool {
        guard let cgImage = self.cgImage else {
            return false
        }
        let alpha = cgImage.alphaInfo
        switch alpha {
        case .first, .last, .premultipliedFirst, .premultipliedLast, .alphaOnly:
            return true
        case .none, .noneSkipFirst, .noneSkipLast:
            return false
        }
    }

    func data(forcePng: Bool, compressionQuality: Float = 1.0) -> Data? {
        let hasAlpha = self.hasAlpha()
        let data = forcePng || hasAlpha ? UIImagePNGRepresentation(self) : UIImageJPEGRepresentation(self, CGFloat(compressionQuality))
        return data
    }

    func decompressedImage() -> UIImage! {
        let originalImageRef = self.cgImage
        let originalBitmapInfo = originalImageRef!.bitmapInfo
        let alphaInfo = originalImageRef!.alphaInfo

        // See: http://stackoverflow.com/questions/23723564/which-cgimagealphainfo-should-we-use
        var bitmapInfo = originalBitmapInfo
        switch alphaInfo {
        case .none:
            let rawBitmapInfoWithoutAlpha = bitmapInfo.rawValue & ~CGBitmapInfo.alphaInfoMask.rawValue
            let rawBitmapInfo = rawBitmapInfoWithoutAlpha | CGImageAlphaInfo.noneSkipFirst.rawValue
            bitmapInfo = CGBitmapInfo(rawValue: rawBitmapInfo)
        case .premultipliedFirst, .premultipliedLast, .noneSkipFirst, .noneSkipLast:
            break
        case .alphaOnly, .last, .first: // Unsupported
            return self
        }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let pixelSize = CGSize(width: self.size.width * self.scale, height: self.size.height * self.scale)
        guard let context = CGContext(data: nil,
                                     width: Int(ceil(pixelSize.width)),
                                    height: Int(ceil(pixelSize.height)),
                          bitsPerComponent: originalImageRef!.bitsPerComponent,
                              bytesPerRow: 0,
                                    space: colorSpace,
                               bitmapInfo: bitmapInfo.rawValue) else {
            return self
        }
        let imageRect = CGRect(x: 0, y: 0, width: pixelSize.width, height: pixelSize.height)
        UIGraphicsPushContext(context)

        // Flip coordinate system.
        // See: http://stackoverflow.com/questions/506622/cgcontextdrawimage-draws-image-upside-down-when-passed-uiimage-cgimage
        context.translateBy(x: 0, y: pixelSize.height)
        context.scaleBy(x: 1.0, y: -1.0)

        // UIImage and drawInRect takes into account image orientation, unlike CGContextDrawImage.
        self.draw(in: imageRect)
        UIGraphicsPopContext()

        guard let decompressedImageRef = context.makeImage() else {
            return self
        }

        let image = UIImage(cgImage: decompressedImageRef, scale: screenScale, orientation: UIImageOrientation.up)
        return image
    }


    // MARK: - Private

    // HACK: UIImage data initializer is no longer thread safe. See: https://github.com/AFNetworking/AFNetworking/issues/2572#issuecomment-115854482
    private static func safeImageWithData(_ data: Data) -> UIImage? {
        imageSync.lock()
        let image = UIImage(data: data, scale: screenScale)
        imageSync.unlock()
        return image
    }

}
