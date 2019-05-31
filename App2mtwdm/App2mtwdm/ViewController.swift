//
//  ViewController.swift
//  App2mtwdm
//
//  Created by Felipe Hernandez on 08/06/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    
    
    @IBOutlet var lblRespuesta2: NSTouchBarItem!
    
    @IBOutlet weak var lblRespuesta: NSTextField!
    
    
    func mandarRespuesta(respuesta:String) {
        
        lblRespuesta.stringValue  = respuesta
        lblRespuesta.sizeToFit()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        
        if segue.identifier?.rawValue == "custom" {
            
            let vc  =  segue.destinationController as! CustomViewcontroller
            vc.viewController  =  self
            
        }
        
    }


}

