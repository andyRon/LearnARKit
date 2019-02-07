//
//  AppDelegate.swift
//  ARPokerDice
//
//  Created by [Andy Ron](https://github.com/andyRon) on 2019/2/5.
//  Copyright © 2019 Andy Ron. All rights reserved.
//

import Foundation

public extension Double {
  public static func random(min: Double, max: Double) -> Double {
    let r64 = Double(arc4random(UInt64.self)) / Double(UInt64.max)
    return (r64 * (max - min)) + min
  }
}
