//
//  ResultViewController.swift
//  mlexp
//
//  Created by zxj on 2019/1/10.
//  Copyright © 2019 Yamin Wei. All rights reserved.
//

import UIKit
import Vision

class ResultViewController: BaseViewController{
    
    let model = try? VNCoreMLModel(for: Inceptionv3().model)
    
    var image = UIImage()
    
    @IBOutlet weak var predictClass: UILabel!
    @IBOutlet weak var imageUi: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageUi.image = image
        updateClassifications(for: image)
        
        /*
        if classifications.isEmpty {
            self.predictClass.text = "Nothing recognized."
        } else {
            guard let firstObservation = classifications.first else { return }
            self.predictClass.text = "Classification: " + firstObservation.identifier
        }*/
        
    }
    
    @IBAction func actionGoBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // 这个request包含两个主要的东西，一个是model，一个是执行model的方法processClassifications
    /// - Tag: MLModelSetup
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            
            let request = VNCoreMLRequest(model: model!, completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    // 当picker dismiss之后，会执行这个func，它将UIImage转换成model用的CGImage，通过request handler执行classificationRequest
    /// - Tag: PerformRequests
    func updateClassifications(for image: UIImage) {
        predictClass.text = "Classifying..."
        
        let orientation = CGImagePropertyOrientation(image.imageOrientation)
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                /*
                 This handler catches general image processing errors. The `classificationRequest`'s
                 completion handler `processClassifications(_:error:)` catches errors specific
                 to processing that request.
                 */
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }
    
    /// Updates the UI with the results of the classification.
    /// - Tag: ProcessClassifications
    func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let results = request.results else {
                print("Unable to classify image.")
                return
            }
            // The `results` will always be `VNClassificationObservation`s, as specified by the Core ML model in this project.
            let classifications = results as! [VNClassificationObservation]
            if classifications.isEmpty {
                self.predictClass.text = "Nothing recognized."
            } else {
                guard let firstObservation = classifications.first else { return }
                self.predictClass.text = "Classification: " + firstObservation.identifier
            }
        }
    }
    
}
