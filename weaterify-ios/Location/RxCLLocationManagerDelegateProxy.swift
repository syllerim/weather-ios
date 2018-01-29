//
//  RxCLLocationManagerDelegateProxy.swift
//  weaterify-ios
//
//  Created by Mirellys Arteta Davila on 28/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

final class RxCLLocationManagerDelegateProxy: DelegateProxy<CLLocationManager, CLLocationManagerDelegate>, DelegateProxyType, CLLocationManagerDelegate {
    static func currentDelegate(for object: CLLocationManager) -> CLLocationManagerDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: CLLocationManagerDelegate?, to object: CLLocationManager) {
        object.delegate = delegate
    }
    
    public init(locationManager: ParentObject) {
        super.init(parentObject: locationManager, delegateProxy: RxCLLocationManagerDelegateProxy.self)
    }
    
    static func registerKnownImplementations() {
        self.register {
            RxCLLocationManagerDelegateProxy.init(locationManager: $0)
        }
    }
    
    internal lazy var didUpdateLocationsSubject = PublishSubject<CLLocation>()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            didUpdateLocationsSubject.onNext(location)
        }
    }
    
    deinit {
        didUpdateLocationsSubject.on(.completed)
    }
    
}

