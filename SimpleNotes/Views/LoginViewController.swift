//
//  LoginViewController.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import Foundation

public class LoginViewController : BaseViewController<LoginViewModel> {
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Theme.red
        
        let button = UIButton(frame: CGRect(x: 0, y: 50, width: 200, height: 50))
        button.backgroundColor = UIColor.Theme.mainBlue
        button.setTitle("Navigate Back", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(_navigateBack), for: UIControl.Event.touchUpInside)
        
        self.view.addSubview(button)
        
        let button2 = UIButton(frame: CGRect(x: 0, y: 150, width: 200, height: 50))
        button2.backgroundColor = UIColor.Theme.green
        button2.setTitle("Navigate Account", for: UIControl.State.normal)
        button2.addTarget(self, action: #selector(_navigateAccount), for: UIControl.Event.touchUpInside)
        
        self.view.addSubview(button2)
    }
    
    @objc func _navigateBack(sender: UIButton){
        viewModel.navigateBackCommand()
    }
    
    @objc func _navigateAccount(sender: UIButton){
        viewModel.createAccountCommand.executeIf()
    }
}