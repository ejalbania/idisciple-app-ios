//
//  AppHelper.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 02/11/2018.
//

import UIKit

public protocol AppHelperCompatible {
    associatedtype someType
    var appHelper: someType { get }
}

public extension AppHelperCompatible {
    var appHelper: AppHelper<Self> {
        get { return AppHelper(self) }
    }
}

public struct AppHelper<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

// All conformance here
//extension UIColor: AppHelperCompatible {}
extension UIViewController : AppHelperCompatible{}
extension UIView : AppHelperCompatible{}
