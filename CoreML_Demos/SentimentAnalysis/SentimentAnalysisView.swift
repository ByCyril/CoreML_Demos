//
//  SentimentAnalysisView.swift
//  CoreML_Demos
//
//  Created by Cyril Garcia on 3/21/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class SentimentAnalysisView: UIView {
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.text = "Type here..."
        return textView
    }()
    
    let predictButton: UIButton = {
        let button = UIButton()
        button.setTitle("Predict", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    let predictionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        backgroundColor = .white
        
        let viewWidth = frame.width
        let viewHeight = frame.height
        
        textView.frame.size = CGSize(width: viewWidth - 40, height: viewWidth - 40)
        textView.center = CGPoint(x: viewWidth / 2, y: viewHeight * 0.40)
        
        predictButton.frame.size = CGSize(width: 150, height: 50)
        predictButton.center = CGPoint(x: viewWidth / 2, y: viewHeight * 0.75)
        
        predictionLabel.frame.size = CGSize(width: 150, height: 50)
        predictionLabel.center = CGPoint(x: viewWidth / 2, y: viewHeight / 2)
        
        addSubview(textView)
        addSubview(predictButton)
        addSubview(predictionLabel)
    }
    
    public func setText(_ text: String) {
        predictionLabel.text = text
    }
    
    public func getText() -> String {
        return textView.text
    }
    
    public func setButtonTarget(_ selector: Selector, at vc: UIViewController) {
        predictButton.addTarget(vc, action: selector, for: .touchUpInside)
    }
    
}
