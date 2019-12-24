//
//  resourcesModel.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 13/05/2019.
//

import SwiftyJSON

struct ResourceModel: CodableModel {
  var id: String
  var url: String
  private var _type: String
  var description: String
  var title: String
  var size: Double = 0.00
  
  var type: MediaType { return MediaType.getFrom(string: self._type) }
  
  init(json: JSON) {
    self.id = json["resource_id"].stringValue
    self.url = json["url"].stringValue
    self._type = json["type"].stringValue
    self.description = json["description"].stringValue
    self.title = json["title"].stringValue
  }
  
}

class ResourcesRepository: RepositoryList<ResourceModel> { }
