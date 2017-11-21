//
//  GoalCell.swift
//  goal-post
//
//  Created by peretz on 2017-11-14.
//  Copyright © 2017 peretz. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalDescriptionLabel: UILabel!
    @IBOutlet weak var goalTypeLabel: UILabel!
    @IBOutlet weak var goalProgressLabel: UILabel!
    @IBOutlet weak var completionView: UIView!
    
    func configureCell(goal:Goal) {
        self.goalDescriptionLabel.text=goal.goalDescription
        self.goalTypeLabel.text=goal.goalType
        self.goalProgressLabel.text=String(describing: goal.goalProgress)
        if goal.goalProgress==goal.goalCompletionValue {
            self.completionView.isHidden=false
        }else{
            self.completionView.isHidden=true
        }
    }
    
    func configureCellDescription(description:String,type:GoalType,goalProgressAmount:Int) {
        self.goalDescriptionLabel.text=description
        self.goalTypeLabel.text=type.rawValue
        self.goalProgressLabel.text=String(describing:goalProgressAmount)
    }
    
}
