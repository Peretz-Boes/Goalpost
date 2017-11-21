//
//  FinishGoalVC.swift
//  goal-post
//
//  Created by peretz on 2017-11-16.
//  Copyright © 2017 peretz. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var createGoalButtom: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    var goalDescripton:String!
    var goalType:GoalType!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func createGoalButtonWasPressed(_ sender: Any) {
        if pointsTextField.text!=nil {
            self.save{(complete)in
                if complete{
                    dismiss(animated: true, completion: nil)
                }
            }
            
        }
        
    }
    
    func initData(description:String,type:GoalType) {
        
    }
    
    @IBAction func backButtonWasPressed(_ sender: Any) {
        
    }
    
    func save(completion:(_ finished:Bool)->()) {
        guard let managedContext=appDelegate?.persistentContainer.viewContext else {
            return
        }
        let goal = Goal(context: managedContext)
        goal.goalDescription=goalDescripton
        goal.goalType=goalType.rawValue
        goal.goalCompletionValue=Int32(pointsTextField.text!)!
        goal.goalProgress=Int32(0)
        do{
            try managedContext.save()
            completion(true)
        }catch{
            debugPrint("Could not save: \(error.localizedDescription)")
        }
        
    }
    
}
