//
//  HomeViewModel.swift
//  HorizonClientSample
//
//  Created by alessandro on 30/11/22.
//  Copyright © 2022 globo.com. All rights reserved.
//

import Foundation
//import HorizonClient
//import AdSupport
//import AppTrackingTransparency


protocol HomeViewModelType {
    func requestAdvertisingIdPermission()
}

struct HomeViewModel: HomeViewModelType {
    //MARK: Horizon Functions
    
    func requestAdvertisingIdPermission(){
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            if #available(iOS 14, *) {
//                ATTrackingManager.requestTrackingAuthorization { status in
//                    switch status {
//                    case .authorized:
//                        let advertisingId = ASIdentifierManager.shared().advertisingIdentifier.uuidString
//                        print("Advertising ID Track Authorized", advertisingId)
//                        self.setHorizonAdvertisingId(advertisingId: advertisingId)
//                    case .denied:
//                        print("Advertising ID Track Denied by User")
//                        self.removeHorizonAdvertisingId()
//                    case .notDetermined:
//                        print("Advertising ID Track not determined. Should request permission for user")
//                        self.removeHorizonAdvertisingId()
//                    case .restricted:
//                        print("Advertising ID Track Restricted")
//                        self.removeHorizonAdvertisingId()
//                    @unknown default:
//                        print("Advertising ID Track in Unknown state")
//                        self.removeHorizonAdvertisingId()
//                    }
//                }
//            }
//        }
    }
    
    internal func setHorizonAdvertisingId(advertisingId: String){
        //try? HorizonClient.get().setAdvertisingId(advertisingIdentifier: advertisingId)
    }
    
    internal func removeHorizonAdvertisingId(){
        //try? HorizonClient.get().removeAdvertisingId()
    }
}
