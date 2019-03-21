//
//  ImageRecognitionController.swift
//  Object_Detection_iOS
//
//  Created by Cyril Garcia on 3/21/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class ImageRecognitionController: UIViewController {
    
    private var imageRecognitionView: ImageRecognitionView!
    private var imageRecognitionModel: ImageRecognitionModel!
    
    private let model = PetsModel().model
    
    private let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController.delegate = self
        
        imageRecognitionModel = ImageRecognitionModel(model)
        imageRecognitionModel.delegate = self
        
        imageRecognitionView = ImageRecognitionView(frame: self.view.frame)
        imageRecognitionView.addButtonTarget(#selector(ImageRecognitionController.showImagePickerController), at: self)
        view.addSubview(imageRecognitionView)
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

extension ImageRecognitionController: ImageRecognitionDelegate {
    func getResults(_ label: String, _ confidenceLevel: Double) {
        imageRecognitionView.setLabel(label + ": \(confidenceLevel)")
    }
}

extension ImageRecognitionController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else { return }
        imageRecognitionView.setImage(image)
        imageRecognitionModel.classify(image: image)
        dismiss(animated: true, completion: nil)
    }
}
