//
//  MenuViewController.swift
//  App7mtwdm
//
//  Created by Felipe Hernandez on 20/07/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa
import Alamofire


class MenuViewController: NSViewController {
    
    @IBOutlet weak var ListaMenu: NSOutlineView!
    
     //Listas
     var listaEscuela = [Escuela]()
     var listaAlumnos = [Alumnos]()
     var listaMaterias = [Materias]()
    
    let ip = "192.168.100.9" //"192.168.100.9"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        CargarUniversidades()

    }
    
    
    func CargarUniversidades() {
        
        let url = "http://\(ip):3000/otros/v1/api/getUniversidades"

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
                                        
                                        let escuela = Escuela(nombreEscuela: obj["nombre"] as! String,
                                                              icono: NSImage (named: "Escuela"),
                                                              id:obj["_id"] as! String)
                                     
                                        self.listaEscuela.append(escuela)
                                        
                                        //for (key, value) in obj {
                                        // }
                                        
                                    }
                                    
                                    print(JSON)

                                    self.ListaMenu.reloadData()
                                    
                                    self.ListaMenu?.expandItem(nil, expandChildren: true)
                                    
                                    self.CargarAlumnos()
                                }
                                break
                            case .failure:
                                print("Algo salio mal")
                                break
                            }
            }
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
                                        
                                        //for (key, value) in obj {
                                        // }
                                        
                                    }
                                    print(JSON)
                                        
                                   
                                    //Agregar items de alumnos
                                    for item in self.listaAlumnos{
                                        
                                        for escuela in self.listaEscuela{
                                            
                                            if escuela.id.contains(item.idUniversidades){
                                                escuela.alumnos.append(item)
                                            }
                                        }
                                        
                                    }
                                    
                                    self.ListaMenu.reloadData()
                                    
                                    self.ListaMenu?.expandItem(nil, expandChildren: true)
                                    
                                    self.CargarMaterias()
                                }
                                break
                            case .failure:
                                print("Algo salio mal")
                                break
                            }
            }
    }
    
    
    func CargarMaterias() {
        
        let url = "http://\(ip):3000/otros/v1/api/getMateriasAlumnos"
        
        Alamofire.request(url,
                          method: HTTPMethod.get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil).responseJSON { response in
                            
                            switch response.result {
                                
                            case .success:
                                if let result =  response.result.value {
                                    
                                    //Obtiene todo el JSON de la API consultada
                                    let JSON =  result as! Array<NSDictionary>
                                    
                                    //Se realiza la iteracción para obtener todos los nodos
                                    for item in JSON {
                                        
                                        let obj = item as NSDictionary
                                        
                                        //Se obtiene el idAlumno y IdMateria
                                        let idAlumno = obj["idAlumno"] as! String
                                        let idMateria =  obj["idMateria"] as! String
                                        
                                        //Obtiene la materia con su correspondiente materia
                                        if let nombreMateria = obj["dbmateria"] {
                                            
                                            //Contiene toda la informacion de dbmateria _id, nombre
                                            let nombreMateria2 = nombreMateria as! Array<NSDictionary>
                                            
                                            //Verifica que si tenga elementos
                                            if nombreMateria2.count > 0 {
                                                
                                                //Obtiene los elementos del nodo de dbmateria
                                                for  materia in nombreMateria2 {
                                                    
                                                    let nomMate = materia["nombre"] as! String
                                                    let idMater  =  materia["_id"] as! String
                                                    
                                                    let objMateria = Materias(nombreMateria: nomMate, icono: NSImage (named: "Materia"),id: idMater)
                                                    
                                                  
                                                    self.listaMaterias.append(objMateria)

                                                }
                                                
                                                //Agregar items de alumnos
                                                for item in self.listaAlumnos{
                                                    
                                                    for materia in self.listaMaterias{
                                                        
                                                        if idMateria.contains(materia.id) && idAlumno.contains(item.id){
                                                            item.materias.append(materia)
                                                        }
                                                    }
                                                    
                                                }
                                                
                                            }
                                        }
                                    }
                                    print(JSON)
                                    
                                    self.ListaMenu.reloadData()
                                    
                                    self.ListaMenu?.expandItem(nil, expandChildren: true)
                                    
                                }
                                break
                            case .failure:
                                print("Algo salio mal")
                                break
                            }
             }
      }
    
}

extension MenuViewController: NSOutlineViewDataSource{
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        
        if let _item = item as Any? {
            
            switch _item {
            case let escuela as Escuela:
                return escuela.alumnos.count
            case let  alumno as Alumnos:
                return alumno.materias.count
            default:
                return 0
            }
            
        } else {
            return listaEscuela.count
        }
    }
    
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        
        switch item {
        case let escuela as Escuela:
            return (escuela.alumnos.count > 0) ? true : false
        case let alumno as Alumnos:
            return (alumno.materias.count > 0) ? true : false
        default:
            return false
        }
        
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if let _item = item as Any? {
            switch _item {
            case let escuela as Escuela:
                return escuela.alumnos[index]
            case let alumno as Alumnos:
                return alumno.materias[index]
            default:
                return self
            }
        } else {
            if !listaEscuela.isEmpty {
                return listaEscuela[index]
            }else {
                 return self
            }
        }
    }
}

extension MenuViewController: NSOutlineViewDelegate{
    
    func outlineViewSelectionDidChange(_ notification: Notification) {
        
        guard let outlineView = notification.object as? NSOutlineView else {
            return
        }
        
        let selectedIndex = outlineView.selectedRow
        
        if let objectEmpleado = outlineView.item(atRow: selectedIndex) as? Alumnos {
            
            print("selected Object is an Employee " +  objectEmpleado.nombre)
            //self.txtNombre?.stringValue = objectEmpleado.nombre
            //self.txtApellido?.stringValue = objectEmpleado.apellido
            //self.txtCorreo?.stringValue = objectEmpleado.correo
        }
        else{
            print("Do nothing on Department or Account Selection")
        }
    }
    
    func outlineView(_ outlineView: NSOutlineView, isGroupItem item: Any) -> Bool {
        
        switch item {
        case _ as Escuela: //case let escuela as Escuela:
            return true
        default:
            return false
        }
    }
    
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        
        switch item {
        case let escuela as Escuela:
            let view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "DataCell"), owner: self) as! NSTableCellView
            if let textField = view.textField {
                textField.stringValue = escuela.nombreEscuela
            }
            if let image = escuela.icono {
                view.imageView!.image = image
            }
            return view
        case let alumno as Alumnos:
            let view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "DataCell"), owner: self) as! NSTableCellView
            if let textField = view.textField {
                textField.stringValue = alumno.nombre
            }
            if let image = alumno.icono {
                view.imageView!.image = image
            }
            return view
        case let materia as Materias:
            let view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "DataCell"), owner: self) as! NSTableCellView
            if let textField = view.textField {
                textField.stringValue = materia.nombreMateria
            }
            if let image = materia.icono {
                view.imageView!.image = image
            }
            return view
        default:
            return nil
        }
    }
}
