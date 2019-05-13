//
//  resourcesModel.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 13/05/2019.
//

import SwiftyJSON

struct ContentResponseModel: Decodable {
  var name: String
  var update: Bool
  var filePath: String
  
  init(name: String, json: [String: Any]) {
    self.name = name
    self.update = (json["update_now"] as? Bool) ?? false
    self.filePath = (json["path_file"] as? String) ?? ""
  }
}

struct ContentsModel: Decodable {
  var list = [ContentResponseModel]()
  
  init(json: JSON) {
    
    guard let dict = json.dictionaryObject else { return }
    
    dict.keys.forEach {
      guard let item = dict[$0] as? [String:Any] else { return }
      list.append(ContentResponseModel(name: $0, json: item))      
    }
    
  }
}
