//
//  AppDelegate.swift
//  ARPokerDice
//
//  Created by [Andy Ron](https://github.com/andyRon) on 2019/2/5.
//  Copyright © 2019 Andy Ron. All rights reserved.
//

import Foundation

public func arc4random <T: ExpressibleByIntegerLiteral> (_ type: T.Type) -> T {
  var r: T = 0
  arc4random_buf(&r, Int(MemoryLayout<T>.size))
  return r
}

