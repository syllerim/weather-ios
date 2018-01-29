//
//  RxSwift.swift
//  weaterify-ios
//
//  Created by Mirellys Arteta Davila on 25/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import Foundation
import ReactiveReSwift
import RxSwift

extension Variable: ObservablePropertyType {
    public typealias ValueType = Element
    public typealias DisposableType = DisposableWrapper
    
    public func subscribe(_ function: @escaping (Element) -> Void) -> DisposableWrapper? {
        return DisposableWrapper(disposable: asObservable().subscribe(onNext: function))
    }
}

extension Observable: StreamType {
    public typealias ValueType = Element
    public typealias DisposableType = DisposableWrapper
    
    public func subscribe(_ function: @escaping (Element) -> Void) -> DisposableWrapper? {
        return DisposableWrapper(disposable: subscribe(onNext: function))
    }
}

public struct DisposableWrapper: SubscriptionReferenceType {
    let disposable: Disposable
    
    public func dispose() {
        disposable.dispose()
    }
}
