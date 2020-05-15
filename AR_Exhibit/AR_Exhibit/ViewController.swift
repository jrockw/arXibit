//
//  ViewController.swift
//  ARexhibit2
//
//  Created by Seth Allen on 5/15/20.
//  Copyright © 2020 Seth Allen. All rights reserved.
//

import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
   
        setupARView()
        
         arView.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(handleTap(recognizer:))))
        
        
    }
    
   
    
    // MARK: Setup Methods This is what I can't get to work for ze life of me. it doesnt know what automatically configure session is.
    
    func setupARView () {
        arView.automaticallyConfigureSession = false
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        configuration.environmentTexturing = .automatic
        arView.session.run(configuration)
    }
    @objc
    func handleTap(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: arView)
        
        let results = arView.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
        
        if let firstResult = results.first {
            // I think this is where he's specifying the input 3D image
            let anchor = ARAnchor(name: "ContemporaryFan", transform: firstResult.worldTransform)
            arView.session.add(anchor: anchor)
        } else {
            print("ERROR: Object placement failed to find surface.")
        }
    }
}
