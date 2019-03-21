//
//  ImageRecognitionView.swift
//  Object_Detection_iOS
//
//  Created by Cyril Garcia on 3/21/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class GenericView: UIView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        
        return imageView
    }()
    
    let imageLabel: UILabel = {
        let label = UILabel()
        label.text = "---"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let imageSelector: UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: 125, height: 50)
        button.setTitle("Select Image", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func viewSetup() {
        
        backgroundColor = .white
        
        let viewWidth = self.frame.width
        let viewHeight = self.frame.height
        
        imageView.frame = CGRect(x: 0, y: 35, width: viewWidth, height: 480)
        
        imageLabel.frame.size = CGSize(width: 150, height: 50)
        imageLabel.center = CGPoint(x: viewWidth / 2, y: viewHeight * 0.65)
        
        imageSelector.frame.size = CGSize(width: 150, height: 50)
        imageSelector.center = CGPoint(x: viewWidth / 2, y: viewHeight * 0.75)
        
        addSubview(imageView)
        addSubview(imageLabel)
        addSubview(imageSelector)
    }
    
    public func setLabel(_ text: String) {
        imageLabel.text = text
    }
    
    public func setImage(_ image: UIImage) {
        imageView.image = image        
    }
    
    public func addButtonTarget(_ selector: Selector, at vc: UIViewController) {
        imageSelector.addTarget(vc, action: selector, for: .touchUpInside)
    }
    
}
