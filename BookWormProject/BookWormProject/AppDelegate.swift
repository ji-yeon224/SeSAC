//
//  AppDelegate.swift
//  BookWormProject
//
//  Created by 김지연 on 2023/07/31.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let config = Realm.Configuration(schemaVersion: 3) { migration, oldSchemaVersion in
            
            if oldSchemaVersion < 1 { } // dateColumn delete
            
            if oldSchemaVersion < 2 {  // poster -> posterURL column name change
                migration.renameProperty(onType: BookTable.className(), from: "poster", to: "posterURL")
            }
            
            if oldSchemaVersion < 3 { // author + publisher -> info column add
                migration.enumerateObjects(ofType: BookTable.className()) { oldObject, newObject in
                    guard let old = oldObject else { return }
                    guard let new = newObject else { return }
                    
                    new["info"] = "\(old["author"] ?? "")) | \(old["publisher"] ?? "")"
                }
            }
            
            
        }
        
        Realm.Configuration.defaultConfiguration = config
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

