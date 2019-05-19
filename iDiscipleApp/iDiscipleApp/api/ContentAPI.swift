//
//  ContentAPI.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 13/05/2019.
//

import Moya

enum ContentAPI {
  case content(userID: Int)
}

extension ContentAPI: TargetType {
  var baseURL: URL {
    return URL(string: "\(iDiscipleConstants.APIDomain)/content/all?user_id=1")!
  }
  
  var path: String {
    switch self {
    case .content:
      return ""
    }
  }
  
  var method: Method {
    switch self {
    case .content: return .get
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var task: Task {
    switch self {
    case .content:
      return .requestPlain
    }
  }
  
  var headers: [String : String]? {
    return ["Content-Type": "application/json"]
  }
  
}
