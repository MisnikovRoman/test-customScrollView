//
//  TestViewController.swift
//  CAReplicatorLayerDemo
//
//  Created by Роман Мисников on 04/08/2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    
    
    var timer: Timer!
    
    var layer: CALayer!
    
    var layerAngleRadian: CGFloat = 0
    var layerAngleDegree: CGFloat {
        get { return layerAngleRadian / (2 * CGFloat.pi) * 360 }
        set { layerAngleRadian = newValue / 360 * 2 * CGFloat.pi }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFire), userInfo: nil, repeats: true)
        
        createLayer()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupLayer()
    }
    
    deinit {
        timer.invalidate()
    }
    
    func setupLayer() {
        // setup after screen rotation
        layer.position = view.center
    }
    
    func createLayer() {
        // create layer
        layer = {
            let layer = CALayer()
            
            // 1 - frame
            let frame = CGRect(x: 0, y: 0, width: 25, height: 100)
            layer.frame = frame
            // 2 - setup parameters
            layer.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
            // point relative to which center is calculated
            layer.anchorPoint = CGPoint(x: 0.5, y: 1)
            
            
            
            return layer
        }()
        // add to view.layer
        view.layer.addSublayer(layer)
    }
    
    func rotateLayer(toAngle angle: CGFloat) {
        layerAngleRadian += angle
        layer.transform = CATransform3DMakeRotation(layerAngleRadian, 0, 0, 1)
        print("Layer angle is \(layerAngleDegree)° ")
    }

    @IBAction func rotateBtnTap(_ sender: Any) {
        
        rotateLayer(toAngle: 2 * CGFloat.pi / 2)
    }
    
    @objc func timerFire() { print("⏱ \(Thread.current)") }
}
