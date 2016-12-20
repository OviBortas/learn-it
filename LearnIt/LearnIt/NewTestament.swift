//
//  NewTestament.swift
//  LearnIt
//
//  Created by Ovidiu Bortas on 12/19/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import Foundation

struct NewTestamentBook {
    
    let chapters: [String]
    var current: Int? = nil
    var last4: [String]? = nil
    var currentSet: [String]? = nil
    
    init() {
        chapters = ["Matthew", "Mark", "Luke", "John", "Acts",
                    "Romans", "1 Corinthians", "2 Corinthians", "Galatians", "Ephesians",
                    "Philippians", "Colossians", "1 Thessalonians", "2 Thessalonians", "1 Timothy",
                    "2 Timothy", "Titus", "Philemon", "Hebrews", "James",
                    "1 Peter", "2 Peter", "1 John", "2 John", "3 John",
                    "Jude", "Revelation"]
        reset()
        
    }
    
    mutating func reset() {
        current = nil
        last4 = nil
        currentSet = nil
    }
    
    mutating func nextSet() {
        
        // First run, values are nil
        guard let _ = current, let last = last4 else  {
            current = 0
            
            var next = [chapters[current!]]
            
            // Keep selecting a random item and check that it doesnt exist in the next array
            while next.count < 4 {
                let rnd = chapters.random()
                // Make sure no duplicate chapter is added
                if next.contains(rnd) { continue }
                
                next.append(rnd)
                
            }
            //next.shuffle()
            last4 = next
            
            currentSet = next
            
            return
        }
        
        // Not first run
        current! += 1
        
        var next = [chapters[current!]]
        
        while next.count < 4 {
            let rnd = chapters.random()
            
            if last.contains(rnd) { continue }
            if next.contains(rnd) { continue }
            
            next.append(rnd)
        }
        next.shuffle()
        last4 = next
        
        currentSet =  next
    }
    
    func isCorrect(guess: String) -> Bool {
        
        guard let current = current else {
            return false
        }
        
        return guess == chapters[current]
    }
    
//    func test() {
//        var array = [UInt32]()
//        
//        for _ in 0 ..< 1000 {
//            var int = arc4random_uniform(UInt32(chapters.count))
//            
//            if array.contains(int) { continue }
//            
//            array.append(int)
//        }
//        array.sort()
//        print(array)
//    }
    
    
}
