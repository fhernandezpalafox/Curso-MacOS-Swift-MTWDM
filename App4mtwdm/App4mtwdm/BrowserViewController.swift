//
//  BrowserViewController.swift
//  App4mtwdm
//
//  Created by Felipe Hernandez on 22/06/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa
import WebKit

class BrowserViewController: NSViewController, WKNavigationDelegate {

    var objPersona = Persona()
    
    @IBOutlet weak var indicador: NSProgressIndicator!
    
    @IBOutlet weak var Navegador: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let urlPerfil  = objPersona.Perfil
        
        let url  =  URL(string: urlPerfil)
        
        let request  =  URLRequest(url: url!)
        
        Navegador.load(request)
        
        indicador.isHidden =  true
        
        Navegador.navigationDelegate =  self
        
    }
    
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
        indicador.isHidden =  false
        indicador.startAnimation(self)
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        indicador.isHidden =  true
        indicador.stopAnimation(self)
        
    }
    
}










