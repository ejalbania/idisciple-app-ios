//
//  MoreResourcesTableViewCell.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 08/05/2019.
//

import UIKit
import RxSwift
import SwiftyJSON

protocol MoreResourcesTableViewCellDelegate {
  func didSelectOptions()
  
}

class MoreResourcesTableViewCell: UITableViewCell {
  @IBOutlet fileprivate weak var containerView: UIView!
  
  @IBOutlet fileprivate weak var resource_titleLabel: UILabel!
  @IBOutlet fileprivate weak var resource_descLabel: UILabel!
  @IBOutlet fileprivate weak var resource_metaDataLabel: UILabel!
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
  }
  
  
  
  override func layoutSublayers(of layer: CALayer) {
    super.layoutSublayers(of: layer)
    
    self.containerView.dropShadow()
  }
}

extension MoreResourcesTableViewCell {
  @discardableResult
  func setResources(title: String) -> Self {
    self.resource_titleLabel.text = title
    return self
  }
  
  @discardableResult
  func setResources(description: String) -> Self {
    self.resource_descLabel.text = description
    return self
  }
  
  @discardableResult
  func setResources(type: MediaType, fileSize: Double = 0.00) -> Self {
    var metaLabelText: String {
      switch type {
      case .pdf: return "\(type.stringValue) - \(fileSize.stringValue)"
      case .video, .web, .undefined: return "\(type.stringValue)"
      }
    }
    
    self.resource_metaDataLabel.text = metaLabelText
    return self
  }
  
  @discardableResult
  func set(resource: ResourceModel) -> Self {
    return self.setResources(title: resource.title)
      .setResources(description: resource.description)
      .setResources(type: resource.type, fileSize: resource.size)
  }
}

fileprivate extension MoreResourcesTableViewCell {
  
}
