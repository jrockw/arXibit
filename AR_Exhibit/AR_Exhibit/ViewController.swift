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
    }
    
    // MARK: Setup Methods This is what I can't get to work for ze life of me. it doesnt know what automatically configure session is.
    
    func setupARView () {
        arView.automaticallyConfigureSession = false
        let configuration = ARWorldTrackingConfiguration
    }
}
