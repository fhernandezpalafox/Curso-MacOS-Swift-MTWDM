//
//  ViewController.swift
//  App6mtwdm
//
//  Created by Felipe Hernandez on 28/06/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa
import macOSThemeKit

class ViewController: NSViewController {
 
    var userdefaults  = UserDefaults.standard
    
    @IBOutlet weak var txtNombre: NSTextField!
   
    @IBOutlet weak var cmbTheme: NSPopUpButton!
    
    @IBAction func onChangeTheme(_ sender: Any) {
       
        if cmbTheme.titleOfSelectedItem?.contains("Luz") ==  true {
            userdefaults.set(cmbTheme.titleOfSelectedItem, forKey: "Theme")
            //Theme->Luz u Oscuro
            //Usuario->Felipe,Oscar,Pedro
            ThemeManager.lightTheme.apply()
            
        }else if cmbTheme.titleOfSelectedItem?.contains("Oscuro") ==  true {
            userdefaults.set(cmbTheme.titleOfSelectedItem, forKey: "Theme")
            ThemeManager.darkTheme.apply()
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        /* let tema = userdefaults.string(forKey: "Theme")!
        if tema != nil {
            cmbTheme.selectItem(withTitle: tema)
        }*/
        
        if let tema = userdefaults.string(forKey: "Theme") {
            cmbTheme.selectItem(withTitle: tema)
        }
        
        
    }

    override func viewDidAppear() {
        self.view.window!.styleMask.remove(.fullScreen)
        self.view.window!.styleMask.remove(.resizable)
    }
    
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "chat" {
            let vc = segue.destinationController as! ChatViewController
             vc.nombre =  txtNombre.stringValue
            
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: NSStoryboardSegue.Identifier, sender: Any?) -> Bool {
        
        if identifier == "chat" {
            
            if txtNombre.stringValue.isEmpty == true{
                let alerta  =  NSAlert()
                alerta.addButton(withTitle: "Aceptar")
                alerta.messageText = "Validación"
                alerta.informativeText = "Captura un dato en la caja de texto"
                alerta.alertStyle = .informational
                alerta.runModal()
                return false
            }else
            {
                userdefaults.set(txtNombre.stringValue, forKey: "Usuario")
                self.view.window?.close()
                return true
            }
        }
        
        return true
    }

}

