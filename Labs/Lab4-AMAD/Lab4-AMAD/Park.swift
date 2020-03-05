//
//  Park.swift
//  Lab4-AMAD
//
//  Created by Matthew Coker on 3/4/20.
//  Copyright © 2020 Matthew Coker. All rights reserved.
//

import Foundation

struct Park: Decodable {
    let name: String
    let description: String
    let directionsInfo: String
}

struct ParkData: Decodable {
    var data = [Park]()
}
