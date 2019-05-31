//
//  Modelo.swift
//  App7mtwdm
//
//  Created by Felipe Hernandez on 20/07/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa

class Escuela: NSObject {
    let nombreEscuela: String
    let id: String
    var alumnos:[Alumnos] = []
    let icono:NSImage?
    
    init(nombreEscuela:String,icono:NSImage?, id:String) {
      self.nombreEscuela = nombreEscuela
      self.icono = icono
      self.id = id
    }
    
}

class Alumnos: NSObject {
  @objc  let nombre:String
  @objc  let id: String
  @objc  var materias:[Materias] = []
  @objc  let icono:NSImage?
  @objc  let idUniversidades: String
  @objc  let apellido: String
  @objc  let edad: Int
  @objc  let ciudad: String
    
    init (nombre:String,icono:NSImage?,id:String,idUniversidades:String,apellido: String,edad: Int,ciudad: String){
        self.nombre = nombre
        self.icono = icono
        self.id = id
        self.idUniversidades = idUniversidades
        self.apellido =  apellido
        self.edad = edad
        self.ciudad =  ciudad
    }
}

class Materias: NSObject {
    let nombreMateria:String
    let icono:NSImage?
    let id: String
    
    init(nombreMateria:String, icono:NSImage?, id: String) {
        self.nombreMateria = nombreMateria
        self.icono = icono
        self.id = id
    }
}
