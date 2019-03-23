//
//  SentimentAnalysisController.swift
//  CoreML_Demos
//
//  Created by Cyril Garcia on 3/21/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit
import NaturalLanguage

class SentimentAnalysisController: UIViewController {
    
    private let model = SentimentModel()
    
    private var sentimentView: SentimentAnalysisView!
    private var sentimentModel: SentimentAnalysisModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        sentimentView = SentimentAnalysisView(frame: view.frame)
        sentimentView.setButtonTarget(#selector(SentimentAnalysisController.makePrediction), at: self)
        view.addSubview(sentimentView)
        
        sentimentModel = SentimentAnalysisModel(model)
        
    }
    
    @objc
    private func makePrediction() {
        let text = sentimentView.getText()
        let prediction = sentimentModel.predict(text)
        let score = prediction.prediction
        let confidenceLebel = prediction.confidenceLevel
        
        sentimentView.setText(score + ": \(confidenceLebel)")
    }
    
 
    
    
    
    
    
}
