//
//  UIViewController+AppHelper.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 02/11/2018.
//

import UIKit
import Foundation

extension AppHelper where Base: UIViewController {
    
    func alert(message: String){
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        self.base.present(alertController, animated: true, completion: nil)
    }
    
    func dismissAlert(){
        self.base.dismiss(animated: false, completion: nil);
    }
}
