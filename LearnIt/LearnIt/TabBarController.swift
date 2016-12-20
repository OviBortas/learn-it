//
//  TabBarController.swift
//  LearnIt
//
//  Created by Ovidiu Bortas on 12/19/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, ShadowLineHideable {
    
    var isShadowLineHidden: Bool = false

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        hideShadowLine()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        tabBar.backgroundImage = UIImage.image(with: .clear)
        
        let frost = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        frost.alpha = 0.5
        frost.frame = tabBar.bounds
        frost.autoresizingMask = .flexibleWidth
        tabBar.insertSubview(frost, at: 0)
    }

}
