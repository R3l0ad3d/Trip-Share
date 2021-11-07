//
//  UIView+Extension.swift
//  DocumentScanner
//
//  Created by Azizur Rahman on 2/6/21.
//

import Foundation
import UIKit

extension UIView{
    @IBInspectable
    var cornarRadius : CGFloat{
        get {
            return self.layer.cornerRadius
        }set{
            self.clipsToBounds = true
            self.layer.cornerRadius = newValue
            layoutIfNeeded()
        }
    }
    
    func getImage()-> UIImage?{
        
        autoreleasepool {
            if #available(iOS 10.0, *) {
                let renderer = UIGraphicsImageRenderer(bounds: bounds)
                return renderer.image { rendererContext in
                    layer.render(in: rendererContext.cgContext)
                }
            } else {
                // Fallback on earlier versions
                let rect: CGRect = self.frame
                
                UIGraphicsBeginImageContext(rect.size)
                let context: CGContext = UIGraphicsGetCurrentContext()!
                self.layer.render(in: context)
                let img = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                return img
            }
        }
    }
        
    func screenshot() -> UIImage {
        return UIGraphicsImageRenderer(size: bounds.size).image { _ in
          drawHierarchy(in: CGRect(origin: .zero, size: bounds.size), afterScreenUpdates: true)
        }
      }
}
