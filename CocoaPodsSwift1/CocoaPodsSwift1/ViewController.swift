//
//  ViewController.swift
//  CocoaPodsSwift1
//
//  Created by Felipe Hernandez on 23/05/18.
//  Copyright © 2018 Felipe Hernandez. All rights reserved.
//

import Cocoa
import Alamofire

class ViewController: NSViewController,NSTableViewDataSource, NSTableViewDelegate {

    var lista = [Category]()
    
    @IBOutlet weak var Tabla: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        CargarInformacion()
    }

    
    func CargarInformacion() {
        
        lista.removeAll()
        
        let url = "http://apiestudiosalle3.azurewebsites.net/v1/Categories/getAllCategories"
        
        
        
        Alamofire.request(url,
                          method: HTTPMethod.get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil).responseJSON { response in
                            
                            switch response.result {
                                
                            case .success:
                                if let result =  response.result.value {
                                    let JSON =  result as! Array<NSDictionary>
                                    
                                    for item in JSON {
                                        
                                        let obj = item as NSDictionary
                                        
                                        let category = Category()
                                        
                                        category.categoryID = obj["categoryID"]! as! Int
                                        category.categoryName = obj["categoryName"]! as! String
                                        category.descriptionApi = obj["description"]! as! String
                                        
                                        self.lista.append(category)
                                        
                                        
                                        //for (key, value) in obj {
                                        // }
                                        
                                    }
                                    self.Tabla.reloadData()
                                    print(JSON)
                                    
                                }
                                break
                            case .failure:
                                print("Algo salio mal")
                                break
                                
                                
                            }
                            
                            
                            
        }
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "Agregar"{
            var vc =  segue.destinationController as! AgregarViewController
            vc.viewController  =  self
            
        }else if segue.identifier == "Editar"{
               var vc =  segue.destinationController as! AgregarViewController
            vc.viewController  =  self
            
            if Tabla.selectedRow != -1 {
                
                var row : Int = 0
                
                row  =  Tabla.selectedRow
                
                var objCategoria = lista[row]
                
                vc.categoria = objCategoria
                
            }
            
        }
    }
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return lista.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        
        let c: Category? = lista[row]
        
        if tableColumn!.identifier.rawValue == "categoryID" {
            return c?.categoryID
        }
        else if tableColumn!.identifier.rawValue == "categoryName" {
            return c?.categoryName
            
        }else if tableColumn!.identifier.rawValue == "descriptionApi" {
            return c?.descriptionApi
        } else {
            return nil
        }
        
        
       /* let identifier : String = tableColumn!.identifier.rawValue
        
        let columna = c?.value(forKey: identifier)
        
        return columna*/
        
    }

}




