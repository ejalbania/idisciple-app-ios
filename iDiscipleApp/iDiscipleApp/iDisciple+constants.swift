//
//  iDisciple+constants.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 13/05/2019.
//

extension iDisciple {
  class Constants {
    var APIDomain: String { return iDiscipleDomain.public }
    
  }
}

fileprivate let iDiscipleBaseDomain = "https://idisciple.ph/API/"

#warning ("indicate uat when dev schema was already implemented")
fileprivate let iDiscipleDomain: (public: String, uat: String) = ("\(iDiscipleBaseDomain)public", "")
