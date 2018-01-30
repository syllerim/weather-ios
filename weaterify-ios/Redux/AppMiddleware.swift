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
import UIKit

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
                .getForecast(for: city, cnt: String(describing: state().numberOfDaysForecast+2), units:  state().unitTemperature)
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
    
    static var updateLocation: SideEffect {
        return { state , function, action in
            guard case let Actions.insertCity(sender) = action else { return }
            let alertController = UIAlertController(title: "Location",
                                                    message: "Enter the city you want to receive the weather forecast for",
                                                    preferredStyle: .alert)
            alertController.addTextField(configurationHandler: { (textField : UITextField) in
                textField.placeholder = "City"
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (result : UIAlertAction) in
                print("Cancel")
            }
            let okAction = UIAlertAction(title: "OK", style: .default) { (result : UIAlertAction) in
                if let city = alertController.textFields?.first?.text {
                    function(App.Actions.updateCity(city))
                }
            }
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            sender.present(alertController, animated: true, completion: nil)
        }
    }
    
    static var updateNumberOfDaysForecast: SideEffect {
        return { state , function, action in
            guard case let Actions.insertNumberDays(sender) = action else { return }
            let alertController = UIAlertController(title: "Number Of Days",
                                                    message: "Enter the number of days to obtain forecast.  Max value allowed: 5.",
                                                    preferredStyle: .alert)
            alertController.addTextField(configurationHandler: { (textField : UITextField) in
                textField.placeholder = "Number of Days Forecast"
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (result : UIAlertAction) in
                print("Cancel")
            }
            let okAction = UIAlertAction(title: "OK", style: .default) { (result : UIAlertAction) in
                if let days = alertController.textFields?.first?.text {
                    if let daysInt = Int(days) {
                        function(App.Actions.updateNumberOfDaysForecast(daysInt))
                    }
                }
            }
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            sender.present(alertController, animated: true, completion: nil)
        }
    }
    
    static var updateUnitsTemperature: SideEffect {
        return { state , function, action in
            guard case let Actions.insertUnit(sender) = action else { return }
            let alertController = UIAlertController(title: "Unit Temperature",
                                                    message: "",
                                                    preferredStyle: .actionSheet)
            
            let picker = UIPickerView(frame: CGRect(x: 0, y: sender.view.bounds.height - 241, width: sender.view.bounds.width, height: 241))
            picker.tag = 555
            
            picker.delegate = sender as? UIPickerViewDelegate
            picker.dataSource = sender as? UIPickerViewDataSource
            
            alertController.view.addSubview(picker)
            picker.translatesAutoresizingMaskIntoConstraints = false
            picker.topAnchor.constraint(equalTo: alertController.view.topAnchor).isActive = true
            picker.rightAnchor.constraint(equalTo: alertController.view.rightAnchor).isActive = true
            picker.bottomAnchor.constraint(equalTo: alertController.view.bottomAnchor).isActive = true
            picker.leftAnchor.constraint(equalTo: alertController.view.leftAnchor).isActive = true
            picker.reloadAllComponents()
            
            sender.parent!.present(alertController, animated: true, completion: nil)
        }
    }
    
    static let middleware = Middleware<State>()
        .sideEffect(saveToken)
        .sideEffect(getForecast)
        .sideEffect(changeLocation)
        .sideEffect(reloadForecast)
        .sideEffect(updateLocation)
        .sideEffect(updateUnitsTemperature)
        .sideEffect(updateNumberOfDaysForecast)
    
}
