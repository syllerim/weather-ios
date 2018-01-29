//
//  CLLocationManager+Rx.swift
//  weaterify-ios
//
//  Created by Mirellys Arteta Davila on 28/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

extension Reactive where Base: CLLocationManager {
    
    /**
     Reactive wrapper for `delegate`.
     
     For more information take a look at `DelegateProxyType` protocol documentation.
     */
    public var delegate: DelegateProxy<CLLocationManager, CLLocationManagerDelegate> {
        return RxCLLocationManagerDelegateProxy.proxy(for: base)
    }
    
    // MARK: Responding to Location Events
    
    /**
     Reactive wrapper for `delegate` message.
     */
    public var didUpdateLocations: Observable<CLLocation> {
        return RxCLLocationManagerDelegateProxy.proxy(for: base).didUpdateLocationsSubject.asObservable()
    }
}

