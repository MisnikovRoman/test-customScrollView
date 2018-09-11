//
//  CustomScrollView.swift
//  CAReplicatorLayerDemo
//
//  Created by Роман Мисников on 09/08/2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

/*
 Управление объектом осуществляется с помощью следующих переменных и функций:
    setText(to: ... ) - задать текст для прокрутки
    scrollingSpeed: Float - задать относительную скорость прокрутки (0...1)
    startAnimation() - начать анимацию прокрутки
    stopAnimation() - удалить анимацию и вернуться в начальное положение (перед анимацией)
    pauseAnimation() - поставить анимацию на паузу и сохранить позицию
 resumeAnimation() - продолжить анимацию после паузы
 */

@IBDesignable
class CustomScrollView: UIView {
    
    // MARK: - Variables
    // external control of scrolling speed
    var scrollingSpeed: Float = 1.0
    var textHeight: CGFloat {
        return calculateTextHeight(text: attributedText, width: frame.width)
    }
    // maximum scrolling speed
    public var scrollingAnimationDuration: Double {
        let result = Double(textHeight / 100)
        // set minimum to 1
        return result >= 1 ? result : 1
    }
    private var attributedText: NSAttributedString!
    private var textLayer: CATextLayer = {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
        textLayer.isWrapped = true // fit to bounds
        textLayer.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 0.5).cgColor
        textLayer.anchorPoint = CGPoint(x: 0, y: 0)
        textLayer.position = CGPoint(x: 0, y: 0)
        textLayer.contentsScale = UIScreen.main.scale
        return textLayer
        
    }()
    private var maskLayer: CALayer = {
        let mask = CALayer()
        mask.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        return mask
    }()
    private var scrollAnimation: CABasicAnimation = {
        let scroll = CABasicAnimation(keyPath: "position")
        scroll.fromValue = [0, 0]
        scroll.toValue = [0, 0]
        scroll.duration = 15
        scroll.repeatCount = 1 //Float.infinity
        scroll.autoreverses = false
        return scroll
    }()
    
    // MARK: - UIView methods
    // initialization of view
    override init(frame: CGRect) {
        super.init(frame: frame)
        initText()
        addLayers()
    }
    
    // required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // redraw something
    override func draw(_ rect: CGRect) {
        addLayers()
        setupLayer()
        // calculate new frames for sublayers
        maskLayer.frame = rect
        textLayer.frame = CGRect(x: 0, y: 0, width: rect.width, height: textHeight)
    }
    
    // MARK: - Custom methods
    private func setupLayer() {
        textLayer.string = attributedText
    }
    
    private func createAttributedText(from text: String) -> NSAttributedString {
        let titleFont = UIFont.systemFont(ofSize: 30.0, weight: .medium)
        let attributes: [NSAttributedStringKey : Any] = [
            NSAttributedStringKey.font : titleFont,
            NSAttributedStringKey.foregroundColor : UIColor.white
        ]
        let attributedText = NSAttributedString(string: text, attributes: attributes)
        return attributedText
    }
    
    private func initText() {
        attributedText = createAttributedText(from: "Уважаемый Сергей Семёнович! До моего сведения дошла информация о ликвидации в Москве троллейбусной системы в 2019 году. Это большая ошибка. Современные города отказываются от дизельного транспорта в пользу электробусов. Те города, которым повезло сохранить троллейбусные системы, развивают электробус намного быстрее, чем те, которым приходится строить всё с нуля. Сохранившаяся московская троллейбусная система позволяет уже завтра заменить 2000 московских дизельных автобусов на современные электробусы с динамической подзарядкой. Такие, которые часть маршрута (по магистралям и в спальных районах) идут под проводами и заряжаются, а другую часть (по центру или где проводов нет) – на автономном ходу.")
        }
    
    public func setText(to text: String) {
        attributedText = createAttributedText(from: text)
        setupLayer()
    }
    
    private func addLayers() {
        self.layer.mask = maskLayer
        self.layer.addSublayer(textLayer)
    }
    
    private func calculateTextHeight(text: NSAttributedString, width: CGFloat) -> CGFloat {
        let startSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let frame = text.boundingRect(with: startSize, options: .usesLineFragmentOrigin, context: nil)
        return ceil(frame.height)
    }
    
    // MARK: - Control animation
    func startAnimation(from startPoint: CGPoint) {
        scrollAnimation.fromValue = [startPoint.x, startPoint.y]
        scrollAnimation.toValue = [startPoint.x, -textHeight]
        scrollAnimation.duration = scrollingAnimationDuration
        print("⏱ Current scroll duration = \(scrollingAnimationDuration)")
        textLayer.add(scrollAnimation, forKey: "position")
    }
    
    func stopAnimation() {
        textLayer.removeAllAnimations()
        textLayer.speed = scrollingSpeed
    }
    
    func pauseAnimation() {
        let pausedTime: CFTimeInterval = textLayer.convertTime(CACurrentMediaTime(), from: nil)
        textLayer.speed = 0.0
        textLayer.timeOffset = pausedTime
    }
    
    func resumeAnimation() {
        let pausedTime: CFTimeInterval = textLayer.timeOffset
        textLayer.speed = scrollingSpeed
        textLayer.timeOffset = 0.0
        textLayer.beginTime = 0.0
        var timeSincePause: CFTimeInterval = textLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        timeSincePause /= Double(scrollingSpeed)
        textLayer.beginTime = timeSincePause
    }
    
    func resumeWithNewSpeed(_ speed: Float) {
        let pausedTime: CFTimeInterval = textLayer.timeOffset
        textLayer.speed = speed
        textLayer.timeOffset = 0.0
        textLayer.beginTime = 0.0
        var timeSincePause: CFTimeInterval = textLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        timeSincePause /= Double(scrollingSpeed)
        textLayer.beginTime = timeSincePause
    }
    
    

}
