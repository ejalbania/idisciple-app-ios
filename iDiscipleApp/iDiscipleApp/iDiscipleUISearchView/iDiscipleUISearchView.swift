//
//  iDiscipleUISearchView.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 21/05/2019.
//

import UIKit
import RxSwift

class iDiscipleUISearchView: UIView {
  fileprivate var disposeBag = DisposeBag()
  @IBOutlet weak var searchField: UITextField!
  fileprivate var isActive: Variable<Bool> = Variable(false)
  
  @IBOutlet weak var search_placeholder: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.setupNib()
    self.searchField.delegate = self
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.setupAesthetics()
  }
  @IBAction func didTap_searchBtn(_ sender: UIButton) {
     self.isActive.value = !self.isActive.value
  }
}

// Private classes
fileprivate extension iDiscipleUISearchView {
  func setupNib() {
    guard let nibView = Bundle.main.loadNibNamed("iDiscipleUISearchView", owner: self, options: [:])?
      .first as? UIView else {
      return
    }
    
    self.frame = nibView.bounds
    self.addSubview(nibView)
  }
  
  func setupAesthetics() {
    self
      .setBorder(width: 1, color: .lightGray)
      .setCorner(radius: 5)
  }
  
  func configureCallbacks() {
    isActive.asObservable().subscribe(onNext: { status in
      self.search_placeholder.isHidden = status
      if status {
        self.searchField.becomeFirstResponder()
      } else {
        self.searchField.resignFirstResponder()
      }
    }).disposed(by: disposeBag)
    
    
  }
}

extension iDiscipleUISearchView: UITextFieldDelegate {
  
}
