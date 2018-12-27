//
//  ViewController.swift
//  mlexp
//
//  Created by Yamin Wei on 12/25/18.
//  Copyright © 2018 Yamin Wei. All rights reserved.
//

import UIKit
import AVKit
import Vision

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    // IBOutlets
    @IBOutlet weak var classLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        let captureOutput = AVCaptureVideoDataOutput()
        captureOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(captureOutput)
        
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        view.layer.addSublayer(previewLayer)
        
        previewLayer.frame = view.frame
        
        captureSession.startRunning()
        
        
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        //print("haha", Date())
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else { return }
        
        
        let request = VNCoreMLRequest(model: model){ (finishedReq, err) in
            
            //perhaps check the err
            
            //print(finishedReq.results)
            
            guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
            
            guard let firstObservation = results.first else { return }
            
            DispatchQueue.main.async (
                execute: {self.classLabel.text = "\(firstObservation.identifier)"}
            )
            
            //print(firstObservation.identifier, firstObservation.confidence)
            
            self.classLabel.text = firstObservation.identifier
            
        }
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
 
 
    }
    


}

