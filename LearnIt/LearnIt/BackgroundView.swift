//
//  BackgroundView.swift
//  LearnIt
//
//  Created by Ovidiu Bortas on 12/19/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

@IBDesignable
class BackgroundView: UIView {
    
    @IBInspectable var image: UIImage? = nil {
        didSet { backgroundImage.image = image }
    }
    
    @IBInspectable var blurAlpha: CGFloat = 0.95 {
        didSet { backgroundVisualEffect.alpha = blurAlpha }
    }
    
    @IBInspectable var blurEffect: Int = 0 {
        didSet {
            if blurEffect >= 0 && blurEffect <= 2 {
                backgroundVisualEffect.effect = UIBlurEffect(style: UIBlurEffectStyle(rawValue: blurEffect)!)
            }
        }
    }
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var backgroundVisualEffect: UIVisualEffectView!
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        // setup any properties here
        
        // call the super.init
        super.init(frame: frame)
        
        // setup view from xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // setup any properties here
        
        // call the super.init
        super.init(coder: aDecoder)
        
        // setup view from xib file
        xibSetup()
    }
    
    func xibSetup() {
        contentView = loadViewFromNib()
        
        contentView.frame = bounds
        
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(contentView)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "BackgroundView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
}
