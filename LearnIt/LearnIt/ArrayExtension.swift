//
//  ArrayExtension.swift
//  LearnIt
//
//  Created by Ovidiu Bortas on 12/19/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import Foundation


extension Array {
    
    func random() -> Element {
        let rndIndex = arc4random_uniform(UInt32(count))
        
        return self[Int(rndIndex)]
    }
    
    
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            
            guard d != 0 else { continue }
            
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}
