//
//  AppDelegate.swift
//  MenuMission
//
//  Created by Thomas Povinelli on 7/22/22.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusItem: NSStatusItem!
    private(set) var buttonAction: ButtonAction = .missionControl
    
    
    static var delegate: AppDelegate {
        NSApplication.shared.delegate as! AppDelegate
    }
    
    private static let missionControlIcon = NSImage(systemSymbolName: "macwindow.on.rectangle", accessibilityDescription: "Mission Control")
    private static let launchpadIcon = NSImage(systemSymbolName: "rectangle.grid.3x2", accessibilityDescription: "Launchpad")
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem = createStatusItem()
    }
    
    private func createStatusItem() -> NSStatusItem {
        let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem.button {
            button.image = AppDelegate.missionControlIcon
            button.sendAction(on: [.rightMouseUp, .leftMouseUp])
            button.action = #selector(performButtonAction)
        }
        return statusItem
    }
    
    @objc
    func performButtonAction(sender: NSButton) {
        if NSApp.currentEvent?.type == NSEvent.EventType.rightMouseUp {
            let popover = NSPopover()
            popover.contentViewController = NSStoryboard.main?.instantiateController(identifier: "popovercontroller")
            (popover.contentViewController as? PopoverViewController)?.menuItemButton = sender
            popover.behavior = .transient
            popover.animates = true
            popover.show(relativeTo: sender.bounds, of: sender, preferredEdge: .minY)
            return
        } else {
            if (buttonAction == .missionControl)
            {
                showMissionControl()
            } else {
                showLaunchpad()
            }
        }
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
    
    func setAction(_ menuButton: NSButton?, _ action: ButtonAction) {
        buttonAction = action
        menuButton?.image = action == .missionControl ? AppDelegate.missionControlIcon : AppDelegate.launchpadIcon
    }
}
