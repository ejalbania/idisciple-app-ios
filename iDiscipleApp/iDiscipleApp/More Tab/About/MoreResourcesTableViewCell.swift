//
//  MoreResourcesTableViewCell.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 08/05/2019.
//

import UIKit
import RxSwift
import SwiftyJSON
import WebKit

protocol MoreResourcesTableViewCellDelegate {
  func didSelectOptions()
  
}

class MoreResourcesTableViewCell: UITableViewCell {
  @IBOutlet fileprivate weak var containerView: UIView!
  
  @IBOutlet fileprivate weak var resource_titleLabel: UILabel!
  @IBOutlet fileprivate weak var resource_descLabel: UILabel!
  @IBOutlet fileprivate weak var resource_metaDataLabel: UILabel!
  fileprivate(set) var url: String = ""
  fileprivate(set) var mediaType: MediaType = .undefined("")
  fileprivate(set) var fileSize: Double?
  
  var resource_name: String {
    return self.resource_titleLabel.text ?? ""
  }
  
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
      case .pdf: return type.stringValue.uppercased()
      case .video: return "YOUTUBE"
      case .web, .undefined: return "\(type.stringValue)"
      }
    }
    
    self.mediaType = type
    self.resource_metaDataLabel.text = metaLabelText
    return self
  }
  
  @discardableResult
  func setResources(url: String) -> Self {
    self.url = url
    return self
  }
  
  @discardableResult
  func set(resource: ResourceModel) -> Self {
    return self.setResources(title: resource.title)
      .setResources(description: resource.description)
      .setResources(type: resource.type, fileSize: resource.size)
      .setResources(url: resource.url)
  }
}

fileprivate extension MoreResourcesTableViewCell {
  
}
