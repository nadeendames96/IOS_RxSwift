//
//  APIs.swift
//  IOS_RxSwift
//
//  Created by Nadeen on 21/09/2022.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
struct RxSwiftStruct{
    var codeNumberBehavior = BehaviorRelay<String>(value: "")
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    var isValidCodeNumber:Observable<Bool>{
        return codeNumberBehavior.asObservable().map{(codeNumber) -> Bool in
            let codeNumberisEmpty = codeNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            return codeNumberisEmpty
        }
    }
    var isClickButtonEnabled:Observable<Bool>{
        return Observable.combineLatest(isValidCodeNumber,isValidCodeNumber){
            isValidCodeNumberBool,isValidCodeNumberBool2 in
            let clickValid = !isValidCodeNumberBool
            return clickValid
        }
    }
    private var loginModelSubject = PublishSubject<String>()
    var loginModelObseable:Observable<String>{
        return loginModelSubject
    }
    
    func getData(){
       let codeNumber = codeNumberBehavior.value
        loadingBehavior.accept(true)
    }
}
