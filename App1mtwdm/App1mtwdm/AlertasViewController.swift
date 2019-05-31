//
//  AlertasViewController.swift
//  App1mtwdm
//
//  Created by Felipe Hernandez on 08/06/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa

class AlertasViewController: NSViewController {

    @IBAction func onSalir(_ sender: Any) {
        dismiss(self)
    }
    
    @IBOutlet weak var txtMensaje: NSTextField!
    
    @IBAction func onAlerta1(_ sender: Any) {
        
        let alert = NSAlert()
        alert.addButton(withTitle: "Continuar")
        alert.addButton(withTitle: "Cancelar")
        alert.messageText = "Alerta sencilla"
        alert.informativeText = "Desea eliminar el registro seleccionado"
        alert.alertStyle = .warning //NSAlert.Style.warning  //.warning
        
        let res: NSApplication.ModalResponse = alert.runModal()
        
        //NSApplication.ModalResponse.alertFirstButtonReturn
        if res == .alertFirstButtonReturn {
            print("Continuar")
        }
        else if res == .alertSecondButtonReturn {
            print("Cancelar")
        }
        
    }
    
    @IBAction func onAlerta2(_ sender: Any) {
        
        let alert = NSAlert()
        alert.addButton(withTitle: "Continuar")
        alert.addButton(withTitle: "Cancelar")
        alert.messageText = "Alerta sencilla"
        alert.informativeText = "Desea eliminar el registro seleccionado"
        alert.alertStyle = .warning
        alert.beginSheetModal(for: view.window!, completionHandler: {(_ returnCode: NSApplication.ModalResponse) -> Void in
            if returnCode == .alertFirstButtonReturn {
                print("Boton continuar clickeado")
                self.txtMensaje.stringValue = "Boton continuar clickeado"
                
            }
            else if returnCode == .alertSecondButtonReturn {
                print("Boton de cancelar clickeado")
            }
        })
        
    }
    

    @IBAction func onAlerta3(_ sender: Any) {
        
        let alert = NSAlert()
        alert.addButton(withTitle: "Continuar")
        alert.messageText = "Alerta sencilla"
        alert.informativeText = txtMensaje.stringValue
        alert.alertStyle = .informational
        alert.runModal()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        txtMensaje.stringValue  = "Se ha realizado la operación correctamente"
    }
    
}
