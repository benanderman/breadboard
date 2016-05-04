//
//  ResistorView.swift
//  Breadboard
//
//  Created by Ben Anderman on 5/4/16.
//  Copyright © 2016 Ben Anderman. All rights reserved.
//

import Foundation
import UIKit

class ResistorView: ComponentView {
  let resistor: Resistor
  
  init(resistor: Resistor, breadboardView: BreadboardView?) {
    self.resistor = resistor
    super.init(component: resistor, breadboardView: breadboardView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func drawRect(rect: CGRect) {
    drawWireWithMidsection(wireColor: UIColor.grayColor(), midSize: CGSize(width: 20, height: 8), midColor: UIColor.brownColor())
  }
}
