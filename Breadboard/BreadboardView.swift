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
  
  var selectedTool = "Wire"
  
  var pendingComponentView: ComponentView?
  
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
  
  func plugViewForPoint(point: CGPoint) -> PlugView? {
    for view in subviews {
      guard let gridView = view as? CircuitGridView else { continue }
      let plugView = gridView.plugViewForPoint(gridView.convertPoint(point, fromView: self))
      if plugView != nil {
        return plugView
      }
    }
    return nil
  }
  
  func componentViewForTool(tool: String) -> ComponentView {
    switch tool {
    case "Wire":
      return WireView(wire: Wire())
    case "Resistor":
      return ResistorView(resistor: Resistor())
    case "LED":
      return LEDView(led: LED())
    default:
      return WireView(wire: Wire())
    }
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    guard touches.count == 1 && pendingComponentView == nil else { return }
    guard let plugView = touches.first!.view as? PlugView else { return}
    
    let componentView = componentViewForTool(selectedTool)
    pendingComponentView = componentView
    addSubview(componentView)
    pendingComponentView?.node1 = plugView
    pendingComponentView?.point2 = touches.first!.locationInView(self)
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    guard touches.count == 1 && pendingComponentView != nil else { return }
    let point = touches.first!.locationInView(self)
    if let plugView = plugViewForPoint(point) {
      pendingComponentView?.node2 = plugView
    } else {
      pendingComponentView?.node2 = nil
      pendingComponentView?.point2 = touches.first!.locationInView(self)
    }
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    if let view = pendingComponentView {
      if view.node2 == nil {
        pendingComponentView?.removeFromSuperview()
      }
    }
    pendingComponentView?.connect()
    pendingComponentView = nil
  }
  
  override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
    pendingComponentView?.removeFromSuperview()
    pendingComponentView = nil
  }
}
