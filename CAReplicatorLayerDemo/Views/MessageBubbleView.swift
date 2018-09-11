//
//  CustomView.swift
//  CAReplicatorLayerDemo
//
//  Created by Роман Мисников on 05/08/2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

@IBDesignable
class MessageBubbleView: UIView {
    
    @IBInspectable public var isLeft: Bool = true
    @IBInspectable public var cornerRadius: CGFloat = 10
    @IBInspectable public var calloutHeight: CGFloat = 30
    @IBInspectable public var calloutWidth: CGFloat = 10
    @IBInspectable public var leftOffset: CGFloat = 8
    
    private var bubbleLayer: CAShapeLayer!
    
    override func draw(_ rect: CGRect) {
        createShapes(rect)
        setupShapes(rect)
    }

    // create initiated shapes
    func createShapes(_ rect: CGRect) {
        // message bubble
        bubbleLayer = {
            // создаем слой с собственной кривой
            let shapeLayer = CAShapeLayer()
            shapeLayer.lineWidth = 1
            // заливка замкнутой фигуры
            //shapeLayer.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            // цвет линии
            shapeLayer.strokeColor = #colorLiteral(red: 0.6738816862, green: 0.6738816862, blue: 0.6738816862, alpha: 1).cgColor
            // скругление углов фигуры
            // shapeLayer.lineJoin = CAShapeLayerLineJoin.round
            shapeLayer.lineJoin = kCALineJoinRound
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: leftOffset, y: cornerRadius))
            path.addArc(withCenter: CGPoint(x: leftOffset + cornerRadius,
                                            y: cornerRadius),
                        radius: cornerRadius,
                        startAngle: CGFloat.pi,
                        endAngle: CGFloat.pi * 3/2,
                        clockwise: true)
            path.addArc(withCenter: CGPoint(x: rect.width - cornerRadius,
                                            y: cornerRadius),
                        radius: cornerRadius,
                        startAngle: CGFloat.pi * 3/2,
                        endAngle: 2 * CGFloat.pi,
                        clockwise: true)
            path.addArc(withCenter: CGPoint(x: rect.width - cornerRadius,
                                            y: rect.height - cornerRadius),
                        radius: cornerRadius,
                        startAngle: 0,
                        endAngle: CGFloat.pi / 2,
                        clockwise: true)
            path.addArc(withCenter: CGPoint(x: leftOffset + cornerRadius,
                                            y: rect.height - cornerRadius),
                        radius: cornerRadius,
                        startAngle: CGFloat.pi / 2,
                        endAngle: CGFloat.pi,
                        clockwise: true)
            path.addLine(to: CGPoint(x: leftOffset,
                                     y: rect.height - calloutHeight + calloutWidth / 2))
            path.addLine(to: CGPoint(x: 0,
                                     y: rect.height - calloutHeight))
            path.addLine(to: CGPoint(x: leftOffset,
                                     y: rect.height - calloutHeight - calloutWidth / 2))
            path.addLine(to: CGPoint(x: leftOffset,
                                     y: cornerRadius))
            
            
            shapeLayer.path = path.cgPath
            
            shapeLayer.shadowPath = path.cgPath
            shapeLayer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            shapeLayer.shadowOffset = CGSize(width: 2, height: 2)
            shapeLayer.shadowRadius = 4
            shapeLayer.shadowOpacity = 0.4
            
            return shapeLayer
        }()
        //self.layer.addSublayer(bubbleLayer)
        self.layer.mask = bubbleLayer
        
    }
    
    func setupShapes(_ rect: CGRect) {
        bubbleLayer.frame = rect
    }
}
