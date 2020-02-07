//
//  ViewController.swift
//  TestRx
//
//  Created by mogmet on 2020/02/07.
//  Copyright © 2020 mogmet.com. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var onceButton: UIButton!
    @IBOutlet weak var latestButton: UIButton!
    private let disposeBag = DisposeBag()
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // tapイベント流すだけ
        button.rx.tap.subscribe { _ in
            self.label.text = "\(self.label.text!)a"
        }.disposed(by: disposeBag)
        // reloadイベント流すだけ
        reloadButton.rx.tap.subscribe { _ in
            self.viewModel.reload()
        }.disposed(by: disposeBag)
        viewModel.reloadLabelObservable.subscribe(onNext: { reloadText in
            self.label.text = reloadText
        }).disposed(by: disposeBag)
        // 1回だけイベント流すだけ
        viewModel.onceEventObservable.subscribe(onNext: { _ in
            self.label.text = "once"
        }, onCompleted: {
            print("complete!")
        }).disposed(by: disposeBag)
        onceButton.rx.tap.subscribe { _ in
            self.viewModel.once()
        }.disposed(by: disposeBag)
        // 直近のイベントを流して移行続けて値を保持してイベントを流す
        viewModel.latestEventObservable.subscribe(onNext: { hoge in
            self.label.text = hoge
        }).disposed(by: disposeBag)
        latestButton.rx.tap.subscribe { _ in
            self.viewModel.latest()
        }.disposed(by: disposeBag)
    }
}

