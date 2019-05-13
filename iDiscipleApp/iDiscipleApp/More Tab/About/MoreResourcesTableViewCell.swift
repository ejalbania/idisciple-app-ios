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
  var sample: Variable<ContentResponseModel>?
  override func awakeFromNib() {
    super.awakeFromNib()
    
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
  func setResources(type: FileType, fileSize: Double) -> Self {
    self.resource_metaDataLabel.text = "\(type.rawValue) - \(fileSize.stringValue)"
    return self
  }
}

fileprivate extension MoreResourcesTableViewCell {
  
}
