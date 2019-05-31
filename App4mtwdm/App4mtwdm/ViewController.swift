//
//  ViewController.swift
//  App4mtwdm
//
//  Created by Felipe Hernandez on 15/06/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    var lista = [Persona]()
    //var lista = [Any]()
    
    @IBOutlet weak var txtNombre: NSTextField!
    
    @IBOutlet weak var txtDomicilio: NSTextField!
    
    @IBOutlet weak var txtPerfilface: NSTextField!
    
    @IBOutlet weak var chkEdoCivil: NSButton!
    
    @IBOutlet weak var Tabla: NSTableView!
    
    
    var objPersona = Persona()
    
    @IBAction func onMostrar(_ sender: Any) {
        
        let row: Int =  self.Tabla.selectedRow
        
        if row != -1 {
            
            objPersona  = lista[row]
            
        }else {
            print("Error")
        }
        
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        
        if segue.identifier?.rawValue  == "mostrar1"{
            
            let row: Int =  self.Tabla.selectedRow
            
            if row != -1 {
                
                objPersona  = lista[row]
                
                var vc = segue.destinationController as! BrowserViewController
                vc.objPersona  = objPersona
                
            }else {
                print("Error")
            }
            
            
          
        }
    }
    
    
    @IBAction func onAgregar(_ sender: Any) {
        
        let p = Persona()
        
        p.Nombre = txtNombre.stringValue
        p.Domicilio = txtDomicilio.stringValue
        p.EdoCivil =  Int(chkEdoCivil.intValue)
        p.Perfil  = txtPerfilface.stringValue
        
        
        lista.append(p)
        
        Tabla.reloadData()
        
        
        //limpiar las cajas
        txtNombre.stringValue = ""
        txtDomicilio.stringValue = ""
        chkEdoCivil.intValue = 0
        //chkEdoCivil.state = NSControl.StateValue(rawValue: 0) //=0
        txtPerfilface.stringValue = ""
        
    }
    
    @IBAction func onEliminar(_ sender: Any) {
        
        let row: Int =  self.Tabla.selectedRow
        
        if row != -1 {
            lista.remove(at: row)
            Tabla.reloadData()
        }else {
            print("Error")
            
            let alert  = NSAlert()
            alert.addButton(withTitle: "Cerrar")
            alert.messageText = "Error"
            alert.informativeText = "Hubo un error al eliminar"
            alert.runModal()
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let p = Persona()
        p.Nombre = "Felipe"
        p.Domicilio = "Betania #1616 col san felipe"
        p.EdoCivil = 1
        p.Perfil = "http://facebook.com.mx/"
        
        lista.append(p)
        
        //Recargar la tabla
        Tabla.reloadData()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return lista.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        
        let p: Persona? = lista[row]
        
        let identifier : String =  tableColumn!.identifier.rawValue
        
        let columna = p?.value(forKey: identifier)
        
        return columna
        
    }
    
    
    /*func tableViewSelectionDidChange(_ notification: Notification) {
        
        print(notification)
        print("Se le dio click")
    }*/
    
    
    


}






