//
//  SuperHero.swift
//  FIT5140-Week03-Lab
//
//  Created by Yi Zhang on 15/8/19.
//  Copyright © 2019 Yi Zhang. All rights reserved.
//

import UIKit

class SuperHero: NSObject {
    var name: String
    var abilities: String

    init(name: String, abilities: String) {
        self.name = name
        self.abilities = abilities
    }
}
