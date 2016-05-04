//
//  Breadboard.swift
//  Breadboard
//
//  Created by Ben Anderman on 5/2/16.
//  Copyright © 2016 Ben Anderman. All rights reserved.
//

import Foundation

class Breadboard {
  static let kCircuitUpdatedNotificationName = "CircuitUpdated"
  
  let leftPowerRail: CircuitNodeGrid
  let rightPowerRail: CircuitNodeGrid
  let leftRows: CircuitNodeGrid
  let rightRows: CircuitNodeGrid
  
  let groundNode = CircuitNode()
  let powerNode = CircuitNode()
  
  var groundConnectedNodes = [CircuitNode: Int]()
  var powerConnectedNodes = [CircuitNode: Int]()
  
  init(width: UInt, height: UInt) {
    leftPowerRail = CircuitNodeGrid(width: 2, height: height, connectionType: .Columns)
    rightPowerRail = CircuitNodeGrid(width: 2, height: height, connectionType: .Columns)
    
    leftPowerRail.columns[1][0].connect(powerNode)
    rightPowerRail.columns[1][0].connect(powerNode)
    leftPowerRail.columns[0][0].connect(groundNode)
    rightPowerRail.columns[0][0].connect(groundNode)
    
    // 3 is for padding between the 4 grids
    let sizeLeft = leftPowerRail.width + rightPowerRail.width + 3
    leftRows = CircuitNodeGrid(width: sizeLeft / 2, height: height, connectionType: .Rows)
    rightRows = CircuitNodeGrid(width: sizeLeft / 2, height: height, connectionType: .Rows)
    
    updateCircuitConnections()
  }
  
  func updateCircuitConnections() {
    groundConnectedNodes.removeAll()
    powerConnectedNodes.removeAll()
    connectedNodeMapForNode(groundNode, map: &groundConnectedNodes)
    connectedNodeMapForNode(powerNode, map: &powerConnectedNodes)
    
    NSNotificationCenter.defaultCenter().postNotificationName(Breadboard.kCircuitUpdatedNotificationName, object: self)
  }
  
  func connectedNodeMapForNode(rootNode: CircuitNode, inout map: [CircuitNode: Int], resistance: Int = 0)
  {
    for node in rootNode.connections.allObjects.map({ $0 as! CircuitNode }) {
      if (!map.keys.contains(node)) {
        map[node] = resistance
        connectedNodeMapForNode(node, map: &map, resistance: resistance + rootNode.resistanceToNode(node))
      }
    }
  }
}
