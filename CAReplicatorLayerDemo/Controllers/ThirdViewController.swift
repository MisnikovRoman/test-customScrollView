//
//  ThirdViewController.swift
//  CAReplicatorLayerDemo
//
//  Created by Роман Мисников on 04/08/2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    let customTextView: UIView = {
        // initial parameters
        let width: CGFloat = 200
        let height: CGFloat = 100
        // create view
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        view.frame = CGRect(x: 50,y: 200, width: width, height: height)
        // 1st layer
        let squareLayer = CALayer()
        squareLayer.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        squareLayer.anchorPoint = CGPoint(x: 0, y: 0)
        squareLayer.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor
        view.layer.addSublayer(squareLayer)
        // 2nd layer
        let textLayer = CATextLayer()
        textLayer.frame = view.bounds
        textLayer.string = "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
        textLayer.isWrapped = true // fit to bounds
        view.layer.addSublayer(textLayer)
        // 1st layer animation
        let squareMoveAnimation = CABasicAnimation(keyPath: "position")
        squareMoveAnimation.fromValue = [0, 0]
        squareMoveAnimation.toValue = [view.frame.width-squareLayer.frame.width, 0]
        squareMoveAnimation.duration = 1
        squareMoveAnimation.repeatCount = 5
        squareLayer.add(squareMoveAnimation, forKey: "position")
        // 3rd layer - shape
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = view.bounds
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: width, y: height))
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 20.0
        //shapeLayer.lineCap = CAShapeLayerLineCap(rawValue: "round")
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.fillColor = nil
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 1
        shapeLayer.strokeColor = UIColor.blue.cgColor
        view.layer.addSublayer(shapeLayer)
        // return customized view
        return view
    }()
    
    var counter: Int = 0
    
    @IBOutlet weak var testView: MessageBubbleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(customTextView)
        
        customTextView.translatesAutoresizingMaskIntoConstraints = false
        customTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        customTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        customTextView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        customTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        customTextView.addGestureRecognizer(tap)
    }
    
    @objc func tapped() {
        print("👇🏻")
        counter += 1
    }
    
}
