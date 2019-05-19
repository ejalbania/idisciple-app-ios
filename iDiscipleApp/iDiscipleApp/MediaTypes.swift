//
//  FileTypes.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 12/05/2019.
//

enum MediaType {
  case pdf
  case video
  case web
  case undefined(String)
  
  var stringValue: String {
    switch self {
    case .pdf: return "PDF"
    case .video: return "VIDEO"
    case .web: return "WEB"
    case .undefined(let name): return name
    }
  }
  
  static func getFrom(string: String) -> MediaType {
    switch string {
    case "PDF": return .pdf
    case "VIDEO": return .video
    case "WEB": return .web
    default: return .undefined(string)
    }
  }
}
