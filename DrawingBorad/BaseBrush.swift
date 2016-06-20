//
//  BaseBrush.swift
//  DrawingBorad
//
//  Created by 宋旭 on 16/3/25.
//  Copyright © 2016年 sky. All rights reserved.
//

import UIKit

protocol PaintBrush {
    func supportedContinuousDrawing() -> Bool
    func drawInContext(context: CGContextRef)
}

class BaseBrush: NSObject, PaintBrush {

    var beginPoint: CGPoint!
    var endPoint: CGPoint!
    var lastPoint: CGPoint?
    var strokeWidth: CGFloat!
    
    func  supportedContinuousDrawing() -> Bool {
        return false
    }
    func drawInContext(context: CGContextRef) {
        assert(false, "must implements in subclass.")
    }
}
