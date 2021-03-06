//
//  AppSettingsServiceImp.swift
//  SimpleNotes
//
//  Created by João Palma on 12/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

class AppSettingsServiceImp : AppSettingsService {
    
    private let _userDefaults = UserDefaults.standard
    
    var userName: String {
        get {
            return _userDefaults.string(forKey: "userName") ?? ""
        } set {
            _userDefaults.set(newValue, forKey: "userName")
        }
    }
    
    var userEmail: String {
        get {
            return _userDefaults.string(forKey: "userEmail") ?? ""
        } set {
            _userDefaults.set(newValue, forKey: "userEmail")
        }
    }
    
    var isUserSignedIn: Bool {
        get {
            return _userDefaults.bool(forKey: "isUserSignedIn")
        } set {
            _userDefaults.set(newValue, forKey: "isUserSignedIn")
        }
    }
    
    
    var userAlreadyAskedForNotificationPermissions: Bool {
        get {
            return _userDefaults.bool(forKey: "userAlreadyAskedForNotificationPermissions")
        } set {
            _userDefaults.set(newValue, forKey: "userAlreadyAskedForNotificationPermissions")
        }
    }
    
    var userNotificationId: String {
        get {
            return _userDefaults.string(forKey: "userNotificationId") ?? ""
        } set {
            _userDefaults.set(newValue, forKey: "userNotificationId")
        }
    }
    
    
    
    func clearUserData() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
    }
}
