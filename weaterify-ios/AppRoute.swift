//
//  AppRouter.swift
//  weaterify-ios
//
//  Created by Mirellys Arteta Davila on 25/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import ReactiveReSwift
import SwiftyStoryboard

enum Route: Equatable {
    case dashboard
    
    static func == (lhs: Route, rhs: Route) -> Bool {
        var result = false
        switch (lhs, rhs) {
        case (.dashboard, .dashboard):
            result = true
        }
        return result
    }
}

final class AppRoute {
    let disposeBag = DisposeBag()
    var window: UIWindow?
    
    func setup(in window: UIWindow) {
        self.window = window
        window.backgroundColor = .black
        window.rootViewController = UIViewController()
        setupObservables()
    }
    
    func setupObservables() {
        mainStore.observable.asObservable()
            .map({ $0.route })
            .distinctUntilChanged()
            .map { route -> Main.ControllerId? in
                switch route {
                case .dashboard:
                    return .dashboard
                }
            }
            .unwrap()
            .map {
                Main.instantiateViewController(with: $0)
            }
            .subscribe(onNext: { [unowned self] in
                self.window?.rootViewController = $0
            })
            .disposed(by: disposeBag)
    }
}
