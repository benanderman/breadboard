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
  let hue: CGFloat
  var dead = false
  
  init(led: LED, breadboardView: BreadboardView?, hue: CGFloat = 0) {
    self.led = led
    self.hue = hue
    super.init(component: led, breadboardView: breadboardView)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(setNeedsDisplay), name: Breadboard.kCircuitUpdatedNotificationName, object: nil)
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func drawRect(rect: CGRect) {
    var brightness = CGFloat(0.4)
    if let breadboard = breadboardView?.breadboard where node1 != nil && node2 != nil {
      if breadboard.groundConnectedNodes.keys.contains(node1!.node) && breadboard.powerConnectedNodes.keys.contains(node2!.node) {
        let resistance = CGFloat(breadboard.groundConnectedNodes[node1!.node]! + breadboard.powerConnectedNodes[node2!.node]!)
        if resistance >= 100 {
          brightness += 0.6 * min(1 - (resistance - 99) / 1_000, 1)
        } else {
          dead = true
        }
      }
    }
    if dead {
      brightness = 0.2
    }
    let color = UIColor(hue: hue, saturation: 0.8, brightness: brightness, alpha: 1.0)
    drawWireWithMidsection(wireColor: UIColor.grayColor(), midSize: CGSize(width: 10, height: 10), midColor: color)
  }
}
