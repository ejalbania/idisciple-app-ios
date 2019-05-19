//
//  RepositoryList.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 19/05/2019.
//

import Foundation

protocol CodableModel: Codable { }

class RepositoryList<Model: CodableModel>: JSONCacheBase {
  private var _list: [Model] = []
  var list: [Model] { return self._list }
  
  init() {
    self._list =? self.get()?._list
  }
  
  @discardableResult
  func add(model: Model) -> Self {
    self._list.append(model)
    return self
  }
  
  @discardableResult
  func flush() -> Self {
    self._list = []
    self.save()
    return self
  }
}
