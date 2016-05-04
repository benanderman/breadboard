//
//  PlugView.swift
//  Breadboard
//
//  Created by Ben Anderman on 5/3/16.
//  Copyright © 2016 Ben Anderman. All rights reserved.
//

import Foundation
import UIKit

class PlugView: UIView {
  static let plugSize = CGFloat(24)
  
  let node: CircuitNode
  
  var connectedComponent: ComponentView?
  
  init(node: CircuitNode) {
    self.node = node
    super.init(frame: CGRect(x: 0, y: 0, width: PlugView.plugSize, height: PlugView.plugSize))
    backgroundColor = UIColor.clearColor()
  }
  
  override func drawRect(rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()
    
    CGContextSetFillColorWithColor(context, UIColor(white: 0.9, alpha: 1.0).CGColor)
    CGContextSetStrokeColorWithColor(context, UIColor(white: 0.3, alpha: 1.0).CGColor)
    CGContextSetLineWidth(context, 2)
    
    let size = PlugView.plugSize
    let rect = CGRect(x: size / 4, y: size / 4, width: size / 2, height: size / 2)
    CGContextAddEllipseInRect(context, rect)
    CGContextDrawPath(context, .FillStroke)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
