//
//  LED.swift
//  Breadboard
//
//  Created by Ben Anderman on 5/3/16.
//  Copyright © 2016 Ben Anderman. All rights reserved.
//

import Foundation

class LED: Component {
  override init(node1: CircuitNode, node2: CircuitNode, connect: Bool = false) {
    super.init(node1: node1, node2: node2, connect: false)
  }
}
