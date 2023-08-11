//
//  AppDelegate.swift
//  horizon-client-sample-ios
//
//  Created by alessandro on 09/08/23.
//

import UIKit
import HorizonClient
import AdSupport
import AppTrackingTransparency

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initializeHorizon()
        return true
    }
    
    private func initializeHorizon(){
        let tenant = "dev-beta"
        let envorinment = HorizonEnvironment.qa
        
        if #available(iOS 14, *) {
            switch ATTrackingManager.trackingAuthorizationStatus {
            case  ATTrackingManager.AuthorizationStatus.authorized:
                let advertisingId = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                HorizonClient.useSettings(tenant: tenant, horizonEnvironment: envorinment, advertisingId: advertisingId)
            default:
                HorizonClient.useSettings(tenant: tenant, horizonEnvironment: envorinment)
            }
        }
    }
    
}

