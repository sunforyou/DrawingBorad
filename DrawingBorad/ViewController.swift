//
//  ViewController.swift
//  DrawingBorad
//
//  Created by 宋旭 on 16/3/25.
//  Copyright © 2016年 sky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var brushes = [PencilBrush()]
    
    @IBOutlet weak var board: Board!
    
    @IBOutlet weak var strokeWidthSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.board.brush = brushes[0]
        
        self.strokeWidthSlider.addTarget(self,
                                         action: #selector(strokeWidthChanged(_:)),
                                         forControlEvents:.ValueChanged)
    }
    
    //MARK: -- 线宽
    func strokeWidthChanged(slider: UISlider) {
        self.board.strokeWidth = CGFloat(slider.value)
    }
    
    //MARK: -- 清空
    @IBAction func clearBoard(sender: UIBarButtonItem) {
        self.board.image = nil
        self.board.realImage = nil
    }
    
    //MARK: -- 保存至相册
    @IBAction func saveToAlbum(sender: UIBarButtonItem) {
        UIImageWriteToSavedPhotosAlbum(self.board.image!, self, #selector(ViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    //MARK: -- 保存成功弹窗
    func image(image: UIImage, didFinishSavingWithError error: NSError?,
               contextInfo:UnsafePointer<Void>) {
        
        if let err = error {
            
            let alertController = UIAlertController(title: "错误",
                                                    message: err.localizedDescription,
                                                    preferredStyle: UIAlertControllerStyle.Alert)
            let cancelAction = UIAlertAction(title: "取消",
                                             style: UIAlertActionStyle.Default,
                                             handler: nil)
            
            alertController.addAction(cancelAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        } else {
            
            let alertController = UIAlertController(title: "恭喜",
                                                    message: "保存成功",
                                                    preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "好的",
                                         style: UIAlertActionStyle.Default,
                                         handler: nil)
            
            alertController.addAction(okAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
}

