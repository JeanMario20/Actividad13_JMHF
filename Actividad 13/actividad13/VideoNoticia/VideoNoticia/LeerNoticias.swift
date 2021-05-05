//
//  LeerNoticias.swift
//  VideoNoticia
//
//  Created by alicharlie on 12/05/16.
//  Copyright © 2016 codepix. All rights reserved.
//

import UIKit

struct Noticias: Codable{
    let titulo: String
    let typeArray: [TypeElement]
    
    enum CodingKeys: String, CodingKey{
        case typeArray = "types"
        case titulo
    }
}
struct TypeElement: Codable {
    let element : Type
    
    enum CodingKeys: String,CodingKey{
        case element = "type"
    }
}
struct Type: Codable{
    let elementname: String
    
    enum CodingKeys: String, CodingKey {
        case elementname = "name"
    }
}

class LeerNoticias{
    
    
    func getNoticias(termino: @escaping (_ datos:[String])->()){
    let session = URLSession.shared
      let liga = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/arts/30.json?api-key=029bb2ef5c76452bac5b2c3ca06893dd"
      let url = URL(string: liga)!
        let _:Void = session.dataTask(with: url) { (dato:Data?, respuesta:URLResponse?, error:Error?) in
            //var titulos:[String] = []
            do{
                let resultado = try JSONSerialization.jsonObject(with: dato!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! NSDictionary
                var titulos:[String] = []
                var arrayOpt: [NSDictionary] = []
                
                for valor in resultado["results"] as? [NSDictionary] ?? arrayOpt{
                  titulos.append(valor["title"] as! String)
                }
                DispatchQueue.main.async  {
                    termino(titulos)

                }
            }catch{
              print("Error en lectura")
            }
        }.resume()
        }
}
