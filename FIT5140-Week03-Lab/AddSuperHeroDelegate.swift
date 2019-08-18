//
//  AddSuperHeroDelegate.swift
//  FIT5140-Week03-Lab
//
//  Created by Yi Zhang on 18/8/19.
//  Copyright © 2019 Yi Zhang. All rights reserved.
//
protocol AddSuperHeroDelegate: AnyObject {
    func addSuperHero(newHero: SuperHero) -> Bool
}
