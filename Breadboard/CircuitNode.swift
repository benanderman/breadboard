//
//  CircuitNode.swift
//  Breadboard
//
//  Created by Ben Anderman on 5/2/16.
//  Copyright © 2016 Ben Anderman. All rights reserved.
//

import Foundation

class CircuitNode {
  
  // It would be nice for this to be a Set, but then CircuitNode has to be Hashable
  var connections = [CircuitNode]()
  
  func connect(node: CircuitNode) {
    guard connections.contains({$0 === node}) else { return }
    connections.append(node)
    node.connect(self)
  }
  
  func disconnect(node: CircuitNode) {
    for (i, connection) in connections.enumerate() {
      if connection === node {
        connections.removeAtIndex(i)
        connection.disconnect(self)
        break
      }
    }
  }
  
  // To be used to check resistance to nodes in .connections, not arbitrary nodes
  func resistanceToNode(node: CircuitNode) -> Int {
    return 0
  }
  
  // To be called with arbitrary nodes; returns the lowest resistance connection
  func connectedToNode(node: CircuitNode) -> (connected: Bool, resistance: Int) {
    // TODO: Actually implement this
    return (connected: false, resistance: 0)
  }
}
