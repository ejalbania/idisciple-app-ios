
//
//  JSONCache.swift
//  JSONCache
//
//  Created by Emmanuel Albania on 17/12/2018.
//  Copyright © 2018 Emmanuel Albania. All rights reserved.
//

import Foundation

public class JSONCache {
  
  /*HOW TO USE
  Saving cache  ===> JSONCache.set(CODABLE_MODEL, as: "UNIQUE_KEY_NAME")
  Retrive cache  ===> JSONCache.get("UNIQUE_KEY_NAME", as: CODABLE_MODEL.self)
  Remove Cache ==> JSONCache.remove("UNIQUE_KEY_NAME")
  delete All Cache ==> JSONCache.deleteAll()
  */
  
  
  /// Returns URL constructed from cache directory
  static fileprivate func getCacheDirURL() -> URL {
    let searchPathDirectory: FileManager.SearchPathDirectory = .cachesDirectory
    
    if let url = FileManager.default.urls(for: searchPathDirectory, in: .userDomainMask).first {
      return url
    } else {
      fatalError("Could not create URL for specified directory!")
    }
  }
  

  static func set<T: Encodable>(_ object: T, as fileName: String) {
    let url = getCacheDirURL().appendingPathComponent("\(fileName).json", isDirectory: false)
    
    let encoder = Encoder()
    do {
      let data = try encoder.encode(object)
      if FileManager.default.fileExists(atPath: url.path) {
        try FileManager.default.removeItem(at: url)
      }
      FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
    } catch {
      fatalError(error.localizedDescription)
    }
  }
    static func setObject<T: Encodable>(_ object: T, as fileName: String)->Bool {
        let url = getCacheDirURL().appendingPathComponent("\(fileName).json", isDirectory: false)
        
        let encoder = Encoder()
        do {
            let data = try encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
          let  isSuccess = FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
            return isSuccess
        } catch {
            return false
        }
    }
  static func get<T: Decodable>(_ fileName: String, as type: T.Type) -> T {
    let url = getCacheDirURL().appendingPathComponent("\(fileName).json", isDirectory: false)
    
    if !FileManager.default.fileExists(atPath: url.path) {
      fatalError("File at path \(url.path) does not exist!")
    }
    
    if let data = FileManager.default.contents(atPath: url.path) {
      let decoder = JSONDecoder()
      do {
        let model = try decoder.decode(type, from: data)
        return model
      } catch {
        fatalError(error.localizedDescription)
      }
    } else {
      fatalError("No data at \(url.path)!")
    }
  }

  static func getOptional<T: Decodable>(_ fileName: String, as type: T.Type) -> T? {
    let url = getCacheDirURL().appendingPathComponent("\(fileName).json", isDirectory: false)
    
    if !FileManager.default.fileExists(atPath: url.path) {
      print("File at path \(url.path) does not exist!")
      return nil
    }
    
    if let data = FileManager.default.contents(atPath: url.path) {
      let decoder = JSONDecoder()
      do {
        let model = try decoder.decode(type, from: data)
        return model
      } catch {
        print(error.localizedDescription)
      }
    } else {
      print("No data at \(url.path)!")
    }
    return nil
  }
  
  static func deleteAll() {
    let url = getCacheDirURL()
    do {
      let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
      for fileUrl in contents {
        try FileManager.default.removeItem(at: fileUrl)
      }
    } catch {
      fatalError(error.localizedDescription)
    }
  }
  
  static func remove(_ fileName: String) {
    let url = getCacheDirURL().appendingPathComponent("\(fileName).json", isDirectory: false)
    if FileManager.default.fileExists(atPath: url.path) {
      do {
        try FileManager.default.removeItem(at: url)
      } catch {
        fatalError(error.localizedDescription)
      }
    }
  }
  
  /// Returns BOOL indicating whether file exists at specified directory with specified file name
  static func exists(_ fileName: String) -> Bool {
    let url = getCacheDirURL().appendingPathComponent("\(fileName).json", isDirectory: false)
    return FileManager.default.fileExists(atPath: url.path)
  }

  static func clear() {
    // Insert Structs that are needed to be cleared
  }
}

struct NoDataJSON: Codable {}

protocol JSONCacheBase: Codable {
  var filename: String { get }
  var isExisting: Bool { get }
  
  func save()
  func get() -> Self?
  func delete()
}

extension JSONCacheBase {
  var filename: String { return String(describing: type(of: self)) }
  var isExisting: Bool { return JSONCache.exists(filename) }

  var stringContent: String {
    do {
      let json = try Encoder().encode(self)
      
      return String(data: json, encoding: .utf8) ?? "nil"
    } catch { }
    return "[: ]"
  }
  
  func save() {
    JSONCache.set((self as Self), as: filename)
  }
  
  func get() -> Self? {
    return JSONCache.getOptional(filename, as: type(of: self))
  }
  
  func delete() {
    JSONCache.remove(filename)
  }
}

fileprivate class Encoder: JSONEncoder {
  override var outputFormatting: JSONEncoder.OutputFormatting {
    set { _ = newValue }
    get { return .prettyPrinted } }
}
