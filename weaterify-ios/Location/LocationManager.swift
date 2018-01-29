//
//  LocationManager.swift
//  weaterify-ios
//
//  Created by Mirellys Arteta Davila on 28/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

final class LocationsManager {
    
    private let disposeBag = DisposeBag()
    var locationsManager: CLLocationManager?
    
    init() {
        locationsManager = CLLocationManager()
        locationsManager!.desiredAccuracy = kCLLocationAccuracyBest
        locationsManager!.requestWhenInUseAuthorization()
    }
    
    func startSearchingLocationUpdates() {
        
        locationsManager?
            .rx
            .didUpdateLocations
            .map({ $0.coordinate })
            .map({ App.Actions.changeLocation($0) })
            .subscribe(onNext: { mainStore.dispatch($0) },
                       onError: { print($0)
            })
            .disposed(by: disposeBag)
        
        locationsManager?.startUpdatingLocation()
    }
}

