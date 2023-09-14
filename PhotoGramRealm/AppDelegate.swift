//
//  AppDelegate.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/03.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        let config = Realm.Configuration(schemaVersion: 5) { migration, oldSchemaVersion in
            
            if oldSchemaVersion < 1 { } // diaryPin Column 추가
            
            if oldSchemaVersion < 2 { } //diaryPin Column
            
            if oldSchemaVersion < 3 {
                
                migration.renameProperty(onType: DiaryTable.className(), from: "diaryPhoto", to: "photo")
                
            } //diaryPhoto -> photo column 변경
            
            if oldSchemaVersion < 4 { } // diaryContent -> content
            
            if oldSchemaVersion < 5 { // diarySummary 컬럼 추가, title + contents 합쳐서 넣기
                
                migration.enumerateObjects(ofType: DiaryTable.className()) { oldObject, newObject in
                    
                    guard let new = newObject else { return }
                    guard let old = oldObject else { return }
                    new["diarySummary"] = "제목은 '\(String(describing: old["diaryTitle"]))'이고, 내용은 '\(String(describing: old["contents"]))'입니다."
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

