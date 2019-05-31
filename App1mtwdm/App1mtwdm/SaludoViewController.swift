//
//  SaludoViewController.swift
//  App1mtwdm
//
//  Created by Felipe Hernandez on 01/06/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa

class SaludoViewController: NSViewController {

    var datoRecibido : String  = ""
    
    @IBOutlet weak var lblDatoRecibido: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        lblDatoRecibido.stringValue  = " Este dato lo estoy recibiendo desde la otra view controller \(datoRecibido)"
        
        lblDatoRecibido.sizeToFit()
        
    }
    
    
    
    
    
    
    
}
