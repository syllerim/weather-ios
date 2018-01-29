//
//  AppMiddleware.swift
//  weaterify-ios
//
//  Created by Mirellys Arteta Davila on 25/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import Foundation
import RxSwift
import ReactiveReSwift
import SweetRouter
import UserNotifications

extension App {
    typealias SideEffect = (() -> App.State, @escaping Middleware<State>.DispatchFunction, Action) -> Void
    
    static var keyToken = "authorizationToken"
    static var valueToken = "95d190a434083879a6398aafd54d9e73"
    
    private static let disposeBag = DisposeBag()
    
    static var saveToken: SideEffect {
        return { _, _, action in
            guard case Actions.saveToken = action else { return }
            let defaults = UserDefaults.standard
            defaults.set(valueToken, forKey: keyToken)
        }
    }
    
    static var getForecast: SideEffect {
        return { _, function, action in
            guard case let Actions.getForecast(cityParam, unitsParam, cntParam) = action else { return }
            guard let city = cityParam, let cnt = cntParam, let units = unitsParam else { return }
            Connection()
                .getForecast(for: city, cnt: cnt, units: units)
                .subscribe(onNext: { forecast in
                    function(App.Actions.updateForecast(forecast))
                })
                .disposed(by: disposeBag)
        }
    }
    
    static var reloadForecast: SideEffect {
        return { state, function, action in
            guard case Actions.reloadData = action else { return }
            guard let city = state().location  else { return }
            
            Connection()
                .getForecast(for: city, cnt: String(describing: state().numberOfDaysForecast), units:  state().unitTemperature)
                .subscribe(onNext: { forecast in
                    function(App.Actions.updateForecast(forecast))
                })
                .disposed(by: disposeBag)
        }
    }
    
    static var changeLocation: SideEffect {
        return { state , function, action in
            guard case let .changeLocation(location)? = action as? Actions  else { return }
            Connection()
                .getForecastBasedOnCoordinates(for: String(location.latitude),
                                               lon: String(location.longitude),
                                               cnt: String(describing: state().numberOfDaysForecast),
                                               units:  state().unitTemperature)
                .subscribe(onNext: { forecast in
                    guard forecast.cnt > 0 else { return }
                    function(App.Actions.updateForecast(forecast))
                })
                .disposed(by: disposeBag)
        }
    }
    
    static let middleware = Middleware<State>()
        .sideEffect(saveToken)
        .sideEffect(getForecast)
        .sideEffect(changeLocation)
        .sideEffect(reloadForecast)
}
