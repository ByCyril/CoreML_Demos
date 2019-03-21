//
//  ObjectDetectionController.swift
//  Object_Detection_iOS
//
//  Created by Cyril Garcia on 3/21/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class ObjectDetectionController: UIViewController {
    
    private var objectDetectionView: ObjectDetectionView!
    private var objectDetectionModel: ObjectDetectionModel!
    
    private let model = MyModel().model
    private let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController.delegate = self
        
        objectDetectionModel = ObjectDetectionModel(model)
        objectDetectionModel.delegate = self
        
        objectDetectionView = ObjectDetectionView(frame: view.frame)
        objectDetectionView.addButtonTarget(#selector(ObjectDetectionController.showImagePickerController), at: self)
        view.addSubview(objectDetectionView)
        
    }
    
    @objc
    private func showImagePickerController() {
        let imagePickerAlertView = UIAlertController(title: "Select Image Source", message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default) { (_) in
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
        
        let photoLibrary = UIAlertAction(title: "Photo Library", style: .default) { (_) in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        imagePickerAlertView.addAction(camera)
        imagePickerAlertView.addAction(photoLibrary)
        imagePickerAlertView.addAction(cancel)
        
        present(imagePickerAlertView, animated: true, completion: nil)
    }
    
    
}

extension ObjectDetectionController: ObjectDetectionDelegate {
    func getResults(_ label: String, _ confidenceLevel: Double, _ box: CGRect) {
        print(label, confidenceLevel, box)
        objectDetectionView.drawBox(box)
    }
}

extension ObjectDetectionController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else { return }
        
        objectDetectionModel.classify(image)
        objectDetectionView.setImage(image)
        
        dismiss(animated: true, completion: nil)
    }
}
