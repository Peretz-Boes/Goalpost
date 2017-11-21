//
//  UIViewControllerExt.swift
//  goal-post
//
//  Created by peretz on 2017-11-15.
//  Copyright © 2017 peretz. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController{
    func presentDetail(_viewControllerToPresent:UIViewController) {
        let transition = CATransition()
        transition.duration=0.3
        transition.type=kCATransitionPush
        transition.subtype=kCATransitionFromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(_viewControllerToPresent, animated: false, completion: nil)
    }
    
    func presentSecondaryDetail(_ viewControllerToPresent:UIViewController) {
        let transition = CATransition()
        transition.duration=0.3
        transition.type=kCATransitionPush
        transition.subtype=kCATransitionFromRight
        guard let presentedViewController=presentedViewController else {
            return
        }
        presentedViewController.dismiss(animated: false){
            self.view.window?.layer.add(transition, forKey: kCATransition)
            self.present(viewControllerToPresent, animated: false, completion: nil)
        }
    }
    
    func dismissDetail() {
        let transition = CATransition()
        transition.duration=0.3
        transition.type=kCATransitionPush
        transition.subtype=kCATransitionFromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
    
}
