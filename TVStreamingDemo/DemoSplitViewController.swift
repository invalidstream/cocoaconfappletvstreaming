//
//  DemoSplitViewController.swift
//  TVStreamingDemo
//
//  Created by Chris Adamson on 9/8/16.
//  Copyright © 2016 Subsequently & Furthermore, Inc. All rights reserved.
//

import UIKit

class DemoSplitViewController: UISplitViewController {
    
    // FOCUS STUFF IS ALL FROM APPLE'S UIKitCatalog SAMPLE CODE
    
    /**
     Set to true from `updateFocusToDetailViewController()` to indicate that
     the detail view controller should be the preferred focused view when
     this view controller is next queried.
     */
    private var preferDetailViewControllerOnNextFocusUpdate = false
    
    // MARK: UIFocusEnvironment
    
    override var preferredFocusedView: UIView? {
        let preferredFocusedView: UIView?
        
        // TODO: clean up focus API deprecations
        
        /*
         Check if a request has been made to move the focus to the detail
         view controller.
         */
        if preferDetailViewControllerOnNextFocusUpdate {
            preferredFocusedView = viewControllers.last?.preferredFocusedView
            preferDetailViewControllerOnNextFocusUpdate = false
        }
        else {
            preferredFocusedView = super.preferredFocusedView
        }
        
        return preferredFocusedView
    }
    
    // MARK: Focus helpers
    
    /**
     Called from a containing `MenuTableViewController` whenever the user
     selects a table view row in a master view controller.
     */
    func updateFocusToDetailViewController() {
        preferDetailViewControllerOnNextFocusUpdate = true
        
        /*
         Trigger the focus system to re-query the view hierarchy for preferred
         focused views.
         */
        setNeedsFocusUpdate()
        updateFocusIfNeeded()
    }
}

