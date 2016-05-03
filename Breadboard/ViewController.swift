//
//  ViewController.swift
//  Breadboard
//
//  Created by Ben Anderman on 5/2/16.
//  Copyright © 2016 Ben Anderman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var breadboardContainerView: UIView!
  
  var breadboard: Breadboard!
  var breadboardView: BreadboardView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(animated: Bool) {
    let size = breadboardContainerView.frame.size
    breadboard = Breadboard(width: UInt(size.width / PlugView.plugSize), height: UInt(size.height / PlugView.plugSize))
    breadboardView = BreadboardView(breadboard: breadboard)
    breadboardContainerView.addSubview(breadboardView)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

