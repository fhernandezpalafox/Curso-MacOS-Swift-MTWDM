//
//  MenuToolbarViewController.swift
//  App7mtwdm
//
//  Created by Felipe Hernandez on 12/08/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa

class MenuToolbarViewController: NSViewController {

    let  appDelegate = NSApplication.shared.delegate as! AppDelegate
    
    
    @IBAction func onCargarAlumnos(_ sender: Any) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "click"), object: "FormularioAlumnos")
        
        dismiss(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
