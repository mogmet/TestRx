//
//  ViewModel.swift
//  TestRx
//
//  Created by mogmet on 2020/02/07.
//  Copyright © 2020 mogmet.com. All rights reserved.
//

import RxSwift
import RxCocoa

class ViewModel {
    private let reloadLabel: PublishRelay<String> = PublishRelay<String>()
    var reloadLabelObservable: Observable<String> { return reloadLabel.asObservable() }
    private let onceEvent: PublishSubject<Void> = PublishSubject<Void>()
    var onceEventObservable: Observable<Void> { return onceEvent.asObserver() }
    private let latestEvent = BehaviorSubject(value: "hoge")
    var latestEventObservable: Observable<String> { return latestEvent.asObservable()}
    
    func reload() {
        reloadLabel.accept("Label")
    }
    
    func once() {
        onceEvent.onNext(())
        onceEvent.onCompleted()
    }
    
    func latest() {
        guard let hoge = try? latestEvent.value() else { return }
        latestEvent.onNext(hoge + hoge)
    }
}
