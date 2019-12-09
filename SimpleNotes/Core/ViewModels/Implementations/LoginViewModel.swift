//
//  LoginViewModel.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

public class LoginViewModel: ViewModelBaseWithArguments<Bool> {
    private var _createAccountCommand: Command?
    public var createAccountCommand: Command {
        get { _createAccountCommand ??= Command(_createAccount, canExecute: _canExecute); return _createAccountCommand!}
    }
    
    override public func prepare(data: Bool) {
    }
    
    private func _createAccount(){
        let _: CreateAccountViewModel? = navigationService.navigate(arguments: nil, animated: true)
    }
    
    public func navigateBackCommand(){
        navigationService.close(arguments: true, animated: true)
    }
    
    public func _canExecute() -> Bool {
        return true
    }
}
