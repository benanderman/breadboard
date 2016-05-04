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
    node1?.connectedComponent = self
    node2?.connectedComponent = self
  }
  
  func disconnect() {
    node1?.node.disconnect(component.node1)
    node2?.node.disconnect(component.node2)
    node1?.connectedComponent = nil
    node2?.connectedComponent = nil
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
  
  func drawWireWithMidsection(wireColor wireColor: UIColor, midSize: CGSize, midColor: UIColor) {
    let context = UIGraphicsGetCurrentContext()
    
    CGContextSetStrokeColorWithColor(context, wireColor.CGColor)
    CGContextSetLineWidth(context, 3)
    CGContextMoveToPoint(context, localPoint1.x, localPoint1.y)
    
    let width = localPoint2.x - localPoint1.x
    let height = localPoint2.y - localPoint1.y
    let length = sqrt(abs(width) * abs(width) + abs(height) * abs(height))
    let midPortion = midSize.width / length
    
    if midSize.width == 0 || length < midSize.width {
      CGContextAddLineToPoint(context, localPoint2.x, localPoint2.y)
      CGContextDrawPath(context, .Stroke)
    } else {
      let sidePortion = (0.5 - midPortion / 2)
      let midPoint1 = CGPoint(x: localPoint1.x + width * sidePortion, y: localPoint1.y + height * sidePortion)
      let midPoint2 = CGPoint(x: midPoint1.x + width * midPortion, y: midPoint1.y + height * midPortion)
      
      CGContextAddLineToPoint(context, midPoint1.x, midPoint1.y)
      CGContextDrawPath(context, .Stroke)
      
      CGContextMoveToPoint(context, midPoint1.x, midPoint1.y)
      CGContextSetStrokeColorWithColor(context, midColor.CGColor)
      CGContextSetLineWidth(context, midSize.height)
      CGContextAddLineToPoint(context, midPoint2.x, midPoint2.y)
      CGContextDrawPath(context, .Stroke)
      
      CGContextMoveToPoint(context, midPoint2.x, midPoint2.y)
      CGContextSetStrokeColorWithColor(context, wireColor.CGColor)
      CGContextSetLineWidth(context, 3)
      CGContextAddLineToPoint(context, localPoint2.x, localPoint2.y)
      CGContextDrawPath(context, .Stroke)
    }
  }
}
