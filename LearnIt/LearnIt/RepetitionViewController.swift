//
//  RepetitionViewController.swift
//  LearnIt
//
//  Created by Ovidiu Bortas on 12/19/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

class RepetitionViewController: UIViewController {
    
    @IBOutlet weak var testamentSegment: UISegmentedControl!
    @IBOutlet weak var lastChapterLabel: UILabel!
    @IBOutlet var answerButtons: [DesignableButton]!
    
    internal var newTestament = NewTestamentBook()

    override func viewDidLoad() {
        super.viewDidLoad()

        updateAnswers()
    }
    
    func updateAnswers() {
        newTestament.nextSet()
        
        for button in answerButtons {
            button.setTitle(newTestament.currentSet?[button.tag], for: .normal)
            button.borderColor = .darkGray
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
    

}
