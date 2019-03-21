//
//  ObjectDetectionModel.swift
//  Object_Detection_iOS
//
//  Created by Cyril Garcia on 3/21/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit
import Vision

class ObjectDetectionModel {
    
    private var vnCoreMLModel: VNCoreMLModel!
    
    public var delegate: ObjectDetectionDelegate!
    
    init(_ model: MLModel) {
        do {
            vnCoreMLModel = try VNCoreMLModel(for: model)
        } catch {
            fatalError("Cant find model")
        }
    }
    
    public func classify(_ image: UIImage) {
        
        guard let cgimage = image.cgImage else { return }
        guard let imagePixelBuffer = ImageProcessor.pixelBuffer(forImage: cgimage) else { return }
        
        let request = VNCoreMLRequest(model: vnCoreMLModel) { (results, error) in
            guard let observations = results.results as? [VNRecognizedObjectObservation] else { return }
            guard let firstObservations = observations.first else { return }
            guard let identifiedImage = firstObservations.labels.first else { return }
            
            let label = identifiedImage.identifier
            let box = firstObservations.boundingBox
            let confidenceLevel = Double(identifiedImage.confidence)
            
            DispatchQueue.main.async {
                self.delegate.getResults(label, confidenceLevel, box)
            }
            
        }
        
        do {
            try VNImageRequestHandler(cvPixelBuffer: imagePixelBuffer, options: [:]).perform([request])
        } catch {
            fatalError("Fatal error")
        }
    }
}
