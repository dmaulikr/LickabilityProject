//
//  UIImage+Color.swift
//  Lickability
//
//  Created by Komran Ghahremani on 8/13/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import UIKit

// Get Color from pixel in UIImage: https://stackoverflow.com/a/29814489

extension UIImageView {
    func getPixelColor(at point: CGPoint) -> UIColor {
        var pixel : [UInt8] = [0, 0, 0, 0]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: UnsafeMutablePointer(mutating: pixel), width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        context?.translateBy(x: -point.x, y: -point.y);
        self.layer.render(in: context!)
        
        let redColor : Float = Float(pixel[0])/255.0
        let greenColor : Float = Float(pixel[1])/255.0
        let blueColor: Float = Float(pixel[2])/255.0
        let colorAlpha: Float = Float(pixel[3])/255.0
        
        let color : UIColor! = UIColor(red: CGFloat(redColor), green: CGFloat(greenColor), blue: CGFloat(blueColor), alpha: CGFloat(colorAlpha))
        
        return color
    }
}
