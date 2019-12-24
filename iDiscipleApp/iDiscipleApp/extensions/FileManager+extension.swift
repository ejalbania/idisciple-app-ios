//
//  iDisciple+FileManager.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 21/05/2019.
//

import Foundation

extension FileManager {
  @discardableResult
  static func createDirectory(folder name: String) -> URL? {
    let documentPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
    
    guard let newFilePath = documentPath.appendingPathComponent(name) else {
      return nil
    }

    var isDirectory: ObjCBool = false
    FileManager.default.fileExists(atPath: newFilePath.absoluteString, isDirectory: &isDirectory)
    
    if !isDirectory.boolValue {
      do { try FileManager.default.createDirectory(at: newFilePath, withIntermediateDirectories: true, attributes: nil) }
      catch { return nil }
    }
    
    return newFilePath
  }
}
