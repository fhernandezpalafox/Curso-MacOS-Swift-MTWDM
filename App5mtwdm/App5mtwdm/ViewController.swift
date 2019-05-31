//
//  ViewController.swift
//  App5mtwdm
//
//  Created by Felipe Hernandez on 22/06/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
 var lista = [Persona]()
    
 var alertaPersonalizada = AlertaPersonalizada()
    
 @IBOutlet weak var Tabla: NSTableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onEliminar(_ sender: Any) {
       
            let row = Tabla.selectedRow
            
            if  row == -1  {
                print("Selecciona un registro, por favor")
               let respuesta =  alertaPersonalizada.alerta(_titulo: "Eliminar",
                                           _mensaje: "Selecciona un registro, por favor",
                                           _tipoMsg: .Alert, //AlertaPersonalizada.TiposMensaje.Alert
                                           _mostrarMsg: .Modal) //AlertaPersonalizada.MostrarMensaje.Modal
                print(respuesta)
            }else {
               lista.remove(at: row)
               Tabla.reloadData()
            }
            
        
    }
    
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

     //Agregar  o Editar
    func RecibirInformacion(person: Persona,row : Int = -1)  {
        
        if row != -1 {
            
            lista.remove(at: row)
            
            lista.append(person)
        }else {
            
            //Agregamos la lista
            lista.append(person)
            
        }
        
        //Tabla refrescar
        CargarDatos()
 
    }
    
    func CargarDatos() {
        
        //Resfrescar la tabla
        Tabla.reloadData()
    }
    
    
    
    override func shouldPerformSegue(withIdentifier identifier: NSStoryboardSegue.Identifier, sender: Any?) -> Bool {
        
        if identifier.rawValue == "agregar" {
            return true
        }else if identifier.rawValue == "editar"{

                let row = Tabla.selectedRow
                
                if  row == -1  {
                    print("Selecciona un registro, por favor")
                    let respuesta =  alertaPersonalizada.alerta(_titulo: "Editar",
                                                                _mensaje: "Selecciona un registro, por favor",
                                                                _tipoMsg: .Alert, //AlertaPersonalizada.TiposMensaje.Alert
                                                                _mostrarMsg: .Modal) //AlertaPersonalizada.MostrarMensaje.Modal
                    print(respuesta)
                    return false
                }else {
                    return true
                }
          
        }
        
        return true
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        
        if segue.identifier?.rawValue == "agregar"{
            let vc  = segue.destinationController as! FormularioViewController
            vc.viewController  =  self
            vc.esModificacion = false
            
        }else if segue.identifier?.rawValue == "editar"{
            let vc  = segue.destinationController as! FormularioViewController
            vc.viewController  =  self
            vc.esModificacion = true
            
            let row = Tabla.selectedRow
            let p = lista[row]
            vc.persona = p
            vc.fila =  row
            
        }
        
    }

}

extension ViewController : NSTableViewDataSource,NSTableViewDelegate {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return lista.count
    }
    
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let myCell:NSTableCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: (tableColumn?.identifier.rawValue)!), owner: self) as! NSTableCellView
        
        let p: Persona? = lista[row]
        
        let identifier : String =  tableColumn!.identifier.rawValue
        
        if identifier == "Nombre" {
            
            myCell.textField?.stringValue = p?.value(forKey: identifier) as! String
            
        } else if identifier == "Escolaridad" {
            
            myCell.textField?.stringValue = Constantes.Escolaridad[(p?.value(forKey: identifier) as! Int)]!
            
        }else if identifier  == "EdoCivil" {
            
            myCell.textField?.stringValue = Constantes.estadoCivil[(p?.value(forKey: identifier) as! Int)]!
        }
        
        myCell.textField?.textColor = p?.ColorSeleccionado

        return myCell
    }
    
    
    
}







