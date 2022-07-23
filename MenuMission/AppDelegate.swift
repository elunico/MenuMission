//
//  AppDelegate.swift
//  MenuMission
//
//  Created by Thomas Povinelli on 7/22/22.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    static let kCountKey = "itemCount"
    static var delegate: AppDelegate {
        NSApplication.shared.delegate as! AppDelegate
    }
    static func itemActionKey(forIndex index: Int) -> String {
        "item-\(index)-action"
    }

    private var menuMissionItems: [MenuMissionItem] = []

    var statusItemCount: Int {
        menuMissionItems.count
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let defaults = UserDefaults()
        for i in 0..<max(defaults.integer(forKey: AppDelegate.kCountKey), 1) {
            if let type = defaults.string(forKey: AppDelegate.itemActionKey(forIndex: i)) {
                menuMissionItems.append(createStatusItem(withAction: actionFromString(type)))
            } else {
                menuMissionItems.append(createStatusItem(withAction: .missionControl))
            }
        }
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        let defaults = UserDefaults()
        defaults.set(menuMissionItems.count, forKey: AppDelegate.kCountKey)
        for (i, item) in menuMissionItems.enumerated() {
            let key = AppDelegate.itemActionKey(forIndex: i)
            let value = stringForAction(item.action)
            defaults.set(value, forKey: key)
        }
    }
    
    func removeItem(_ item: MenuMissionItem?) {
        menuMissionItems.removeAll(where: { $0 === item })
    }
    
    func newStatusItem() {
        menuMissionItems.append(createStatusItem(withAction: .missionControl))
    }
    
    private func createStatusItem(withAction action: ButtonAction) -> MenuMissionItem {
        let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        let menuItem = MenuMissionItem(item: statusItem, action: action)
        menuItem.loadStatusItem()
        return menuItem
    }
        
    func showLaunchpad() {
        if runAll(executablePaths: ["/System/Applications/Mission Control.app/Contents/MacOS/Launchpad", "/Applications/Mission Control.app/Contents/MacOS/Launchpad"]) {
            return
        }
        
        open(appName: "Launchpad.app")
    }
    
    func showMissionControl() {
        if runAll(executablePaths: ["/System/Applications/Mission Control.app/Contents/MacOS/Mission Control", "/Applications/Mission Control.app/Contents/MacOS/Mission Control"]) {
            return
        }
        
        open(appName: "Mission Control.app")
    }

}
