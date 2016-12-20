//
//  ShadowLineHideable.swift
//  LearnIt
//
//  Created by Ovidiu Bortas on 12/19/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

protocol ShadowLineHideable: class {
    
    var isShadowLineHidden: Bool { get set }
}

extension ShadowLineHideable where Self: UITabBarController {
    
    func hideShadowLine() {
        if isShadowLineHidden == false {
            for view in tabBar.subviews where view.isType(of: "_UIBarBackground") {
                for subview in view.subviews where subview.isKind(of: UIImageView.self) {
                    subview.isHidden = true
                    isShadowLineHidden = true
                }
            }
        }
    }
}


// MARK: - NSObject Extension
extension NSObject {
    
    func isType(of type: String) -> Bool {
        return "\(type(of: self))" == type ? true : false
    }
}
