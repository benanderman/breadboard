//
//  ViewController.swift
//  Breadboard
//
//  Created by Ben Anderman on 5/2/16.
//  Copyright © 2016 Ben Anderman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  @IBOutlet weak var breadboardContainerView: UIView!
  
  var breadboard: Breadboard!
  var breadboardView: BreadboardView!
  
  let toolIDs = ["Wire", "Resistor", "LED"]
  
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

  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(toolIDs[indexPath.item], forIndexPath: indexPath)
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let tool = toolIDs[indexPath.item]
    breadboardView.selectedTool = tool
  }
}

