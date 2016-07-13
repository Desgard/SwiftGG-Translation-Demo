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
    // 记录拖动时的圆视图center
    var circleCenter: CGPoint!
    
    // 我们将在拖拽响应事件上附加不同的动画
    var circleAnimator: UIViewPropertyAnimator!
    let animationDuring = 4.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加可拖动视图
        let circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
        circle.center = self.view.center
        circle.layer.cornerRadius = 50.0
        circle.backgroundColor = UIColor.green()
        
        
        // 添加拖动手势
        circle.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.dragCircle)))
        
        circleAnimator = UIViewPropertyAnimator(duration: animationDuring, curve: .easeInOut, animations: {
            [unowned circle] in
            // 两倍放大
            circle.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        })
        
        self.view.addSubview(circle)
    }
    
    func dragCircle(gesture: UIPanGestureRecognizer) {
        let target = gesture.view!
        
        switch gesture.state {
        case .began, .ended:
            circleCenter = target.center
            
            if (circleAnimator.isRunning) {
                circleAnimator.pauseAnimation()
                circleAnimator.isReversed = gesture.state == .ended
            }
            circleAnimator.startAnimation()
            
            // Three important properties on an animator:
            print("Animator isRunning, isReversed, state: \(circleAnimator.isRunning), \(circleAnimator.isReversed), \(circleAnimator.state)")
        case .changed:
            let translation = gesture.translation(in: self.view)
            target.center = CGPoint(x: circleCenter!.x + translation.x, y: circleCenter!.y + translation.y)
        default: break
        }
    }
}

