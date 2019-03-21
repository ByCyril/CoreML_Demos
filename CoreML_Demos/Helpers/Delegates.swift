//
//  Delegates.swift
//  Object_Detection_iOS
//
//  Created by Cyril Garcia on 3/21/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

protocol ImageRecognitionDelegate {
    func getResults(_ label: String, _ confidenceLevel: Double)
}

protocol ObjectDetectionDelegate {
    func getResults(_ label: String, _ confidenceLevel: Double, _ box: CGRect)
}
