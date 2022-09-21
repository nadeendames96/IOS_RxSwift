//
//  ViewController.swift
//  IOS_RxSwift
//
//  Created by Nadeen on 21/09/2022.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    @IBOutlet weak var clickAccept: UIButton!
    @IBOutlet weak var codeNumberET: UITextField!
    var apiViewModel = RxSwiftStruct()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindModel()
        subscripeClickButton()
        subscribeLoading()
        subscribeLoading()
    }
    func bindModel(){
        codeNumberET.rx.text.orEmpty.bind(to: apiViewModel.codeNumberBehavior).disposed(by: disposeBag)
        print(apiViewModel.codeNumberBehavior.value)
    }
    func subscribeLoading(){
        // only listner
        apiViewModel.loadingBehavior.subscribe(onNext:{ isLoading in
            if isLoading{
                print("isLoading \(isLoading)")
            }
            else{
                print("not isLoading \(isLoading)")

            }
        }).disposed(by: disposeBag)
    }
    func subscribeResponse(){
        apiViewModel.loginModelObseable.subscribe(onNext: {
            if !$0.isEmpty{
               print("Not Empty")
            }else{
                print("Empty")

            }
        }).disposed(by: disposeBag)
    }
    func suscribeButtonEnaled() {
        // check if button is enabled or not
        apiViewModel.isClickButtonEnabled.bind(to: clickAccept.rx.isEnabled).disposed(by: disposeBag)
    }
    func subscripeClickButton(){
        clickAccept.rx.tap.throttle(RxTimeInterval.microseconds(500), scheduler: MainScheduler.instance).subscribe(onNext:{ [weak self] _ in
            guard let self = self else{return}
            self.apiViewModel.getData()
        }).disposed(by: disposeBag)
    }
}

