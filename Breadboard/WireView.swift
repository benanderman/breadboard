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
    super.init(component: wire)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func drawRect(rect: CGRect) {
    drawWireWithMidsection(wireColor: UIColor.greenColor(), midSize: CGSizeZero, midColor: UIColor.greenColor())
  }
}
