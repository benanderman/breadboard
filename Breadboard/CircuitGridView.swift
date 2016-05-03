//
//  CircuitGridView.swift
//  Breadboard
//
//  Created by Ben Anderman on 5/3/16.
//  Copyright © 2016 Ben Anderman. All rights reserved.
//

import Foundation
import UIKit

class CircuitGridView: UIView {
  
  init(grid: CircuitNodeGrid) {
    super.init(frame: CGRect(x: 0, y: 0, width: CGFloat(grid.width) * PlugView.plugSize, height: CGFloat(grid.height) * PlugView.plugSize))
    var point = CGPointZero
    for column in grid.columns {
      for node in column {
        let view = PlugView(node: node)
        view.frame.origin = point
        point.y += PlugView.plugSize
        self.addSubview(view)
      }
      point.x += PlugView.plugSize
      point.y = 0
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
