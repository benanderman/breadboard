//
//  Breadboard.swift
//  Breadboard
//
//  Created by Ben Anderman on 5/2/16.
//  Copyright © 2016 Ben Anderman. All rights reserved.
//

import Foundation

class Breadboard {
  let leftPowerRail: CircuitNodeGrid
  let rightPowerRail: CircuitNodeGrid
  let leftRows: CircuitNodeGrid
  let rightRows: CircuitNodeGrid
  
  let groundNode = CircuitNode()
  let powerNode = CircuitNode()
  
  init(width: UInt, height: UInt) {
    leftPowerRail = CircuitNodeGrid(width: 2, height: height, connectionType: .Columns)
    rightPowerRail = CircuitNodeGrid(width: 2, height: height, connectionType: .Columns)
    
    leftPowerRail.columns[0][0].connect(groundNode)
    rightPowerRail.columns[0][0].connect(groundNode)
    leftPowerRail.columns[0][1].connect(powerNode)
    rightPowerRail.columns[0][1].connect(powerNode)
    
    // 3 is for padding between the 4 grids
    let sizeLeft = leftPowerRail.width + rightPowerRail.width + 3
    leftRows = CircuitNodeGrid(width: sizeLeft / 2, height: height, connectionType: .Rows)
    rightRows = CircuitNodeGrid(width: sizeLeft / 2, height: height, connectionType: .Rows)
  }
  
}
