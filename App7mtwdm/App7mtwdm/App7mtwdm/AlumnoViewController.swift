//
//  AlumnoViewController.swift
//  App7mtwdm
//
//  Created by Felipe Hernandez on 12/08/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa
import Alamofire


class AlumnoViewController: NSViewController {

    @IBOutlet weak var Tabla: NSTableView!
    let ip = "192.168.100.9" //"192.168.100.9"
    
    var listaAlumnos = [Alumnos]()
    var listaAlumnosPrincipal = [Alumnos]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        CargarAlumnos()
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldChange(notification:)),
                                               name: NSNotification.Name(rawValue: "textFieldChange"), object: nil)
    }
    
    @objc func textFieldChange(notification: Notification){
        
        let nombreBuscar = notification.object as! String
        
        let lst = self.listaAlumnos.filter{ $0.nombre.contains(nombreBuscar) == true   }
        
        if nombreBuscar == "" {
            listaAlumnos = listaAlumnosPrincipal
        }else {
            listaAlumnos = lst
        }

        Tabla.reloadData()
        
        //print(notification.object as! String)
        
    }
    
    func CargarAlumnos() {
        
        let url = "http://\(ip):3000/alumnos/v1/api/getAllAlumnos"
        
        Alamofire.request(url,
                          method: HTTPMethod.get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil).responseJSON { response in
                            
                            switch response.result {
                                
                            case .success:
                                if let result =  response.result.value {
                                    let JSON =  result as! Array<NSDictionary>
                                    
                                    for item in JSON {
                                        
                                        let obj = item as NSDictionary
                                        
                                        let alumno = Alumnos(nombre: obj["nombre"] as! String,
                                                             icono: NSImage (named: "Alumno"),
                                                             id:obj["_id"] as! String,
                                                             idUniversidades:obj["_idUniversidades"] as! String,apellido: obj["apellido"] as! String,edad: obj["edad"] as! Int,ciudad: obj["ciudad"] as! String)
                                        
                                        self.listaAlumnos.append(alumno)
                                        self.listaAlumnosPrincipal.append(alumno)
                                        //for (key, value) in obj {
                                        // }
                                        
                                    }
                                    print(JSON)
                                    
                                    self.Tabla.reloadData()
                                }
                                break
                            case .failure:
                                print("Algo salio mal")
                                break
                    }
            }
      }
    
}


extension AlumnoViewController : NSTableViewDataSource,NSTableViewDelegate {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return listaAlumnos.count
    }
    
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let myCell:NSTableCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: (tableColumn?.identifier.rawValue)!), owner: self) as! NSTableCellView
        
        let p: Alumnos? = listaAlumnos[row]
        
        let identifier : String =  tableColumn!.identifier.rawValue
        
        if identifier == "nombre" {
            
            myCell.textField?.stringValue = p?.value(forKey: identifier) as! String
            
        } else if identifier == "apellido" {
            
            myCell.textField?.stringValue = p?.value(forKey: identifier) as! String
            
        }else if identifier  == "edad" {
            
            myCell.textField?.intValue = Int32(p?.value(forKey: identifier) as! Int)
            
        } else if identifier == "ciudad" {
            
            myCell.textField?.stringValue = p?.value(forKey: identifier) as! String
            
        }

        
        return myCell
    }
    
    
    
}
