//
//  CircuitNodeGrid.swift
//  Breadboard
//
//  Created by Ben Anderman on 5/2/16.
//  Copyright © 2016 Ben Anderman. All rights reserved.
//

import Foundation

class CircuitNodeGrid {
  enum GridConnectionType {
    case Rows
    case Columns
    case None
  }
  
  let connectionType: GridConnectionType
  let width: UInt
  let height: UInt
  
  var columns: [[CircuitNode]]
  var connectionGroups: [CircuitNode]
  
  init(width: UInt, height: UInt, connectionType: GridConnectionType) {
    self.connectionType = connectionType
    self.width = width
    self.height = height
    columns = [[CircuitNode]]()
    for _ in 0 ..< width {
      let column = (0 ..< height).map { _ in CircuitNode() }
      columns.append(column)
    }
    
    connectionGroups = [CircuitNode]()
    switch connectionType {
    case .Rows:
      for y in 0 ..< Int(height) {
        let group = CircuitNode()
        connectionGroups.append(group)
        for x in 0 ..< Int(width) {
          columns[x][y].connect(group)
        }
      }
      
    case .Columns:
      for column in columns {
        let group = CircuitNode()
        connectionGroups.append(group)
        for node in column {
          node.connect(group)
        }
      }
      
    case .None: break
    }
  }
}
