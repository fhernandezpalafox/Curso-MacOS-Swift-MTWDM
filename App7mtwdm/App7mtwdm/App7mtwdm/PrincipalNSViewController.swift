//
//  PrincipalNSViewController.swift
//  App7mtwdm
//
//  Created by Felipe Hernandez on 20/07/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa

class PrincipalNSViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewDidAppear() {
        self.view.window!.styleMask.remove(.fullScreen)
        self.view.window!.styleMask.remove(.resizable)
    }
    
}
