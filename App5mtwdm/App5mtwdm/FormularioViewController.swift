//
//  FormularioViewController.swift
//  App5mtwdm
//
//  Created by Felipe Hernandez on 22/06/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa

class FormularioViewController: NSViewController {
    
    @IBOutlet weak var escolaridadSegmented: NSSegmentedControl!
    
    @IBOutlet weak var txtNombre: NSTextField!
    
    @IBOutlet weak var cmbEstadoCivil: NSComboBox!
    
    @IBOutlet weak var colorSelecionado: NSColorWell!
    
    @IBOutlet weak var sliderEdad: NSSlider!
    
    @IBOutlet weak var lblEdadSeleccionada: NSTextField!
    
    var viewController = ViewController()
    
    var esModificacion : Bool =  false
    
    var persona = Persona()
    
    var fila : Int = -1
    
    @IBAction func onCancelar(_ sender: Any) {
        CerrarPantalla()
    }
    
    
    @IBAction func onAceptar(_ sender: Any) {
        
        if esModificacion == false {
            
            let p = crearPersona();
            
            viewController.RecibirInformacion(person: p)
            
        }else {
            
             let p = crearPersona();
            
            viewController.RecibirInformacion(person: p,row: fila)
            
            
        }
      
        
       CerrarPantalla()
        
    }
    
    @IBAction func onCambiarEdad(_ sender: Any) {
        
        var msg : String = ""
        msg = "\(Constantes.MensajeLabel) \(sliderEdad.intValue)"
        lblEdadSeleccionada.stringValue = msg
        
        lblEdadSeleccionada.sizeToFit()
    }
    
    func CerrarPantalla() {
         dismissViewController(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        CargarDatosCombobox()
        
        if esModificacion == true {
             txtNombre.stringValue = persona.Nombre
             cmbEstadoCivil.selectItem(at: persona.EdoCivil)
             escolaridadSegmented.selectedSegment = persona.Escolaridad
             colorSelecionado.color = persona.ColorSeleccionado
             sliderEdad.intValue = persona.Edad
            
            var msg : String = ""
            msg = "\(Constantes.MensajeLabel) \(sliderEdad.intValue)"
            lblEdadSeleccionada.stringValue = msg
            
            lblEdadSeleccionada.sizeToFit()
        }
       
    }
    
    
    func CargarDatosCombobox() {
        //let EstadoCivil = ["Divorciado", "Otro"]
        cmbEstadoCivil.addItems(withObjectValues: Constantes.EstadoCivil);
    }
    
    func crearPersona() -> Persona {
        let persona =  Persona(_nombre: txtNombre.stringValue,
                               _ColorSeleccionado: colorSelecionado.color,
                               _edad: sliderEdad.intValue,
                               _EdoCivil: cmbEstadoCivil.indexOfSelectedItem,
                               _escolaridad: escolaridadSegmented.selectedSegment)
        return persona

    }
}
