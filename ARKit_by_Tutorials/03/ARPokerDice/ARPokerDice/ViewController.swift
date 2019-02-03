//
//  AppDelegate.swift
//  ARPokerDice
//
//  Created by [Andy Ron](https://github.com/andyRon) on 2019/2/3.
//  Copyright © 2019 Andy Ron. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {
  
  // MARK: - Properties
  var trackingStatus = ""
  // MARK: - Outlets
  
  @IBOutlet var sceneView: ARSCNView!
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var startButton: UIButton!
  @IBOutlet weak var styleButton: UIButton!
  @IBOutlet weak var resetButton: UIButton!
  
  // MARK: - Actions
  
  @IBAction func startButtonPressed(_ sender: Any) {
  }
  
  @IBAction func styleButtonPressed(_ sender: Any) {
  }
  
  @IBAction func resetButtonPressed(_ sender: Any) {
  }
  
  // MARK: - View Management
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initSceneView()
    initScene()
    initARSession()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("*** ViewWillAppear()")
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    print("*** ViewWillDisappear()")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    print("*** DidReceiveMemoryWarning()")
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  // MARK: - Initialization
  
  func initSceneView() {
    sceneView.delegate = self
    sceneView.showsStatistics = true
    
    // 调式选型
    sceneView.debugOptions = [
        SCNDebugOptions.showFeaturePoints,
        SCNDebugOptions.showWorldOrigin,
        SCNDebugOptions.showBoundingBoxes,
        SCNDebugOptions.showWireframe
    ]
  }
  
  func initScene() {
    let scene = SCNScene(named: "PokerDice.scnassets/SimpleScene.scn")!
    scene.isPaused = false
    sceneView.scene = scene
  }
  
  func initARSession() {
    // 检测设备是否支持 6DOF
    guard ARWorldTrackingConfiguration.isSupported else {
        print("*** ARConfig: AR World Tracking Not Supported")
        return
    }
    
    let config = ARWorldTrackingConfiguration()
    config.worldAlignment = .gravity
    config.providesAudioData = false
    
    // 运行session
    sceneView.session.run(config)
  }
}

extension ViewController : ARSCNViewDelegate {
  
  // MARK: - SceneKit Management
  func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
    DispatchQueue.main.async {
        self.statusLabel.text = self.trackingStatus
    }
  }
  
  // MARK: - Session State Management
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState {
        case .notAvailable:
            trackingStatus = "Tracking: Not Available!"
        case .normal:
            trackingStatus = "Tracking: All Good"
        case .limited(let reason):
            switch reason {
            case .excessiveMotion:
                trackingStatus = "Tracking: Limited due to excessive motion!"
            case .insufficientFeatures:
                trackingStatus = "Tracking: Limited duo to insufficient features!"
            case .initializing:
                trackingStatus = "Tracking: Initializing..."
            case .relocalizing:
                trackingStatus = "Tracking: Relocalizing..."
            }
        }
    }
  
  // MARK: - Session Error Managent
  func session(_ session: ARSession, didFailWithError error: Error) {
    trackingStatus = "AR Session Failure: \(error)"
  }
  
    func sessionWasInterrupted(_ session: ARSession) {
         trackingStatus = "AR Session Was Interrupted"
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        trackingStatus = "AR Session Interrupted Ended"
    }
  // MARK: - Plane Management
  
}

