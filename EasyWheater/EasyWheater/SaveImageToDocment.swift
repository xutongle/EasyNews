//
//  SaveImageToDocment.swift
//  EasyWheater
//
//  Created by zly.private on 16/7/6.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit

class SaveImageToDocment: NSObject {
    
    let fileName_in = "current.png"
    
    //
    static let saveImageToDocment = SaveImageToDocment()
    
    private override init() { }
    
    // 获取沙盒路径
    func getDocumentPath() -> String {
        //沙盒目录
        let urlForDocument = Tools.fileManager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains:NSSearchPathDomainMask.UserDomainMask)
        //获得沙盒url
        let documentUrl = urlForDocument[0]
        let documentStr = NSString.init(format: "%@", documentUrl)
        let docstr = documentStr.substringFromIndex(7)
        
        return docstr
    }
    
    // 保存图片
    func save(image image: UIImage, withName fileName: String, complete: (compltete: Bool) -> Void) -> Void {
        
        let filePath = getDocumentPath() + fileName_in
        
        print(filePath)
        
        //let saveImage = scaleImage(image: image, firSize: CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT))
        
        //let saveImage = clipToImage(image: image, firSize: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))
        
        //
        
        let queue = dispatch_queue_create("SaveQueue", DISPATCH_QUEUE_CONCURRENT)
        
        //自己创建一个线程保存图片
        dispatch_async(queue) {
            do {
                print("当前线程是-->",NSThread.currentThread())
                
                try UIImagePNGRepresentation(image)!.writeToFile(filePath, options: .AtomicWrite)
                // 回去显示图片要用到主线程 抛回去
                dispatch_async(dispatch_get_main_queue(), {
                    complete(compltete: true)
                })
            }catch {
                print(error)
                
                // 回去显示图片要用到主线程
                dispatch_async(dispatch_get_main_queue(), {
                    complete(compltete: false)
                })
            }
        }
        
    }
    
    // 获得图片
    func getImage(complete: (image: UIImage?)-> Void) -> Void {
        
        let queue = NSOperationQueue.init()
        
        let opera = NSBlockOperation.init {
            print("当前线程是-->", NSThread.currentThread())
            
            let imageData = NSData.init(contentsOfFile: self.getDocumentPath() + self.fileName_in)
            if imageData == nil {
                return
            }
            let image = UIImage.init(data: imageData!)
            
            dispatch_async(dispatch_get_main_queue(), {
                complete(image: image!)
            })
        }
        
        // 添加进去就会开启了
        queue.addOperation(opera)
    }
    
    // 图片缩放
    func scaleImage(image image: UIImage, firSize size:CGSize) -> UIImage {
        // 创建一个bitmap的context
        // 并把它设置成为当前正在使用的context
        UIGraphicsBeginImageContext(size)
        
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        // 从当前context获取裁剪的图片
        let scaleImage = UIGraphicsGetImageFromCurrentImageContext()
        // 使当前的context出堆栈
        UIGraphicsEndImageContext();
        
        return scaleImage
    }
    
    /**
     * 图片裁剪
     * rect 定义裁剪的区域相对于原图片的位置
     */
    func clipToImage(image image: UIImage, firSize rect:CGRect) -> UIImage {
        
        // 图片尺寸
        let size = CGSizeMake(rect.size.width, rect.size.height)
        // 获得CGImage
        let cgImage = image.CGImage
        
        //获得自定义的CG图片
        let subCGImage = CGImageCreateWithImageInRect(cgImage, rect)
        // 创建一个基于位图的上下文（context）,并将其设置为当前上下文(context)
        UIGraphicsBeginImageContext(size);
        // 获得上下文
        let context = UIGraphicsGetCurrentContext();
        // 绘制裁剪的CG图片
        CGContextDrawImage(context, rect, subCGImage);
        // 获得裁剪的图片
        let clipImage = UIImage.init(CGImage: subCGImage!)
        // 关闭环境
        //UIGraphicsEndImageContext();
        
        return clipImage
    }
    
}
