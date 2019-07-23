//
//  CustomCell.swift
//  App6mtwdm
//
//  Created by Felipe Hernandez on 06/07/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa

class CustomCell: NSTableCellView {

    var viewController =  NSViewController()
    var Fila: Int = 0
    
    @IBOutlet weak var HeightMensaje: NSLayoutConstraint!
    @IBOutlet weak var ImagenIn: NSImageView!
    @IBOutlet weak var ImagenOut: NSImageView!
    @IBOutlet weak var Mensaje: NSTextField!
}
