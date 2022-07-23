//
//  MenuMissionItem.swift
//  MenuMission
//
//  Created by Thomas Povinelli on 7/23/22.
//

import Cocoa

class MenuMissionItem: Identifiable {
    var item: NSStatusItem
    var action: ButtonAction
    private var initialized: Bool = false
    
    static func icon(forAction action: ButtonAction) -> NSImage? {
        action == .missionControl ? NSImage(systemSymbolName: "macwindow.on.rectangle", accessibilityDescription: "Mission Control") :
        NSImage(systemSymbolName: "rectangle.grid.3x2", accessibilityDescription: "Launchpad")
    }
    
    init(item: NSStatusItem, action: ButtonAction = .missionControl) {
        self.item = item
        self.action = action
    }
    
    func loadStatusItem() {
        guard let button = item.button else { fatalError() }
        button.image = MenuMissionItem.icon(forAction: action)
        button.sendAction(on: [.rightMouseUp, .leftMouseUp])
        button.action = #selector(performButtonAction)
        button.target = self
        initialized = true
    }
    
    @objc
    func performButtonAction(sender: NSButton) {
        guard initialized else { fatalError("You forgot to call loadStatusItem()") }
        if NSApp.currentEvent?.type == NSEvent.EventType.rightMouseUp {
            let popover = NSPopover()
            popover.contentViewController = NSStoryboard.main?.instantiateController(identifier: "popovercontroller")
            (popover.contentViewController as? PopoverViewController)?.statusItem = self
            popover.behavior = .transient
            popover.animates = true
            popover.show(relativeTo: sender.bounds, of: sender, preferredEdge: .minY)
            return
        } else {
            if (action == .missionControl)
            {
                AppDelegate.delegate.showMissionControl()
            } else {
                AppDelegate.delegate.showLaunchpad()
            }
        }
    }
    
    func setAction(_ action: ButtonAction) {
        self.action = action
        item.button?.image = MenuMissionItem.icon(forAction: action)
    }
}
