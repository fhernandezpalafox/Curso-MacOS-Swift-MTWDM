//
//  AppDelegate.swift
//  App7mtwdm
//
//  Created by Felipe Hernandez on 13/07/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa
import macOSThemeKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification)
    {
        // Insert code here to initialize your application
        
        //Para aplicar el tema a nuestra aplicación
        ThemeManager.lightTheme.apply()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
    func MainStoryBoard() -> NSStoryboard {
        return NSStoryboard(name:  "Main", bundle: Bundle.main)
    }
    
    func GetViewController(storyboard: NSStoryboard,
                           viewControllerName :String) -> NSViewController? {
        
        //Retorna la viewController mediante el identificador que le esta mandando
        //como parametro
        
        //Main, ViewController o LoginViewController
        return (storyboard.instantiateController(withIdentifier:  viewControllerName) as? NSViewController)
        
        
    }

}

