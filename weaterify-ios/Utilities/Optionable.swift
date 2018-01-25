//
//  Optionable.swift
//  weaterify-ios
//
//  Created by Mirellys Arteta Davila on 24/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import Foundation
import RxSwift

public protocol Optionable {
    associatedtype WrappedType
    func unwrap() -> WrappedType
    func isEmpty() -> Bool
}

extension Optional : Optionable {
    public typealias WrappedType = Wrapped
    
    public func unwrap() -> WrappedType {
        return self!
    }
    
    public func isEmpty() -> Bool {
        return self == nil
    }
}

extension ObservableType where E : Optionable {
    public func unwrap() -> Observable<E.WrappedType> {
        return self
            .filter { value in
                return !value.isEmpty()
            }
            .map { value -> E.WrappedType in
                value.unwrap()
        }
    }
}
