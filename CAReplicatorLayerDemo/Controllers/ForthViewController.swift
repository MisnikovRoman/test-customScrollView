//
//  ForthViewController.swift
//  CAReplicatorLayerDemo
//
//  Created by Роман Мисников on 07/08/2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class ForthViewController: UIViewController {
    
    @IBOutlet weak var scrollTextView: ScrollTextView!
    @IBOutlet weak var speedSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func pause(_ layer: CALayer) {
        let pausedTime: CFTimeInterval? = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime ?? 0
    }
    
    func resumeLayer(_ layer: CALayer/*, withSpeed speed: Float*/) {
        let pausedTime: CFTimeInterval = layer.timeOffset
        layer.speed = speedSlider.value
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        var timeSincePause: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        timeSincePause /= Double(speedSlider.value)
        layer.beginTime = timeSincePause
    }

    
    @IBAction func startBtnTap(_ sender: UIButton) {
        guard let text = scrollTextView.textLayer else { print("⚠️ERROR!"); return }
        guard let animation = scrollTextView.scrollAnimation else { print("⚠️ERROR!"); return }
        
        text.add(animation, forKey: "position")
        
        //text.position = CGPoint(x: 0, y: -2000)
    }
    
    @IBAction func stopBtnTap(_ sender: UIButton) {
        guard let text = scrollTextView.textLayer else { print("⚠️ERROR!"); return }
        text.removeAnimation(forKey: "position")
    }
    
    @IBAction func pauseBtnTap(_ sender: UIButton) {
        guard let text = scrollTextView.textLayer else { print("⚠️ERROR!"); return }
        pause(text)
    }
    
    @IBAction func resumeBtnTap(_ sender: UIButton) {
        guard let text = scrollTextView.textLayer else { print("⚠️ERROR!"); return }
        resumeLayer(text)
    }
    
    @IBAction func speedSliderEdit(_ sender: Any) {
        guard let text = scrollTextView.textLayer else { print("⚠️ERROR!"); return }
        pause(text)
        resumeLayer(text)
        
     }
}
