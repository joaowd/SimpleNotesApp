//
//  DialogServiceImp.swift
//  SimpleNotes
//
//  Created by João Palma on 09/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import Foundation

public class DialogServiceImp: DialogServiceProtocol {
    private var _navigationService: NavigationServiceProtocol
    
    init(navigationService: NavigationServiceProtocol) {
        self._navigationService = navigationService
    }
    
    func showInfo(_ description: String, informationType: InfoDialogType) {
        let infoView = InfoDialogView()
        infoView.showInfo(text: description, infoType: informationType)
    }
    
    func showOptionAlert(title: String?, message: String?, positiveOption: String, negativeOption: String, callback: @escaping ((Bool) -> ()?)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: positiveOption, style: .default, handler: { (alert: UIAlertAction!) in callback(true) }))
        alert.addAction(UIAlertAction(title: negativeOption, style: .cancel, handler: { (alert: UIAlertAction!) in callback(false) }))
        
        let visibleViewController = _navigationService.visibleViewController()
        visibleViewController.present(alert, animated: true)
    }
    
}