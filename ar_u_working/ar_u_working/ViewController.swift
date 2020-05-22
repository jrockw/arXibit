//
//  ViewController.swift
//  ar_u_working
import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        arView.session.delegate = self
        
        setupARView()

         arView.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(handleTap(recognizer:))))
        
        
    }
    
   
    
    // MARK: Setup Methods
    
    func setupARView () {
        arView.automaticallyConfigureSession = false
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        configuration.environmentTexturing = .automatic
        arView.session.run(configuration)
    }
    
    // MARK: Object Placement
    
    @objc
    func handleTap(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: arView)
        
        let results = arView.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
        
        if let firstResult = results.first {
            // I think this is where he's specifying the input 3D image
            let anchor = ARAnchor(name: "Test3", transform: firstResult.worldTransform)
            arView.session.add(anchor: anchor)
        } else {
            print("ERROR: Object placement failed to find surface.")
        }
    }
    func placeObject(named entityname: String, for anchor: ARAnchor) {
        let entity = try! ModelEntity.loadModel(named: entityname)
        
        entity.generateCollisionShapes(recursive: true)
        arView.installGestures([.rotation, .translation], for: entity)
        
        let anchorEntity = AnchorEntity(anchor: anchor)
        anchorEntity.addChild(entity)
        arView.scene.addAnchor(anchorEntity)
    }
}

extension ViewController: ARSessionDelegate {
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let anchorName = anchor.name, anchorName == "Test3" {
                placeObject(named: anchorName, for: anchor)
            }
        }
    }
}
