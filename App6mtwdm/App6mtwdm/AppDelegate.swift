//
//  AppDelegate.swift
//  App6mtwdm
//
//  Created by Felipe Hernandez on 28/06/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa
import macOSThemeKit


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var userdefaults  = UserDefaults.standard
    
    var estaAutenticado =  false
    
    var window = NSApplication.shared.mainWindow?.windowController
    
    //var window = NSWindow()
    
    func MainStoryBoard() -> NSStoryboard {
        
        return NSStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func GetViewController(storyboard: NSStoryboard,
                           viewControllerName :String) -> NSViewController? {
        
        //Retorna la viewController mediante el identificador que le esta mandando
        //como parametro
        //Main, Chat o Login
        return (storyboard.instantiateController(withIdentifier:  viewControllerName) as? NSViewController)
        
    }
    
    func SetRootViewController(rootViewController:NSViewController?)  {
        
        //Se realiza la validacion si es diferente de nil o null
        if let aController = rootViewController {  //Login o Chat
            rootViewController?.presentAsModalWindow(aController)
        }
        
    }
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        InicializadorController()
    }

    
    func InicializadorController() {
        
        //Valida cual  es el tema elegido por el usuario antes de
        //ingresar al chat que usa Soket.iO
        
       // let tema = userdefaults.string(forKey: "Theme")!
        if let tema = userdefaults.string(forKey: "Theme") {
            
            if tema.contains("Luz") == true {
                ThemeManager.lightTheme.apply()
            }else if tema.contains("Oscuro") == true {
                ThemeManager.darkTheme.apply()
            }
            
        }
        
        
        
        //Valida el nombre del usuario que ingreso al chat
        //para redirecccionarlo al login o al chat como tal
        if userdefaults.string(forKey: "Usuario") != nil
        {
            estaAutenticado = true
        }else {
            estaAutenticado =  false
        }
        
        if estaAutenticado {
            
            let chatViewController =  GetViewController(storyboard: MainStoryBoard(), viewControllerName: "Chat")
            
            SetRootViewController(rootViewController: chatViewController)
            
        }else{
            
            let loginViewController =  GetViewController(storyboard: MainStoryBoard(), viewControllerName: "Login")
            
            SetRootViewController(rootViewController: loginViewController)
        }
        
    }
    
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

