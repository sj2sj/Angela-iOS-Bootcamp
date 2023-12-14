//
//  AppDelegate.swift
//  Todoey
//
//  Created by Philipp Muellauer on 01/09/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
      //print(Realm.Configuration.defaultConfiguration.fileURL)
      //print("version: \(Realm.Configuration.defaultConfiguration.schemaVersion)")
      
      do {
        _ = try Realm()
      } catch {
        print("Error initialising new Realm, \(error)")
      }
      
      return true
    }


}
