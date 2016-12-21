//
//  DraggableLabel.swift
//  LearnIt
//
//  Created by Ovidiu Bortas on 12/20/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

enum Position { case left, right, bottom }

@IBDesignable
class DraggableLabel: UILabel, UIDynamicAnimatorDelegate {

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet { layer.cornerRadius = cornerRadius }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet { layer.borderWidth = borderWidth }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet { layer.borderColor = borderColor.cgColor }
    }

    var originalFrame: CGRect!
    var possibleLeft: CGRect?
    var possibleRight: CGRect?
    var isLeft = false
    var isRight = false
    var position: Position = .bottom
    
    var delegate: Draggable? = nil
    
    var animator: UIDynamicAnimator? = nil {
        didSet { animator?.delegate = self }
    }
    
    var snap: UISnapBehavior? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        originalFrame = frame
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(userDragged(gesture:)))
        gesture.minimumPressDuration = 0
        addGestureRecognizer(gesture)
        isUserInteractionEnabled = true
    }
    
    func userDragged(gesture: UILongPressGestureRecognizer) {
        
        if animator!.isRunning { resetSnap() }
        
        switch gesture.state {
        case .changed:
            let location = gesture.location(in: superview)
            center = location
        case .ended:
            guard let left = possibleLeft, let right = possibleRight else {
                print("Left and right positions are nil.")
                return
            }
            
            if frame.intersects(left) {
                snap(to: .left)
            }
            else if frame.intersects(right) {
                snap(to: .right)
            }
            else {
                snap(to: .bottom)
            }
        default: break
        }
    }
    
    func `switch`(to position: Position) {
        switch position {
        case .left:
            isLeft = true
            isRight = false
        case .right:
            isRight = true
            isLeft = false
        case .bottom:
            isLeft = false
            isRight = false
        }
    }
    
    func snap(to position: Position) {
        guard let left = possibleLeft, let right = possibleRight else {
            print("Left and right positions are nil.")
            return
        }
        
        if animator!.isRunning { resetSnap() }
        
        self.position = position
        
        switch position {
        case .left:
            snap = UISnapBehavior(item: self, snapTo: CGPoint(x: left.midX, y: left.midY))
            `switch`(to: .left)
        case .right:
            snap = UISnapBehavior(item: self, snapTo: CGPoint(x: right.midX, y: right.midY))
            `switch`(to: .right)
        case .bottom:
            snap = UISnapBehavior(item: self, snapTo: CGPoint(x: originalFrame.midX, y: originalFrame.midY))
            `switch`(to: .bottom)
        }
        
        
        guard let snap = snap else {
            print("No snap behavior.")
            return
        }
        
        snap.damping = 0.8
        
        delegate?.willSnap(label: self, to: self.position)
        animator?.addBehavior(snap)
    }
    
    func resetSnap() {
        guard let left = possibleLeft, let right = possibleRight else {
            print("Left and right positions are nil.")
            return
        }
        
        animator?.removeAllBehaviors()
        
        switch position {
        case .left:
            center = CGPoint(x: left.midX, y: left.midY)
        case .right:
            center = CGPoint(x: right.midX, y: right.midY)
        case .bottom:
            center = CGPoint(x: originalFrame.midX, y: originalFrame.midY)
            
            
        }
    }
    
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        // When animator is done set the lables frame to the animated frame
        // then remove the animator behavior
        print(#function)
        for lbl in animator.items(in: (superview?.frame)!) {
            if let lbl = lbl as? DraggableLabel {
                let position = lbl.frame
                animator.removeAllBehaviors()
                
                lbl.frame = position
                delegate?.didSnap(label: self, to: self.position)
            }
        }
    }
}
