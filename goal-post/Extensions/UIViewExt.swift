//
//  UIViewExt.swift
//  goal-post
//
//  Created by peretz on 2017-11-15.
//  Copyright © 2017 peretz. All rights reserved.
//

import UIKit
extension UIView{
    func bindToKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func keyboardWillChange(_notification:NSNotification) {
        let duration = _notification.userInfo![UIKeyboardAnimationDurationUserInfoKey]as!Double
        let curve = _notification.userInfo![UIKeyboardAnimationCurveUserInfoKey]as!UInt
        let startingFrame = (_notification.userInfo![UIKeyboardFrameBeginUserInfoKey]as!NSValue).cgRectValue
        let endingFrame = (_notification.userInfo![UIKeyboardFrameEndUserInfoKey]as!NSValue).cgRectValue
        let deltaY = endingFrame.origin.y-startingFrame.origin.y
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue:curve), animations: {
            self.frame.origin.y+=deltaY
        }, completion: nil)
        
        
        
        
        
    }
    
}

