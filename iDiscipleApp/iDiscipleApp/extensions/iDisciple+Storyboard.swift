//
//  Storyboard+extension.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 28/04/2019.
//

import UIKit

// Temp
// Convert this to enhanced router

extension iDisciple {
  enum Story {
    case speakers, workshops, schedule, community, more
    
    var title: String {
      switch self {
      case .speakers: return "Speakers"
      case .workshops: return "Workshops"
      case .schedule: return "Schedule"
      case .community: return "Community"
      case .more: return "More"
      }
    }
    
    var icon: UIImage {
      let iconName = "tabIcon_\(self.title.lowercased())"
      
      guard let image = UIImage(named: iconName) else {
        fatalError("Fatal Error: iDisciple[\(#function)] cannot locate \(iconName)")
      }
      
      return image
    }
    
    var baord: UIStoryboard {
      return UIStoryboard(name: self.title, bundle: nil)
    }
    
    var initialViewController: UIViewController {
      let viewController = (self.baord.instantiateInitialViewController() ?? UIViewController())
      viewController.tabBarItem.set(title: self.title)
        .setIcon(image: self.icon)
      
      return viewController
    }
    

    func viewController(with identifier: String) -> UIViewController {
      return self.baord.instantiateViewController(withIdentifier: identifier)
    }
  }
}

