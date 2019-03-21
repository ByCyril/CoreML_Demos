//
//  ObjectDetectionView.swift
//  Object_Detection_iOS
//
//  Created by Cyril Garcia on 3/21/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class ObjectDetectionView: GenericView {
    
    var boundingBox: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func drawBox(_ rect: CGRect) {
        let formatedRect = formatRect(rect)
        
        if let _ = boundingBox {
            boundingBox.frame = formatedRect
        } else {
            boundingBox = UIView(frame: formatedRect)
            boundingBox.backgroundColor = .clear
            boundingBox.layer.borderColor = UIColor.red.cgColor
            boundingBox.layer.borderWidth = 3
            addSubview(boundingBox)
        }
        
    }
    
    private func formatRect(_ rect: CGRect) -> CGRect {
        let x = imageView.frame.width * rect.origin.x
        let y = imageView.frame.height * rect.origin.y
        let w = imageView.frame.width * rect.width
        let h = imageView.frame.height * rect.height

        return CGRect(x: x, y: y, width: w, height: h)
    }
}
