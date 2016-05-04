//
//  LEDView.swift
//  Breadboard
//
//  Created by Ben Anderman on 5/4/16.
//  Copyright © 2016 Ben Anderman. All rights reserved.
//

import Foundation
import UIKit

class LEDView: ComponentView {
  let led: LED
  
  init(led: LED) {
    self.led = led
    super.init(component: led)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func drawRect(rect: CGRect) {
    drawWireWithMidsection(wireColor: UIColor.grayColor(), midSize: CGSize(width: 10, height: 10), midColor: UIColor.cyanColor())
  }
}
