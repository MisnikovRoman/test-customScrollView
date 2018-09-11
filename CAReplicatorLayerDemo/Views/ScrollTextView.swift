//
//  ScrollTextView.swift
//  CAReplicatorLayerDemo
//
//  Created by Роман Мисников on 07/08/2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class ScrollTextView: UIView {
    
    var textLayer: CATextLayer!
    var scrollAnimation: CABasicAnimation!
    var maskLayer: CALayer!
    
    
    override func draw(_ rect: CGRect) {
        createLayers(rect)
        setupLayers(rect)
    }
 
    func createLayers(_ rect: CGRect) {
        textLayer = {
            let textLayer = CATextLayer()
            textLayer.frame = CGRect(origin: frame.origin, size: CGSize(width: rect.width, height: rect.height * 15))
            textLayer.string = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam eaque ipsa, quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt, explicabo. Nemo enim ipsam voluptatem, quia voluptas sit, aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos, qui ratione voluptatem sequi nesciunt, neque porro quisquam est, qui dolorem ipsum, quia dolor sit, amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit, qui in ea voluptate velit esse, quam nihil molestiae consequatur, vel illum, qui dolorem eum fugiat, quo voluptas nulla pariatur? At vero eos et accusamus et iusto odio dignissimos ducimus, qui blanditiis praesentium voluptatum deleniti atque corrupti, quos dolores et quas molestias excepturi sint, obcaecati cupiditate non provident, similique sunt in culpa, qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio, cumque nihil impedit, quo minus id, quod maxime placeat, facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat."
            textLayer.isWrapped = true // fit to bounds
            textLayer.foregroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            textLayer.anchorPoint = CGPoint(x: 0, y: 0)
            textLayer.position = rect.origin
            
            return textLayer
        }()
        scrollAnimation = {
            // [layerName] animation of [animationKeyPath]
            let scroll = CABasicAnimation(keyPath: "position")
            scroll.fromValue = [0, 0]
            scroll.toValue = [0, -2000]
            scroll.duration = 15
            scroll.repeatCount = 1 //Float.infinity
            scroll.autoreverses = false
            
            return scroll
        }()
        
        maskLayer = {
            // create sublayer
            let mask = CALayer()
            mask.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
            mask.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
            return mask
        }()
     }
    
    func setupLayers(_ rect: CGRect) {
        self.layer.addSublayer(textLayer)
        self.layer.mask = maskLayer
    }
    
   
}
