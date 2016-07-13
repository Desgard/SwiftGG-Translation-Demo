//
//  ViewController.swift
//
//
//  Created by 段昊宇 on 16/6/20.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
class ViewController: UIViewController {
    // 记录拖动时的圆形视图center
    var circleCenter: CGPoint!
    // 我们将在拖拽响应事件上附加不同的动画
    var circleAnimator: UIViewPropertyAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 添加一个可拖动视图
        let circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
        circle.center = self.view.center
        circle.layer.cornerRadius = 50.0
        circle.backgroundColor = UIColor.green()
        
        circleAnimator = UIViewPropertyAnimator(duration: 1.0, curve: .linear, animations: {
            circle.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
        })
        
        circleAnimator?.addAnimations({
            circle.backgroundColor = UIColor.blue()
        }, delayFactor: 0.75)
        
        // 添加拖动手势
        circle.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.dragCircle)))
        
        self.view.addSubview(circle)
    }
    
    func dragCircle(gesture: UIPanGestureRecognizer) {
        let target = gesture.view!
        
        switch gesture.state {
        case .began:
            circleCenter = target.center
        case .changed:
            let translation = gesture.translation(in: self.view)
            target.center = CGPoint(x: circleCenter!.x + translation.x, y: circleCenter!.y + translation.y)
            
            circleAnimator?.fractionComplete = target.center.y / self.view.frame.height
        default: break
        }
    }
}
