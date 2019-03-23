//
//  SentimentAnalysisModel.swift
//  CoreML_Demos
//
//  Created by Cyril Garcia on 3/21/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit
import NaturalLanguage


class SentimentAnalysisModel {
    
    private var model: SentimentModel!
    
    init(_ model: SentimentModel) {
        self.model = model
    }
    
    private func wordCounts(text: String) -> [String: Double] {
        
        var bagOfWords: [String: Double] = [:]
        let tagger = NSLinguisticTagger(tagSchemes: [.tokenType], options: 0)
        let range = NSRange(text.startIndex..., in: text)
        let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace]
        
        tagger.string = text
        
        tagger.enumerateTags(in: range, unit: .word, scheme: .tokenType, options: options) { _, tokenRange, _ in
            let word = (text as NSString).substring(with: tokenRange)
            bagOfWords[word, default: 0] += 1
        }
        
        return bagOfWords
    }
    
    public func predict(_ text: String) -> (prediction: String, confidenceLevel: Double) {
        let bow = wordCounts(text: text)
        
        do {
            let prediction = try model.prediction(text: bow)
            let stars = prediction.stars
            
            if stars >= 4 {
                return ("Good", prediction.starsProbability[stars] ?? 0.0)
            } else if stars == 3 {
                return ("Alright", prediction.starsProbability[stars] ?? 0.0)
            } else if stars == 1 || stars == 2 {
                return ("Bad", prediction.starsProbability[stars] ?? 0.0)
            } else if stars == 0 {
                return ("Horrible", prediction.starsProbability[stars] ?? 0.0)
            }
        } catch {
            return ("nil", 0.0)
        }
        return ("nil", 0.0)

    }
    
}
