//
//  Core.swift
//  SimpleNotes
//
//  Created by João Palma on 07/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

public class Core {
    public static func initialize() {
        _registerServices()
        _registerViewModels()
        _registerViewControllers()
    }
    
    private static func _registerServices() {
        DiContainer.registerAsSingleton(NavigationService.self) { NavigationServiceImp() }
        DiContainer.registerAsSingleton(DialogService.self) { DialogServiceImp(navigationService: DiContainer.resolve()) }
        DiContainer.registerAsSingleton(L10NService.self) { L10NServiceImp(reportService: DiContainer.resolve()) }
        DiContainer.registerAsSingleton(ReportService.self) { ReportServiceImp() }
        DiContainer.registerAsSingleton(AppSettingsService.self) { AppSettingsServiceImp() }
        DiContainer.registerAsSingleton(LocationService.self) { LocationServiceImp() }
        DiContainer.registerAsSingleton(DatabaseUserService.self) { DatabaseUserServiceImp(reportService: DiContainer.resolve()) }
        DiContainer.registerAsSingleton(DatabaseNoteService.self) { DatabaseNoteServiceImp(reportService: DiContainer.resolve()) }
        DiContainer.registerAsSingleton(WebService.self) { WebServiceImp(reportService: DiContainer.resolve()) }
        DiContainer.registerAsSingleton(UserWebService.self) { UserWebServiceImp(webService: DiContainer.resolve()) }
        DiContainer.registerAsSingleton(NoteWebService.self) { NoteWebServiceImp(webService: DiContainer.resolve()) }
        DiContainer.registerAsSingleton(ImageService.self) { ImageServiceImp(reportService: DiContainer.resolve()) }
        DiContainer.registerAsSingleton(ImageService.self) { ImageServiceImp(reportService: DiContainer.resolve()) }
        DiContainer.registerAsSingleton(NotificationService.self) { NotificationServiceImp(appSettingsService: DiContainer.resolve()) }
    }
    
    private static func _registerViewModels() {
        DiContainer.register(LoadingViewModel.self) { LoadingViewModel(appSettingsService: DiContainer.resolve()) }
        
        DiContainer.register(LoginViewModel.self) { LoginViewModel(
            userWebService: DiContainer.resolve(),
            dialogService: DiContainer.resolve(),
            databaseUserService: DiContainer.resolve(),
            appSettingsService: DiContainer.resolve())
        }
        DiContainer.register(CreateAccountViewModel.self) { CreateAccountViewModel(
            userWebService: DiContainer.resolve(),
            dialogService: DiContainer.resolve(),
            appSettingsService: DiContainer.resolve())
        }
        
        DiContainer.register(NotesListViewModel.self) { NotesListViewModel() }
        DiContainer.register(CreateNoteViewModel.self) { CreateNoteViewModel() }
    }
    
    private static func _registerViewControllers() {
        DiContainer.registerViewController(LoadingViewModel.self) { LoadingViewController() }
        DiContainer.registerViewController(LoginViewModel.self) { LoginViewController() }
        DiContainer.registerViewController(CreateAccountViewModel.self) { CreateAccountViewController() }
        DiContainer.registerViewController(NotesListViewModel.self) { NotesListViewController() }
        DiContainer.registerViewController(CreateNoteViewModel.self) { CreateNoteViewController() }
    }
    
    public static func startApp() {
        let navigationService : NavigationService = DiContainer.resolve()
        navigationService.navigateAndSetAsContainer(viewModel: LoadingViewModel.self)
    }
}
