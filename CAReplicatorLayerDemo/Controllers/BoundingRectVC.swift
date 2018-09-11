//
//  BoundingRectVC.swift
//  CAReplicatorLayerDemo
//
//  Created by Роман Мисников on 09/08/2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class BoundingRectVC: UIViewController {

    var attributedText: NSAttributedString = {
        let text = "Уважаемый Сергей Семёнович! До моего сведения дошла информация о ликвидации в Москве троллейбусной системы в 2019 году. Это большая ошибка. Современные города отказываются от дизельного транспорта в пользу электробусов. Те города, которым повезло сохранить троллейбусные системы, развивают электробус намного быстрее, чем те, которым приходится строить всё с нуля. Сохранившаяся московская троллейбусная система позволяет уже завтра заменить 2000 московских дизельных автобусов на современные электробусы с динамической подзарядкой. Такие, которые часть маршрута (по магистралям и в спальных районах) идут под проводами и заряжаются, а другую часть (по центру или где проводов нет) – на автономном ходу."
        let titleFont = UIFont.systemFont(ofSize: 30.0, weight: .medium)
        let attributes: [NSAttributedStringKey : Any] = [
            NSAttributedStringKey.font : titleFont,
            NSAttributedStringKey.foregroundColor : UIColor.white
        ]
        let attributedText = NSAttributedString(string: text, attributes: attributes)
        return attributedText
    }()
    var customScrollView = CustomScrollView()
    // create buttons
    var startBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Start", for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1)
        btn.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return btn
    }()
    var stopBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Stop", for: .normal)
        btn.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        btn.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return btn
    }()
    var pauseBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Pause", for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        btn.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return btn
    }()
    var resumeBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Resume", for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        btn.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return btn
    }()
    // create stack view
    var btnStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 8
        return stack
    }()
    // create slider
    var slider: UISlider = {
        let slider = UISlider()
        slider.setValue(1, animated: false)
        slider.tintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
    }
    
    func setupScrollView() {
        
        // add UI elements
        view.addSubview(customScrollView)
        view.addSubview(btnStackView)
        view.addSubview(slider)
        
        // add btns to stack view
        btnStackView.addArrangedSubview(startBtn)
        btnStackView.addArrangedSubview(resumeBtn)
        btnStackView.addArrangedSubview(pauseBtn)
        btnStackView.addArrangedSubview(stopBtn)
        
        // setup slider
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
        // setup custom scroll view
        customScrollView.translatesAutoresizingMaskIntoConstraints = false
        customScrollView.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 16).isActive = true
        customScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        customScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        customScrollView.bottomAnchor.constraint(equalTo: btnStackView.topAnchor, constant: -8).isActive = true
        customScrollView.setText(to: SAMPLE_TEXT)
        
        // setup stack view
        btnStackView.translatesAutoresizingMaskIntoConstraints = false
        btnStackView.leadingAnchor.constraint(equalTo: customScrollView.leadingAnchor).isActive = true
        btnStackView.trailingAnchor.constraint(equalTo: customScrollView.trailingAnchor).isActive = true
        btnStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        
        // add tap handlers to buttons
        startBtn.addTarget(self, action: #selector(startBtnTap(_:)), for: .touchUpInside)
        stopBtn.addTarget(self, action: #selector(stopBtnTap(_:)), for: .touchUpInside)
        pauseBtn.addTarget(self, action: #selector(pauseBtnTap(_:)), for: .touchUpInside)
        resumeBtn.addTarget(self, action: #selector(resumeBtnTap(_:)), for: .touchUpInside)
    }
    
    @objc func startBtnTap(_ sender: UIButton) {
        customScrollView.startAnimation(from: CGPoint(x: 0, y: 0))
    }
    @objc func stopBtnTap(_ sender: UIButton) {
        customScrollView.stopAnimation()
    }
    @objc func resumeBtnTap(_ sender: UIButton) {
        //customScrollView.resumeAnimation()
        let scrollingSpeed = slider.value
        customScrollView.resumeWithNewSpeed(scrollingSpeed)
    }
    @objc func pauseBtnTap(_ sender: UIButton) {
        customScrollView.pauseAnimation()
    }
}
