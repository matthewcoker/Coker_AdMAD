//
//  DependentPList.swift
//  Lab1-AMAD
//
//  Created by Matthew Coker on 2/5/20.
//  Copyright © 2020 Matthew Coker. All rights reserved.
//

import Foundation

struct DependentPList: Decodable {
    let name: String
    let albums: [String]
}

