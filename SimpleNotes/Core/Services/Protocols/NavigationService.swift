//
//  NavigationService.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit

public protocol NavigationService {
    func visibleViewController() -> UIViewController
    
    func navigate<TViewModel : ViewModel>(viewModel: TViewModel.Type, arguments: Any?, animated: Bool)
    func navigateModal<TViewModel : ViewModel>(viewModel: TViewModel.Type, arguments: Any?)
    func navigateAndSetAsContainer<TViewModel : ViewModel>(viewModel: TViewModel.Type)
    
    func close(arguments: Any?, animated: Bool);
    func closeModal(arguments: Any?);
}
