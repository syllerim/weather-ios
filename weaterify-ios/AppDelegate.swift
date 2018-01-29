//
//  AppDelegate.swift
//  weaterify-ios
//
//  Created by Mirellys on 24/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let router = AppRoute()
    let locationManager = LocationsManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window =  window
        router.setup(in: window)
        mainStore.dispatch(App.Actions.saveToken)
        locationManager.startSearchingLocationUpdates()
        
        return true
    }

}

