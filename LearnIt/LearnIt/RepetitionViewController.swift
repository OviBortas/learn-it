//
//  RepetitionViewController.swift
//  LearnIt
//
//  Created by Ovidiu Bortas on 12/19/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

class RepetitionViewController: UIViewController, Resetable {
    
    @IBOutlet weak var testamentSegment: UISegmentedControl!
    @IBOutlet weak var lastChapterLabel: UILabel!
    @IBOutlet var answerButtons: [DesignableButton]!
    @IBOutlet weak var nextLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    
    internal var newTestament = NewTestamentBook()
    internal var justWon = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newTestament.delegate = self
        updateAnswers()
    }
    
    func updateAnswers() {
        newTestament.nextSet()
        
        for button in answerButtons {
            button.setTitle(newTestament.currentSet?[button.tag], for: .normal)
            button.borderColor = .darkGray
        }
        
        endLabel.isHidden = true
        nextLabel.text = "Select next chapter:"
        
        if newTestament.isFirst {
            nextLabel.text = "Select first chapter:"
            lastChapterLabel.text = ""
            if justWon {
                endLabel.isHidden = false
            }
        }
    }
    

    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
    }
    
    @IBAction func didTapAnswerButton(_ sender: DesignableButton) {
        
        guard let selectedAnswer = sender.titleLabel?.text else {
            print("No button title! Will return.")
            return
        }
        
        if newTestament.isCorrect(guess: selectedAnswer) {
            sender.borderColor = .green
            lastChapterLabel.text = selectedAnswer
            updateAnswers()
        }
        else {
            sender.borderColor = .red
        }
    }
    
    func didReset(reset: Bool) {
        if reset {
            endLabel.isHidden = false
            justWon = reset
            
            updateAnswers() // need answers in buttons
    
        }
    }
    

}
