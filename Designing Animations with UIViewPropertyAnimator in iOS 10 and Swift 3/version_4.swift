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
        
        // 添加拖动手势
        circle.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.dragCircle)))
        
        self.view.addSubview(circle)
    }
    
    func dragCircle(gesture: UIPanGestureRecognizer) {
        let target = gesture.view!
        
        switch gesture.state {
        case .began:
            if circleAnimator != nil && circleAnimator!.isRunning {
                circleAnimator!.stopAnimation(false)
            }
            circleCenter = target.center
        case .changed:
            let translation = gesture.translation(in: self.view)
            target.center = CGPoint(x: circleCenter!.x + translation.x, y: circleCenter!.y + translation.y)
        case .ended:
            let v = gesture.velocity(in: target)
            // 500这个随机值看起来比较合适，你可能会觉得这个值是基于设备屏幕尺寸的
            // 在y轴上的速度分量通常被忽略，当对于视图的center为动画主体时会使用
            let velocity = CGVector(dx: v.x / 500, dy: v.y / 500)
            let springParameters = UISpringTimingParameters(mass: 2.5, stiffness: 70, damping: 55, initialVelocity: velocity)
            circleAnimator = UIViewPropertyAnimator(duration: 0.0, timingParameters: springParameters)
            
            circleAnimator!.addAnimations({
                target.center = self.view.center
            })
            circleAnimator!.startAnimation()
        default: break
        }
    }
}
