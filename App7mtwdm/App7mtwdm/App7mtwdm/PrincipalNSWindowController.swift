//
//  PrincipalNSWindowController.swift
//  App7mtwdm
//
//  Created by Felipe Hernandez on 15/08/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa

class PrincipalNSWindowController: NSWindowController {

    @IBOutlet weak var searchField: NSSearchField!
    
    
    @IBAction func onBuscar(_ sender: Any) {
        
          NotificationCenter.default.post(name: NSNotification.Name(rawValue:"textFieldChange"), object: searchField.stringValue)
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        
    }

}
