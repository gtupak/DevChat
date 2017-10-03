//
//  CameraVC
//  DevChat
//
//  Created by Gabriel T on 2017-10-03.
//  Copyright © 2017 Gabriel T. All rights reserved.
//

import UIKit

class CameraVC: AAPLCameraViewController, AAPLCameraVCDelegate {
    @IBOutlet weak var previewView: AAPLPreviewView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var recordBtn: UIButton!
    
    override func viewDidLoad() {
        delegate = self
        _previewView = previewView
        super.viewDidLoad()
        
    }
    
    @IBAction func recordBtnPressed(_ sender: UIButton) {
        toggleMovieRecording()
    }
    
    @IBAction func changeCameraBtnPressed(_ sender: UIButton) {
        changeCamera()
    }
    
    func shouldEnableRecordUI(_ enable: Bool) {
        recordBtn.isEnabled = enable
        print("Should enable record UI: \(enable)")
    }
    
    func shouldEnableCameraUI(_ enable: Bool) {
        cameraBtn.isEnabled = enable
        print("Should enable camera UI: \(enable)")
    }
    
    func canStartRecording() {
        print("Can start recording")
    }
    
    func recordingHasStarted() {
        print("Recording has started")
    }
    
    func videoRecordingComplete(_ videoURL: URL!) {
        
    }
    
    func videoRecordingFailed() {
        
    }
    
    func snapshotTaken(_ snapshotData: Data!) {
        
    }
    
    func snapshotFailed() {
        
    }
    
}

