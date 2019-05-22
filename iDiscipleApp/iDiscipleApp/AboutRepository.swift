//
//  AboutRepository.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 19/05/2019.
//

import SwiftyJSON

struct AboutModel: CodableModel {
  var title: String
  var content: String
  
  init(json: JSON) {
    self.title = json["title"].stringValue
    self.content = json["content"].stringValue
  }
}

class AboutRepository: RepositoryList<AboutModel> { }
