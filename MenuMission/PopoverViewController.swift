//
//  PopoverViewController.swift
//  MenuMission
//
//  Created by Thomas Povinelli on 7/22/22.
//

import Cocoa

class PopoverViewController: NSViewController {
    weak var statusItem: MenuMissionItem!

    @IBOutlet weak var missionControlRadio: NSButton!
    @IBOutlet weak var launchPadRadio: NSButton!
    @IBOutlet weak var removeButton: NSButton!
    
    override func viewDidLoad() {
        if statusItem.action == .missionControl {
            missionControlRadio.state = .on
            launchPadRadio.state = .off
        } else {
            launchPadRadio.state = .on
            missionControlRadio.state = .off
        }
        if AppDelegate.delegate.statusItemCount <= 1 {
            removeButton?.isEnabled = false
        }
        
    }
    
    @IBAction func actionSwitch(_ sender: NSButton) {
        if sender === missionControlRadio {
            statusItem.setAction(.missionControl)
        } else {
            statusItem.setAction(.launchPad)
        }
    }
    
    @IBAction func pressedButton(sender: NSButton) {
        NSRunningApplication.current.terminate()
    }
    
    @IBAction func moarButtonClicked(_ sender: NSButton) {
        AppDelegate.delegate.newStatusItem()
    }
    
    @IBAction func removePressed(_ sender: Any) {
        AppDelegate.delegate.removeItem(self.statusItem)
    }
}


