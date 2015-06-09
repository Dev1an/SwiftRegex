//
//  AppDelegate.swift
//  SwiftRegex
//
//  Created by John Holdsworth on 26/06/2014.
//  Copyright (c) 2014 John Holdsworth. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application( application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]? ) -> Bool {
        // Override point for customization after application launch.

        // for usage see SwiftRegexTests and ViewController

        let input = "Now is the time for all good men to come to the aid of the party"
        //let mtbl:NSMutableString = input

        let words:[String] = input["(\\w+)"].matches()
        let groups:[[String]] = input["(\\w)(\\w+)"].allGroups()

        print(words)
        print(groups)

        if input["good"] {
            print("good")
        }

        let output = input["men"] ~= "people"

        print(output)

        let mutable = RegexMutable( input )

        mutable["men"] ~= "folk"
        mutable["the party"] ~= "their country"

        _ = mutable["(\\w+) (men|people|folk)"][1]

        mutable["(good) (\\w+)"][1] = "great"

        print(mutable)

        // "Now is the time for all great folk to come to the aid of their country"

        mutable["\\w+"] ~= {
            (match: String) in
            return match.uppercaseString
        }

        print(mutable)
        // "NOW IS THE TIME FOR ALL GREAT FOLK TO COME TO THE AID OF THEIR COUNTRY"

        mutable["(\\w)(\\w+)"] ~= {
            (groups: [String]) in
            return groups[1]+groups[2].lowercaseString
        }

        print(mutable)
        // "Now Is The Time For All Great Folk To Come To The Aid Of Their Country"

        let props = "name1=value1\nname2='value2\nvalue2\n'\n"
        let dict:[String:String] = props["(\\w+)=('[^']*'|.*)"].dictionary()
        // ["name1": "value1", "name2": "'value2\nvalue2\n'"]

        print(dict)

        return true
    }

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

