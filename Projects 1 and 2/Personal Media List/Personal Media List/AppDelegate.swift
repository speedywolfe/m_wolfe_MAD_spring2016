//
//  AppDelegate.swift
//  Personal Media List
//
//  Created by Mitchell Wolfe on 2/29/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
// app icon partial credit: Television by Alexandr Cherkinsky from the Noun Project
// app icon partial credit: Video Game Controller by Joe Harrison from the Noun Project

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        let config = RealmConfiguration.defaultConfiguration
//        if let path = config.path {
//            try NSFileManager().removeItemAtPath(path)
//        }
        // Override point for customization after application launch.
//        let config = Realm.Configuration(
//            schemaVersion: 1,
//            migrationBlock: { migration, oldSchemaVersion in
//                if (oldSchemaVersion < 1) {
//                    print(oldSchemaVersion)
//                    
//                }
//            })
//        Realm.Configuration.defaultConfiguration = config
        
        return true
    }
    
//    public Realm buildDatabase(){
//        RealmConfiguration realmConfiguration = new RealmConfiguration.Builder(this).build();
//    
//        try {
//            return Realm.getInstance(realmConfiguration);
//        } catch (RealmMigrationNeededException e){
//        try {
//            Realm.deleteRealm(realmConfiguration);
//            //Realm file has been deleted.
//            return Realm.getInstance(realmConfiguration);
//        } catch (Exception ex){
//            throw ex;
//            //No Realm file to remove.
//            }
//        }
//    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

