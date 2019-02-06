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
    
  var diceNodes: [SCNNode] = []
  
  var diceCount: Int = 5
  var diceStyle: Int = 0
  var diceOffset: [SCNVector3] = [SCNVector3(0.0,0.0,0.0),
                                SCNVector3(-0.05, 0.00, 0.0),
                                SCNVector3(0.05, 0.00, 0.0),
                                SCNVector3(-0.05, 0.05, 0.02),
                                SCNVector3(0.05, 0.05, 0.02)]
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
    diceStyle = diceStyle >= 4 ? 0 : diceStyle + 1
  }
  
  @IBAction func resetButtonPressed(_ sender: Any) {
  }
  
  @IBAction func swipeUpGestureHandler(_ sender: Any) {
    guard let frame = self.sceneView.session.currentFrame else { return }
    
    for count in 0..<diceCount {
        throwDiceNode(transform: SCNMatrix4(frame.camera.transform), offset: diceOffset[count])
    }
  }
    
    // MARK: - View Management
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initSceneView()
    initScene()
    initARSession()
    
    self.loadModels()
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
//        SCNDebugOptions.showFeaturePoints,
//        SCNDebugOptions.showWorldOrigin,
//        SCNDebugOptions.showBoundingBoxes,
//        SCNDebugOptions.showWireframe
    ]
  }
  
  func initScene() {
//    let scene = SCNScene(named: "PokerDice.scnassets/SimpleScene.scn")!
    let scene  = SCNScene()
    scene.isPaused = false
    sceneView.scene = scene
    
    // Loading the environment map
    scene.lightingEnvironment.contents = "PokerDice.scnassets/Textures/Environment_CUBE.jpg"
    scene.lightingEnvironment.intensity = 2
    
    
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
  
  // MARK: - load models
    func loadModels() {
        let diceScene = SCNScene(named: "PokerDice.scnassets/Models/DiceScene.scn")!
        for count in 0..<5 {
            diceNodes.append(diceScene.rootNode.childNode(withName: "dice\(count)", recursively: false)!)
        }
    }
    
    // MARK: - Helper Functions
    func throwDiceNode(transform: SCNMatrix4, offset: SCNVector3) {
        let position = SCNVector3(transform.m41 + offset.x, transform.m42 + offset.y, transform.m43 + offset.z)
        
        let diceNode = diceNodes[diceStyle].clone()
        diceNode.name = "dice"
        diceNode.position = position
        
        sceneView.scene.rootNode.addChildNode(diceNode)
//        diceCount -= 1
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

