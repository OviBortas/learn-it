//
//  BeforeAndAfterViewController.swift
//  LearnIt
//
//  Created by Ovidiu Bortas on 12/20/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

class BeforeAndAfterViewController: UIViewController, Draggable {

    @IBOutlet var chapterLabels: [DraggableLabel]!
    @IBOutlet weak var middleChapterLabel: UILabel!
    @IBOutlet weak var leftChapterLabel: UILabel! {
        didSet { leftChapterLabel.isUserInteractionEnabled = false }
    }
    @IBOutlet weak var rightChapterLabel: UILabel! {
        didSet { rightChapterLabel.isUserInteractionEnabled = false}
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //view.layoutIfNeeded() //Maybe?
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for (index, lbl) in chapterLabels.enumerated() {
            lbl.possibleLeft = leftChapterLabel.frame
            lbl.possibleRight = rightChapterLabel.frame
            lbl.animator = UIDynamicAnimator(referenceView: view)
            
            lbl.tag = index
            lbl.text = "\(lbl.tag)"
            
            
            lbl.delegate = self
        }
    }
    
    internal func willSnap(label: DraggableLabel, to position: Position) {
        for lbl in chapterLabels where lbl != label && lbl.position != .bottom {
            if lbl.position == position {
                lbl.animator?.removeAllBehaviors()
                lbl.snap(to: .bottom)
            }
        }
    }
    
    internal func didSnap(label: DraggableLabel, to position: Position) {
    }
    

}
