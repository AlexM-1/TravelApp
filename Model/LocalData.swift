//
//  LocalData.swift
//  TravelAppWB
//
//  Created by Alex M on 08.08.2023.
//

import Foundation

final class LocalData {
    
    var flights: [Flight] = []
    
    static let `default` = LocalData()
    private init() {
    }
    
}
