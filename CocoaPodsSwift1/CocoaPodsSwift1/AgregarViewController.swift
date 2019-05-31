//
//  AgregarViewController.swift
//  CocoaPodsSwift1
//
//  Created by Felipe Hernandez on 07/06/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa
import Alamofire

class AgregarViewController: NSViewController {

    //Propiedades
    var viewController = ViewController()
    
    var categoria = Category()
    
    
    @IBOutlet weak var txtNombre: NSTextField!
    
    @IBOutlet weak var txtDescripcion: NSTextField!
    
    
    @IBAction func onGuardar(_ sender: Any) {
        
        guardar(nombre: txtNombre.stringValue, descripcion: txtDescripcion.stringValue)
        
        dismiss(self)
    }
    
    
    @IBAction func onEliminar(_ sender: Any) {
        
        EliminarDato(id: categoria.categoryID)
    }
    
    @IBAction func onModificar(_ sender: Any) {
        
        GuardarMofidicaciones()
    }
    
    let url =  "http://apiestudiosalle3.azurewebsites.net/v1/Categories/AddCategoryV1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        if  categoria != nil {
            
            txtDescripcion.stringValue  = categoria.descriptionApi
            
            txtNombre.stringValue  =  categoria.categoryName
        }
    }
    
    func GuardarMofidicaciones(){
        
        let urlModificar =  "http://apiestudiosalle3.azurewebsites.net/v1/Categories/UpdateCategory"
        
        let parametros: [String:Any] = [
            "CategoryID" : categoria.categoryID,
            "CategoryName" : txtNombre.stringValue,
            "Description":txtDescripcion.stringValue
        ]
        
        
        
        Alamofire.request(urlModificar,
                          method: HTTPMethod.put,
                          parameters: parametros,
                          encoding: JSONEncoding.default,
                          headers: nil).responseString { response in
                            
                            print(response.result.value)
                            
                            self.viewController.CargarInformacion()
                            
        }
    }
    
    func EliminarDato(id:Int){
         let urlEliminar =  "http://apiestudiosalle3.azurewebsites.net/v1/Categories/DeleteCategory/\(id)"
        
        Alamofire.request(urlEliminar,
                          method: HTTPMethod.delete,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil).responseString { response in
                            
                            print(response.result.value)
                            
                            self.viewController.CargarInformacion()
                            
        }
        
    }
    
    func guardar(nombre:String, descripcion:String) {
         
         let parametros: [String:Any] = [
         "CategoryID" : 0,
         "CategoryName" : nombre,
         "Description":descripcion
         ]
        
        
        
        Alamofire.request(url,
                          method: HTTPMethod.post,
                          parameters: parametros,
                          encoding: JSONEncoding.default,
                          headers: nil).responseString { response in
                            
                            print(response.result.value)
                            
                            self.viewController.CargarInformacion()
                            
        }
    }
    
 }

