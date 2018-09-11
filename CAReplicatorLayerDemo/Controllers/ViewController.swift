//
//  ViewController.swift
//  CAReplicatorLayerDemo
//
//  Created by Роман Мисников on 03/08/2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var replicatorLayer: CAReplicatorLayer!
    var sourceLayer: CALayer!
    
    var testLayer: CALayer!
    
    @IBOutlet weak var redView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        replicatorLayer = CAReplicatorLayer()
        sourceLayer = CALayer()
        
        self.view.layer.addSublayer(replicatorLayer)
        replicatorLayer.addSublayer(sourceLayer)
        
        testLayer = CALayer()
        redView.layer.addSublayer(testLayer)
        
        startAnimation(delay: 0.1, replicates: 14)
    }

    override func viewWillLayoutSubviews() {
        replicatorLayer.frame = self.view.bounds
        replicatorLayer.position = self.view.center
        
        sourceLayer.frame = CGRect(x: 0, y: 0, width: 2, height: 10)
        sourceLayer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        sourceLayer.position = self.view.center
        sourceLayer.anchorPoint = CGPoint(x: 0.0, y: 4.0)
        
        testLayer.frame = CGRect(x: 0, y: 0, width: 25, height: 50)
        testLayer.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor
        testLayer.position = self.view.center
        testLayer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        
    }
    func startAnimation(delay: TimeInterval, replicates: Int) {
        
        replicatorLayer.instanceCount = replicates
        // угол смещения в единицу времени
        let angle = CGFloat(2.0 * .pi) / CGFloat(replicates)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        
        replicatorLayer.instanceDelay = delay
        
        sourceLayer.opacity = 0
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        opacityAnimation.duration = Double(replicates) * delay / 2
        opacityAnimation.repeatCount = Float.infinity
        
        sourceLayer.add(opacityAnimation, forKey: nil)
        
        
        let secondAngle = CGFloat(2.0 * .pi) / 60
        testLayer.transform = CATransform3DMakeRotation(secondAngle, 1, 1, 0)
        
    }
}

