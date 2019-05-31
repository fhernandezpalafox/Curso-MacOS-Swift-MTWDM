//
//  ChatViewController.swift
//  App6mtwdm
//
//  Created by Felipe Hernandez on 28/06/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa
import SocketIO
import macOSThemeKit

class ChatViewController: NSViewController {

    var heightRow:Int = 30
    
    var lista = [Mensaje]()
    
    var userdefaults  = UserDefaults.standard
    
    let  appDelegate = NSApplication.shared.delegate as! AppDelegate
    
    
    @IBAction func onSalir(_ sender: Any) {
     
        let socket = manager.defaultSocket
        
         socket.disconnect()
        
         userdefaults.removeObject(forKey: "Usuario")
        
         appDelegate.InicializadorController()
        
         self.view.window?.close()
        
    }
    
    @IBOutlet weak var Tabla: NSTableView!

   let manager  =  SocketManager(socketURL: URL(string: "https://socket-io-chat.now.sh/")!, config: [.log(true), .compress])
    
  
    
    var nombre : String = ""
    
    var numeroUsuarios = 0
    
    @IBOutlet weak var lblNombre: NSTextField!
    
    @IBOutlet weak var txtMensaje: NSTextField!
    
    @IBAction func onEnviar(_ sender: Any) {
      let socket = manager.defaultSocket
        
        //print(socket.status)
        socket.emit("new message",txtMensaje.stringValue)
        
        let m  = Mensaje()
        m.Msg = "\(lblNombre.stringValue) : \(txtMensaje.stringValue)"
        m.tipoMsg =  Constantes.TipoMensaje.Saliente
        
        self.lista.append(m)
        self.Tabla.reloadData()
        
        txtMensaje.stringValue =  ""
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        lblNombre.stringValue =  userdefaults.string(forKey: "Usuario")!
        
        funcionesSocket()
        
    }
    
    override func viewDidAppear() {
        self.view.window!.styleMask.remove(.fullScreen)
        self.view.window!.styleMask.remove(.resizable)
    }
    
    
    
    func funcionesSocket() {
        let socket = manager.defaultSocket
        
        socket.connect()
        
        socket.on(clientEvent: .connect) { data, ack in
            socket.emit("add user", self.lblNombre.stringValue)
        }
        
        print(socket.status)
        
      
        socket.emit("new message",txtMensaje.stringValue)
  
     
        
        socket.on("new message"){ data, ack in
            print(data)
            
            let respuesta  = data as! Array<NSDictionary>
            
            var usuario : String = ""
            var mensaje : String = ""
            
            for datos in respuesta {
                usuario = datos.value(forKey: "username")! as! String
                mensaje = datos.value(forKey: "message") as! String
            }
            
            let m  = Mensaje()
            m.Msg = "\(usuario) : \(mensaje)"
            m.tipoMsg =  Constantes.TipoMensaje.Entrante
            
            self.lista.append(m)
            self.Tabla.reloadData()
        }
        
        socket.on("add user"){ data, ack in
            let respuesta  = data as! Array<NSDictionary>
            socket.emit("login", CustomDataUsers(numUsers: 0))
            
        }

       
    }
    
    struct CustomDataUsers : SocketData {
        let numUsers : Int
        
        func socketRepresentation() -> SocketData {
            return ["numUsers", numUsers]
        }
    }
    
    struct CustomDataMsg : SocketData {
       let message: String
        
        func socketRepresentation() -> SocketData {
            return [message]
        }
    }
    
    
    class Datos: NSObject {
         @objc var username:String = ""
         @objc var message:String = ""
        
    }
}

extension ChatViewController : NSTableViewDataSource,NSTableViewDelegate {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return lista.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let result:CustomCell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "defaultRow"), owner: self) as! CustomCell
        
        result.viewController =  self
        result.Fila = row
        
        
        let Msg: Mensaje? = lista[row]
        
        if Msg?.tipoMsg.hashValue == Constantes.TipoMensaje.Entrante.hashValue{
            
            result.ImagenOut.isHidden = true
            result.ImagenIn.isHidden =  false
            result.Mensaje.stringValue = (Msg?.Msg)!
            result.Mensaje.alignment = .left
            
            
        }else if Msg?.tipoMsg.hashValue == Constantes.TipoMensaje.Saliente.hashValue{
            
            result.ImagenOut.isHidden = false
            result.ImagenIn.isHidden = true
            result.Mensaje.stringValue = (Msg?.Msg)!
            result.Mensaje.alignment = .right
        }
        
        //Verifica que tema es el que se elije
        if let tema = userdefaults.string(forKey: "Theme") {

            if tema.contains("Oscuro") ==  true {
                
                result.ImagenIn.image = NSImage(named: NSImage.Name("imageChatUserDark"))
                result.ImagenOut.image = NSImage(named: NSImage.Name("imageChatUserDark"))
                
            } else {

                result.ImagenIn.image = NSImage(named: NSImage.Name("imageChatUser"))
                result.ImagenOut.image = NSImage(named: NSImage.Name("imageChatUser"))
            }
        }
        return result
    }
    
  
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        
         let result:CustomCell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "defaultRow"), owner: self) as! CustomCell
        
        let size:NSRect  = result.Mensaje.frame
        
        result.HeightMensaje.constant = size.size.height
        
        let height:CGFloat = (size.size.height) + 30
        
        scrollToBottom()
        
        return height
        
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let numeroFilas  =  self.Tabla.numberOfRows
            if numeroFilas > 0 {
               self.Tabla.scrollRowToVisible(numeroFilas - 1)
            }
           
            
        }
    }
   
}
