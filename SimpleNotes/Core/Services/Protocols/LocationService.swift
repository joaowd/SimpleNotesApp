//
//  LocationService.swift
//  SimpleNotes
//
//  Created by João Palma on 13/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationService {
    func requestUserAuthorization()
    func getUserLocation() -> String
}
