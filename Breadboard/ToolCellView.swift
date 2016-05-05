//
//  ToolCellView.swift
//  Breadboard
//
//  Created by Ben Anderman on 5/4/16.
//  Copyright © 2016 Ben Anderman. All rights reserved.
//

import Foundation
import UIKit

class ToolCellView: UICollectionViewCell {
  override var selected: Bool {
    didSet {
      self.layer.borderWidth = selected ? 2 : 0
      self.layer.borderColor = UIColor.blackColor().CGColor
    }
  }
}
