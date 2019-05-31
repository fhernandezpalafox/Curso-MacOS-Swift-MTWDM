//
//  AlertaPersonalizada.swift
//  App5mtwdm
//
//  Created by Felipe Hernandez on 27/06/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa

class AlertaPersonalizada: NSObject {

    //Se declara un NSViewController
    var viewController = NSViewController()
    
    var respuestaAlerta: Bool =  false
    
    enum TiposMensaje {
        case Custom, Alert
    }
    
    enum MostrarMensaje {
        case Modal,Sheet
    }
    
    var Titulo: String = ""
    
    var Mensaje: String = ""
    
    
    func alerta(_titulo:String, _mensaje:String, _tipoMsg:TiposMensaje, _mostrarMsg:MostrarMensaje) -> Bool{
        
        if _tipoMsg.hashValue == TiposMensaje.Alert.hashValue {
            
            let alert =  NSAlert()
            alert.addButton(withTitle: "Aceptar")
            alert.addButton(withTitle: "Cancelar")
            alert.messageText = _titulo
            alert.informativeText = _mensaje
            alert.alertStyle = .warning
            
            if _mostrarMsg.hashValue == MostrarMensaje.Modal.hashValue {
                
                let res: NSApplication.ModalResponse = alert.runModal()
                
                if res == .alertFirstButtonReturn{
                    self.respuestaAlerta = true
                }else if res == .alertSecondButtonReturn{
                    self.respuestaAlerta =  false
                }
                
            }else if _mostrarMsg.hashValue == MostrarMensaje.Sheet.hashValue {
                
                alert.beginSheetModal(for: viewController.view.window!,
                                      completionHandler: {(_ returnCode: NSApplication.ModalResponse) -> Void in
                   
                    if returnCode == .alertFirstButtonReturn{
                        self.respuestaAlerta = true
                    }else if returnCode == .alertSecondButtonReturn{
                        self.respuestaAlerta =  false
                    }
                    
                })
            }
        }else if _tipoMsg.hashValue == TiposMensaje.Custom.hashValue{
            
            //Esto lo vamos hacer de practica #1
        }
        
        return respuestaAlerta
        
    }
}









