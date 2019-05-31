//
//  ContenidoViewController.swift
//  App7mtwdm
//
//  Created by Felipe Hernandez on 20/07/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa

class ContenidoViewController: NSViewController {

    @IBOutlet weak var Contenedor: NSView!
    
    var viewController = NSViewController()
    
    let  appDelegate = NSApplication.shared.delegate as! AppDelegate
    
  /*  override func controlTextDidChange(_ obj: Notification) {
        
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(cargarViewController(notification:)), name: NSNotification.Name(rawValue: "click"), object: nil)
   
    }
    
  
    
    @objc func cargarViewController(notification: Notification){

        viewController = appDelegate.GetViewController(storyboard: appDelegate.MainStoryBoard(),viewControllerName: notification.object as! String)!
        
        Contenedor.addSubview(viewController.view)
    }
    
    
}
