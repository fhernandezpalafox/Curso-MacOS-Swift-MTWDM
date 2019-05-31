//
//  Persona.swift
//  App5mtwdm
//
//  Created by Felipe Hernandez on 22/06/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa

class Persona: NSObject {

   @objc  var Nombre:String = ""
   @objc  var ColorSeleccionado:NSColor = NSColor.black
   @objc  var Edad:Int32 = 0
   @objc  var EdoCivil:Int = 0
   @objc  var Escolaridad:Int = 0
    
   override init(){}
    
    init(_nombre:String, _ColorSeleccionado:NSColor,
         _edad:Int32, _EdoCivil:Int, _escolaridad:Int
         ) {
        Nombre  = _nombre
        ColorSeleccionado  = _ColorSeleccionado
        Edad = _edad
        EdoCivil = _EdoCivil
        Escolaridad = _escolaridad
    }
    
}
