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
  
  let grid: CircuitNodeGrid
  weak var breadboardView: BreadboardView!
  
  init(grid: CircuitNodeGrid, breadboardView: BreadboardView) {
    self.grid = grid
    self.breadboardView = breadboardView
    super.init(frame: CGRect(x: 0, y: 0, width: CGFloat(grid.width) * PlugView.plugSize, height: CGFloat(grid.height) * PlugView.plugSize))
    var point = CGPointZero
    for column in grid.columns {
      for node in column {
        let view = PlugView(node: node, breadboardView: breadboardView)
        view.frame.origin = point
        point.y += PlugView.plugSize
        self.addSubview(view)
      }
      point.x += PlugView.plugSize
      point.y = 0
    }
    backgroundColor = UIColor.clearColor()
  }
  
  func plugViewForPoint(point: CGPoint) -> PlugView? {
    let x = Int(point.x / PlugView.plugSize)
    let y = Int(point.y / PlugView.plugSize)
    let index = Int(x * Int(grid.height) + y)
    guard point.x >= 0 && x < Int(grid.width) && y >= 0 && y < Int(grid.height) && index < subviews.count else { return nil }
    return subviews[index] as? PlugView
  }
  
  override func drawRect(rect: CGRect) {
    guard grid.connectionType != .None else { return }
    let context = UIGraphicsGetCurrentContext()
    
    CGContextSetStrokeColorWithColor(context, UIColor(white: 0.85, alpha: 1.0).CGColor)
    CGContextSetLineWidth(context, 1)
    
    
    for i in 0 ..< (grid.connectionType == .Rows ? grid.height : grid.width) {
      let xOrY = (CGFloat(i) + 0.5) * PlugView.plugSize
      if grid.connectionType == .Rows {
        CGContextMoveToPoint(context, PlugView.plugSize / 2, xOrY)
        CGContextAddLineToPoint(context, (CGFloat(grid.width) - 0.5) * PlugView.plugSize, xOrY)
      } else {
        CGContextMoveToPoint(context, xOrY, PlugView.plugSize / 2)
        CGContextAddLineToPoint(context, xOrY, (CGFloat(grid.height) - 0.5) * PlugView.plugSize)
      }
      CGContextDrawPath(context, .Stroke)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
