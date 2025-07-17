//
//  Untitled.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 17/7/25.
//

import UIKit

class LoginSignupViewController: UIViewController {
    
    @IBOutlet weak var loginSignupSegmentedControl: UISegmentedControl!
    @IBOutlet weak var loginSegmentView: UIView!
    @IBOutlet weak var signupSegmentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        loginSignupSegmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        self.view.bringSubviewToFront(loginSegmentView)
    }
    
    @IBAction func loginSignupSementedAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: self.view.bringSubviewToFront(loginSegmentView)
        case 1: self.view.bringSubviewToFront(signupSegmentView)
        default: break
        }
    }
    
}
