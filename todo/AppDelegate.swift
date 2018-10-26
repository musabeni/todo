//
//  AppDelegate.swift
//  todo
//
//  Created by Musa Beni on 02/10/2018.
//  Copyright © 2018 Musa Beni. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        
       
        
        
        
        do{
            _ = try Realm()
        
        }catch{
            print("Realm throw an error \(error)")
        }
        
        return true
    }

    



}
