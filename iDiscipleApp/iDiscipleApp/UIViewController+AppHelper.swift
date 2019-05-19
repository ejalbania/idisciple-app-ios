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
    
    
//    func reminderAlert(message: String){
//        let alertController = UIAlertController(title: "Reminder", message: message, preferredStyle: .alert)
//        //alertController.addAction(<#T##action: UIAlertAction##UIAlertAction#>)
//    }
}

extension AppHelper where Base: UILabel {
    func halfTextColorChange (fullText : String , changeText : String ) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 101/255, green: 175/255, blue: 85/255, alpha: 1) , range: range)
        self.base.attributedText = attribute
    }
}
