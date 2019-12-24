//
//  operators.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 01/05/2019.
//

postfix operator --
postfix operator ++

infix operator =?

@discardableResult
postfix func --(value: inout Int) -> Int {
  value-=1
  return value
}

@discardableResult
postfix func ++(value: inout Int) -> Int {
  value+=1
  return value
}

postfix func --(value: Int) -> Int {
  return (value - 1)
}

postfix func ++(value: Int) -> Int {
  return (value + 1)
}

func =?<T>(owner: inout T, newValue: T?) {
  owner = newValue ?? owner
}
