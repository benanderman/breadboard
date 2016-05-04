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
  var draggingPoint = 2 // Which point on the pendingComponentView we're dragging; 1 or 2
  
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
  
  static func componentViewForTool(tool: String) -> ComponentView {
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
    let point = touches.first!.locationInView(self)
    guard let plugView = plugViewForPoint(point) else { return}
    
    var componentView = plugView.connectedComponent
    if let view = componentView {
      draggingPoint = view.node1 === plugView ? 1 : 2
      view.disconnect()
    } else {
      draggingPoint = 2
      componentView = BreadboardView.componentViewForTool(selectedTool)
      addSubview(componentView!)
      componentView?.node1 = plugView
      componentView?.point2 = point
    }
    pendingComponentView = componentView
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    guard let view = pendingComponentView where touches.count == 1 else { return }
    let point = touches.first!.locationInView(self)
    var newNode: PlugView? = nil
    if let plugView = plugViewForPoint(point) {
      if plugView !== (draggingPoint == 1 ? view.node2 : view.node1) && plugView.connectedComponent == nil {
        newNode = plugView
      }
    }
    if draggingPoint == 1 {
      view.node1 = newNode
      view.point1 = point
    } else {
      view.node2 = newNode
      view.point2 = point
    }
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    if let view = pendingComponentView {
      if view.node1 != nil && view.node2 != nil {
        pendingComponentView?.connect()
      } else {
        pendingComponentView?.removeFromSuperview()
      }
      pendingComponentView = nil
    }
  }
  
  override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
    pendingComponentView?.removeFromSuperview()
    pendingComponentView = nil
  }
}
