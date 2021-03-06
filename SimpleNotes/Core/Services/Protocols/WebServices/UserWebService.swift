//
//  UserWebService.swift
//  SimpleNotes
//
//  Created by João Palma on 16/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

protocol UserWebService {
    func login(user: User, completion: @escaping (_ user: UserObject?) -> Void) -> String
    func getUser(userId: Int16, completion: @escaping (_ user: UserObject?) -> Void) -> String
    func getAllUsers(completion: @escaping (_ user: [UserObject]?) -> Void) -> String
    func createUser(user: User, completion: @escaping (_ user: UserObject?) -> Void) -> String
    func updateUser(user: User, completion: @escaping (UserObject?) -> Void) -> String
    func deleteUser(userId: Int16, completion: @escaping (UserObject?) -> Void) -> String
    func cancelRequest(id: String)
}
