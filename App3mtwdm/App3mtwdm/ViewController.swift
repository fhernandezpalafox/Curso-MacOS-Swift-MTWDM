//
//  ViewController.swift
//  App3mtwdm
//
//  Created by Felipe Hernandez on 15/06/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var ArregloNumeros : [String:Int32] = ["uno":1,"dos":2,"tres":3,"cuatro":4,"cinco":5,"seis":6,"siete":7,"ocho":8,"nueve":9]
    
    @IBOutlet weak var txtNumero1: NSTextField!
    
    @IBOutlet weak var txtNumero2: NSTextField!
    
    @IBOutlet weak var lblResultado: NSTextField!
    
    @IBAction func onOperacion(_ sender: NSButton) {
        
        var resultado : Int32 = 0
        
        //var f  = txtNumero1.doubleValue
        
        let cajaTexto1 : Int32  = convertir(txtNumero1.stringValue.lowercased())
        
        let cajaTexto2 : Int32 = convertir(txtNumero2.stringValue.lowercased())
        
        
        let boton = sender
        
        /*if boton.identifier?.rawValue  == "Sumar"{
            
        }*/
        
        if boton.title == "Sumar" {
             resultado  = cajaTexto1 + cajaTexto2
            
        }else if boton.title  == "Restar" {
             resultado  = cajaTexto1 - cajaTexto2
            
        }else if boton.title == "Multiplicar"{
             resultado  = cajaTexto1 * cajaTexto2
            
        }else if boton.title == "Dividir"{
             resultado  = cajaTexto1 / cajaTexto2
            
        }
        
        lblResultado.stringValue = "El resultado es \(resultado)"
        
    }
    
    func convertir(_ param: String) -> Int32 {
        
        var valor: Int32 = 0
        var paso: Bool = false
        
        for itemdiccionario in ArregloNumeros {
            if param == itemdiccionario.key {
                valor = itemdiccionario.value
                paso =  true
                break
            }
        }
        
        if paso == false {
            valor = Int32(param)!
        }
        
        return valor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

