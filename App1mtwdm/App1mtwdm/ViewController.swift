//
//  ViewController.swift
//  App1mtwdm
//
//  Created by Felipe Hernandez on 01/06/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var lblSaludo: NSTextField!
    
    @IBOutlet weak var txtDato: NSTextField!
    
    @IBAction func onSaludar(_ sender: Any) {
        
        lblSaludo.stringValue = "Hola mundo 2"
        lblSaludo.sizeToFit()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        
        if segue.identifier?.rawValue == "segundaVentana"{
            
            let vc =  segue.destinationController as! SaludoViewController
            
            vc.datoRecibido = txtDato.stringValue
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

