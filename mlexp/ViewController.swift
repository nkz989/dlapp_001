//
//  ViewController.swift
//  mlexp
//
//  Created by Yamin Wei on 12/25/18.
//  Copyright © 2018 Yamin Wei. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: BaseViewController, AVCapturePhotoCaptureDelegate {
    
    
    let captureSession = AVCaptureSession()
    var output: AVCapturePhotoOutput?
    var selectedImage = UIImage()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSession()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    /*
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }*/
    
    
    
    
    
    // 这个可以移到resultview里去
    /*
    @IBAction func actionClassLabelTap(_ sender: UITapGestureRecognizer) {
        guard let label = sender.view as? UILabel, let classString = label.text else {
            return
        }
        
        guard let url = URL(string: "https://en.wikipedia.org/wiki/\(classString)") else {
            return
        }
        
        if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }*/
    
    // 这部分用来处理拍照并传递图片到result中去做prediction ====================================
    @IBAction func takePhoto(_ sender: Any) {
        
        guard let capturePhotoOutput = self.output else { return }
        
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        capturePhotoOutput.capturePhoto(with: settings, delegate: self)
        
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        selectedImage = UIImage(data: imageData)!
        UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil)
        self.performSegue(withIdentifier: "baseToResultSegue", sender: self)
    }
    
    func setupSession() {
        self.view.layoutIfNeeded()
        
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        output = AVCapturePhotoOutput()
        
        if captureSession.canAddInput(input) && captureSession.canAddOutput(output!) {
            captureSession.addInput(input)
            captureSession.addOutput(output!)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.frame = view.frame
        previewLayer.borderColor = UIColor.black.cgColor
        view.layer.insertSublayer(previewLayer, at: 0)
        
        captureSession.startRunning()
    }
    
    // 这部分用来处理在相册里选择相片 ==========================================================
    @IBAction func choosePhotos() {
        self.presentPhotoPicker(sourceType: .photoLibrary)
    }
    
    func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true)
    }
    
    // 因为计算predict需要较长的时间，所以我觉得当选择照片或拍了照片之后，将照片传到resultView再进行计算
    // 这部分用来处理将predict的结果传递到ResultViewController ================================
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "baseToResultSegue"){
            let resultVC = segue.destination as! ResultViewController
            resultVC.image = selectedImage
        }
    }
}

// Jun ============
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - Handling Image Picker Selection 当选择完照片后执行的操作。
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        picker.dismiss(animated: true)
        
        selectedImage = (info[.originalImage] as? UIImage)!
        self.performSegue(withIdentifier: "baseToResultSegue", sender: self)
    }
}

