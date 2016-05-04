//
//  Component.swift
//  Breadboard
//
//  Created by Ben Anderman on 5/2/16.
//  Copyright © 2016 Ben Anderman. All rights reserved.
//

import Foundation

class Component {
  let node1: CircuitNode
  let node2: CircuitNode
  
  convenience init() {
    let node1 = CircuitNode()
    let node2 = CircuitNode()
    self.init(node1: node1, node2: node2)
  }
  
  init(node1: CircuitNode, node2: CircuitNode, connect: Bool = true) {
    self.node1 = node1
    self.node2 = node2
    if connect {
      self.node1.connect(self.node2)
    }
  }
}
