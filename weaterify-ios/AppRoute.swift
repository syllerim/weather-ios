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
    case information
    case settings
    
    static func == (lhs: Route, rhs: Route) -> Bool {
        var result: Bool
        switch (lhs, rhs) {
        case (.dashboard, .dashboard), (.information, .information), (.settings, .settings):
            result = true
        default:
            result = false
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
                case .information:
                    return .information
                case .settings:
                    return .settings
                }
            }
            .unwrap()
            .map { viewController in
                switch viewController {
                case .dashboard:
                    return Main.instantiateViewController(with: viewController)
                case .information:
                    let navigationController = self.window?.rootViewController as? UINavigationController
                    let informationVC = Main.instantiateViewController(with: .information)
                    navigationController?.pushViewController(informationVC, animated: false)
                    return navigationController
                case .settings:
                    let navigationController = self.window?.rootViewController as? UINavigationController
                    let settingsVC = Main.instantiateViewController(with: .settings)
                    navigationController?.pushViewController(settingsVC, animated: false)
                    return navigationController
                }
            }
            .subscribe(onNext: { [unowned self] in
                self.window?.rootViewController = $0
            })
            .disposed(by: disposeBag)
    }
}
