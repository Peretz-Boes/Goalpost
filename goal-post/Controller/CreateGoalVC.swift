//
//  CreateGoalVC.swift
//  goal-post
//
//  Created by peretz on 2017-11-15.
//  Copyright © 2017 peretz. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermButton: UIButton!
    @IBOutlet weak var longTermButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    var goalType:GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.bindToKeyboard()
        shortTermButton.setSelectedColour()
        longTermButton.setDeselectedColour()
        goalTextView.delegate=self as? UITextViewDelegate
    }

    @IBAction func shortTermButtonWasPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermButton.setSelectedColour()
        longTermButton.setDeselectedColour()
    }
    
    @IBAction func longTermButtonWasPressed(_ sender: Any) {
        goalType = .longTerm
        longTermButton.setSelectedColour()
        shortTermButton.setDeselectedColour()
    }
    
    @IBAction func nextButtonWasPressed(_ sender: Any) {
        if goalTextView.text != "" && goalTextView.text != "What is your goal"{
            guard let finishGoalVC=storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC")as?FinishGoalVC
                else{
                return
            }
            finishGoalVC.initData(description: goalTextView.text, type: goalType)
            presentedViewController?.presentSecondaryDetail(finishGoalVC)
            presentDetail(_viewControllerToPresent: finishGoalVC)
        }
    }
    @IBAction func backButtonWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    func textViewDidBeginEditing(_textView:UITextView) {
        goalTextView.text=""
        goalTextView.textColor=#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
    }
    
}
