//
//  Resistor.swift
//  Breadboard
//
//  Created by Ben Anderman on 5/2/16.
//  Copyright © 2016 Ben Anderman. All rights reserved.
//

import Foundation

class ResistorNode: CircuitNode {
  weak var otherResistorNode: ResistorNode?
  let resistance: Int
  
  init(resistance: Int) {
    self.resistance = resistance
    super.init()
  }
  
  override func resistanceToNode(node: CircuitNode) -> Int {
    if node === otherResistorNode {
      return resistance
    } else {
      return super.resistanceToNode(node)
    }
  }
}

class Resistor: Component {
  
  convenience init() {
    self.init(resistance: 100)
  }
  
  init(resistance: Int) {
    let node1 = ResistorNode(resistance: resistance)
    let node2 = ResistorNode(resistance: resistance)
    node1.otherResistorNode = node2
    node2.otherResistorNode = node1
    super.init(node1: node1, node2: node2)
  }
}
