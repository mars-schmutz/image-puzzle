//
//  AppDelegate.swift
//  image-puzzle
//
//  Created by Marshall Schmutz on 11/30/22.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    let nc = NotificationCenter.default
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    @IBAction func useMountain(_ sender: NSMenuItem) {
        nc.post(name: Notification.Name("useMountain"), object: nil)
    }
    
    @IBAction func usePhone(_ sender: NSMenuItem) {
        nc.post(name: Notification.Name("usePhone"), object: nil)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

