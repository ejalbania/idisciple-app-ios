//
//  ContentAdapter.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 13/05/2019.
//

import RxSwift
import Moya
import SwiftyJSON
//
//protocol ContentAdapterType {
//  func getContents(user id: Int) -> Observable<ResourceModel>
//}
//
//class ContentAdapter: ContentAdapterType {
//  var provider: MoyaProvider<ContentAPI>!
//  let disposeBag = DisposeBag()
//
//  init(provider: MoyaProvider<ContentAPI> =
//    MoyaProvider<ContentAPI>()) {
//    self.provider = provider
//  }
//
//  func getContents(user id: Int) -> Observable<ResourceModel> {
//    return Observable.create { observer in
//      _ = self.provider.rx.request(.content(userID: id))
//        .subscribe(onSuccess: { response in
//
//          let contentList = Res(json: JSON(response.data)["data"]["assets"])
//          observer.onNext(contentList)
//        }, onError: { error in
//          print(String(describing: error.localizedDescription))
//        })
//      return Disposables.create()
//    }
//  }
//}
