//
//  Board.swift
//  DrawingBorad
//
//  Created by 宋旭 on 16/3/25.
//  Copyright © 2016年 sky. All rights reserved.
//

import UIKit

enum DrawingState {
    case Began, Moved, Ended
}

class Board: UIImageView {
    
    var brush: BaseBrush?
    var strokeWidth: CGFloat
    var strokeColor: UIColor
    
    var realImage: UIImage?
    private var drawingState: DrawingState!
    
    override init(frame: CGRect) {
        self.strokeWidth = 1
        self.strokeColor = UIColor.blackColor()
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.strokeWidth = 1
        self.strokeColor = UIColor.blackColor()
        super.init(coder: aDecoder)
    }
    
    // MARK: - - touches methods
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let brush = self.brush {
            brush.lastPoint = nil
            brush.beginPoint = touches.first!.locationInView(self)
            brush.endPoint = brush.beginPoint
            
            self.drawingState = .Began
            self.drawingImage()
            
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let brush = self.brush {
            
            brush.endPoint = touches.first!.locationInView(self)
            self.drawingState = .Moved
            self.drawingImage()
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let brush = self.brush {
            
            brush.endPoint = touches.first!.locationInView(self)
            self.drawingState = .Ended
            self.drawingImage()
        }
    }
    
    private func drawingImage() {
        if let brush = self.brush {
            
            UIGraphicsBeginImageContext(self.bounds.size)
            
            let context = UIGraphicsGetCurrentContext()
            
            UIColor.clearColor().setFill()
            UIRectFill(self.bounds)
            
            CGContextSetLineCap(context, CGLineCap.Round)
            CGContextSetLineWidth(context, self.strokeWidth)
            CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor)
            
            if let realImage = self.realImage {
                realImage.drawInRect(self.bounds)
            }
            
            brush.strokeWidth = self.strokeWidth
            brush.drawInContext(context!)
            CGContextStrokePath(context)
            
            let previewImage = UIGraphicsGetImageFromCurrentImageContext()
            if self.drawingState == .Ended || brush.supportedContinuousDrawing(){
                    self.realImage = previewImage
            }
            
            UIGraphicsEndImageContext()
            
            self.image = previewImage
            brush.lastPoint = brush.endPoint
        }
    }
}
