//
//  ViewController.swift
//  goal-post
//
//  Created by peretz on 2017-11-13.
//  Copyright © 2017 peretz. All rights reserved.
//

import UIKit
import CoreData
let appDelegate = UIApplication.shared.delegate as?AppDelegate

class GoalsVC: UIViewController {

    @IBOutlet weak var goalsTableView: UITableView!
    var goals:[Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalsTableView.delegate=self
        goalsTableView.dataSource=self
        goalsTableView.isHidden=false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        goalsTableView.reloadData()
    }
    
    @IBAction func addGoalButtonWasPressed(_ sender: Any) {
        guard let createGoalVC=storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC")else{
            return}
        presentDetail(_viewControllerToPresent: createGoalVC)
    }
    
    func fetchCoreDataObjects() {
        self.fetch{(complete) in
            if complete{
                if goals.count>=1{
                    goalsTableView.isHidden=false
                }
            }
        }
        
    }
    
}

extension GoalsVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView:UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell=tableView.dequeueReusableCell(withIdentifier: "goalCell")as?GoalCell else{return UITableViewCell()}
        let goal = goals[indexPath.row]
        cell.configureCellDescription(description: goal.goalDescription!, type: GoalType(rawValue: goal.goalType!)!, goalProgressAmount: Int(goal.goalProgress))
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            self.goalsTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let addAction = UITableViewRowAction(style: .normal, title: "Add 1") { (rowAction, indexPath) in
            self.setProgress(atIndexPath:indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.backgroundColor=#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        addAction.backgroundColor=#colorLiteral(red: 0.9385011792, green: 0.7164435983, blue: 0.3331357837, alpha: 1)
        return [deleteAction]
    }
}
extension GoalsVC{
    
    func setProgress(atIndexPath indexPath:IndexPath) {
        guard let managedContext=appDelegate?.persistentContainer.viewContext else {
            return
        }
        let chosenGoal = goals[indexPath.row]
        if chosenGoal.goalProgress<chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress=chosenGoal.goalProgress+1
        }else{
            return
        }
        
        do {
            try managedContext.save()
            print("Successfully set progress")
        } catch {
            debugPrint("Could not set progress\(error.localizedDescription)")
        }
        
    }
    
    func fetch(completion:(_ complete:Bool)->()) {
        guard let managedContext=appDelegate?.persistentContainer.viewContext else {
            return
        }
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do{
            goals=try managedContext.fetch(fetchRequest)
        }catch{
            debugPrint("Could not fetch\(error.localizedDescription)")
        }
        
        
    }
    
    func removeGoal(atIndexPath indexPath:IndexPath) {
        guard let managedContext=appDelegate?.persistentContainer.viewContext else {
            return
        }
        managedContext.delete(goals[indexPath.row])
        do{
            try managedContext.save()
            print("Successfully removed goal")
        }catch{
            debugPrint("Could not remove\(error.localizedDescription)")
        }
    }
    
}

