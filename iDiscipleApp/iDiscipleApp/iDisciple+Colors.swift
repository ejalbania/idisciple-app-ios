//
//  iDiscipleColors.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 28/04/2019.
//
import UIKit.UIColor

extension iDisciple {
  
  enum Color {
    case
    white, black,
    orange,
    green,
    red,
    blue,
    gray
    
    var value: UIColor {
      switch self {
      case .white:
        return .white
      case .black:
        return .black
      case .orange:
        return UIColor(red: 243/255, green: 137/255, blue: 49/255, alpha: 1)
      case .green:
        return UIColor(red: 101/255, green: 175/255, blue: 85/255, alpha: 1)
      case .red:
        return UIColor(red: 221/255, green: 36/255, blue: 58/255, alpha: 1)
      case .blue:
        return UIColor(red: 22/255, green: 145/255, blue: 195/255, alpha: 1)
      case .gray:
        return UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1)
      }
    }
    
    var highlight: UIColor {
      switch self {
      case .gray: return UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1)
      default: return self.value
      }
    }
  }
}
