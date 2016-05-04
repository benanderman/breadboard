//
//  WireView.swift
//  Breadboard
//
//  Created by Ben Anderman on 5/3/16.
//  Copyright © 2016 Ben Anderman. All rights reserved.
//

import Foundation
import UIKit

class WireView: ComponentView {
  let wire: Wire
  
  init(wire: Wire) {
    self.wire = wire
    super.init(frame: CGRectZero)
    self.backgroundColor = UIColor.clearColor()
    self.userInteractionEnabled = false
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func drawRect(rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()
    
    CGContextSetStrokeColorWithColor(context, UIColor.greenColor().CGColor)
    CGContextSetLineWidth(context, 3)
    
    CGContextMoveToPoint(context, localPoint1.x, localPoint1.y)
    CGContextAddLineToPoint(context, localPoint2.x, localPoint2.y)
    CGContextDrawPath(context, .Stroke)
  }
}
