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
  weak var breadboardView: BreadboardView!
  
  var connectedComponent: ComponentView?
  
  init(node: CircuitNode, breadboardView: BreadboardView) {
    self.node = node
    self.breadboardView = breadboardView
    super.init(frame: CGRect(x: 0, y: 0, width: PlugView.plugSize, height: PlugView.plugSize))
    backgroundColor = UIColor.clearColor()
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(setNeedsDisplay), name: Breadboard.kCircuitUpdatedNotificationName, object: nil)
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  override func drawRect(rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()
    
    let powered = breadboardView.breadboard.powerConnectedNodes.keys.contains(node) ? CGFloat(0.2) : 0
    let grounded = breadboardView.breadboard.groundConnectedNodes.keys.contains(node) ? CGFloat(0.2) : 0
    let fillColor = UIColor(red: 0.8 + powered, green: 0.8, blue: 0.8 + grounded, alpha: 1.0)
    CGContextSetFillColorWithColor(context, fillColor.CGColor)
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
