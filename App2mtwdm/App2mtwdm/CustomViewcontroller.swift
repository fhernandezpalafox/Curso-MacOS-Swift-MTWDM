//
//  CustomViewcontroller.swift
//  App2mtwdm
//
//  Created by Felipe Hernandez on 08/06/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa

class CustomViewcontroller: NSViewController {

    
    var viewController  = ViewController()
    
    @IBOutlet weak var imagen: NSImageView!
    
    @IBOutlet weak var titulo: NSTextField!
    
    @IBOutlet weak var descripcion: NSTextField!
    
    
    @IBAction func onAceptar(_ sender: Any) {
        dismissViewController(self)
        
        viewController.mandarRespuesta(respuesta: "Aceptar")
    }
    
    
    @IBAction func onCancelar(_ sender: Any) {
        dismissViewController(self)
        
        viewController.mandarRespuesta(respuesta: "Cancelar")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        
        //Asignacion de los datos desde la creacion del NSViewController
        titulo.stringValue  = "Este es mi titulo"
        
        descripcion.stringValue  = "Esta es una descripcion larga"
        
        //Propiedades de los labels
        titulo.font = NSFont(name: "Herculam", size: 15)
        titulo.textColor = NSColor.white
        titulo.backgroundColor = NSColor.blue
        titulo.drawsBackground = true
        titulo.isSelectable = true
        
        
        //Cargar la Imagen
        let img = NSImage(named: NSImage.Name("informacion.png"))
        
        //Mostrar la imagen
        imagen.image = img
        
        //instancia de la clase
        //dialog = CustomViewController()
        
        //asignar el nombre de la ventana
        title = "Dialog"
        
        //Adaptar el contenido al label
        titulo.sizeToFit()
        
        descripcion.sizeToFit()
        
    }
    
    
    
    
}
