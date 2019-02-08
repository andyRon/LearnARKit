//
//  AppDelegate.swift
//  ARPokerDice
//
//  Created by [Andy Ron](https://github.com/andyRon) on 2019/2/7.
//  Copyright © 2019 Andy Ron. All rights reserved.
//

import UIKit
import ARKit

class PortalViewController: UIViewController {

  @IBOutlet var sceneView: ARSCNView?
  @IBOutlet weak var messageLabel: UILabel?
  @IBOutlet weak var sessionStateLabel: UILabel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    resetLabels()
    runSession()
  }
  
  func resetLabels() {
    messageLabel?.alpha = 1.0
    messageLabel?.text = "Move the phone around and allow the app to find a plane." + "You will see a yellow horizontal plane."
    sessionStateLabel?.alpha = 0.0
    sessionStateLabel?.text = ""
  }
  
  func runSession() {
    let configuration = ARWorldTrackingConfiguration()
    
    configuration.planeDetection = .horizontal
    
    configuration.isLightEstimationEnabled = true
    
    sceneView?.session.run(configuration)
    
    #if DEBUG
      sceneView?.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    #endif
    
    sceneView?.delegate = self
  }
}

extension PortalViewController: ARSCNViewDelegate {
  
  func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    
    DispatchQueue.main.async {
      
      if let planeAnchor = anchor as? ARPlaneAnchor {
        #if DEBUG
          let debugPlaneNode = createPlaneNode(center: planeAnchor.center, extent: planeAnchor.extent)
          node.addChildNode(debugPlaneNode)
        #endif
        self.messageLabel?.text = "Tap on the detected horizontal plane to place the portal"
      }
    }
  }
  
  func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
    
    DispatchQueue.main.async {
      if let planeAnchor = anchor as? ARPlaneAnchor, node.childNodes.count > 0 {
        updatePlaneNode(node.childNodes[0], center: planeAnchor.center, extent: planeAnchor.extent)
      }
    }
  }
}
