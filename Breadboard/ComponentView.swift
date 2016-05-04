//
//  ComponentView.swift
//  Breadboard
//
//  Created by Ben Anderman on 5/3/16.
//  Copyright © 2016 Ben Anderman. All rights reserved.
//

import Foundation
import UIKit

class ComponentView: UIView {
  static let padding = CGFloat(5)
  
  let component: Component
  
  var node1: PlugView? {
    didSet {
      pointChanged()
    }
  }
  var node2: PlugView? {
    didSet {
      pointChanged()
    }
  }
  
  // These are for use with dragging, and will be replaced with the midpoint of
  // node1 and node2 if they aren't nil.
  var point1 = CGPointZero {
    didSet {
      guard point1 != oldValue else { return }
      pointChanged()
    }
  }
  var point2 = CGPointZero {
    didSet {
      guard point2 != oldValue else { return }
      pointChanged()
    }
  }
  
  var localPoint1 = CGPointZero
  var localPoint2 = CGPointZero
  
  init(component: Component) {
    self.component = component
    super.init(frame: CGRectZero)
    self.backgroundColor = UIColor.clearColor()
    self.userInteractionEnabled = false
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func connect() {
    node1?.node.connect(component.node1)
    node2?.node.connect(component.node2)
  }
  
  func disconnect() {
    node1?.node.disconnect(component.node1)
    node2?.node.disconnect(component.node2)
  }
  
  func pointChanged() {
    if let node = node1 {
      point1 = superview!.convertPoint(node.center, fromView: node.superview)
    }
    if let node = node2 {
      point2 = superview!.convertPoint(node.center, fromView: node.superview)
    }
    
    frame.origin.x = min(point1.x, point2.x) - ComponentView.padding
    frame.origin.y = min(point1.y, point2.y) - ComponentView.padding
    frame.size.width = max(point1.x, point2.x) - frame.origin.x + ComponentView.padding
    frame.size.height = max(point1.y, point2.y) - frame.origin.y + ComponentView.padding
    
    localPoint1 = self.convertPoint(point1, fromView: superview)
    localPoint2 = self.convertPoint(point2, fromView: superview)
    
    setNeedsDisplay()
  }
}
