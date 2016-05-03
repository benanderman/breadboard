//
//  BreadboardView.swift
//  Breadboard
//
//  Created by Ben Anderman on 5/3/16.
//  Copyright © 2016 Ben Anderman. All rights reserved.
//

import Foundation
import UIKit

class BreadboardView: UIView {
  let breadboard: Breadboard
  
  init(breadboard: Breadboard) {
    self.breadboard = breadboard
    let grids = [breadboard.leftPowerRail, breadboard.leftRows, breadboard.rightRows, breadboard.rightPowerRail]
    let width = grids.reduce(0, combine: { $0 + $1.width }) + UInt(grids.count - 1)
    let height = breadboard.leftPowerRail.height
    super.init(frame: CGRect(x: 0, y: 0, width: CGFloat(width) * PlugView.plugSize, height: CGFloat(height) * PlugView.plugSize))
    
    var point = CGPointZero
    for grid in grids {
      let view = CircuitGridView(grid: grid)
      self.addSubview(view)
      view.frame.origin = point
      point.x += view.frame.size.width + PlugView.plugSize
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
