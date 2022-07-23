//
//  PopoverViewController.swift
//  MenuMission
//
//  Created by Thomas Povinelli on 7/22/22.
//

import Cocoa

class PopoverViewController: NSViewController {
    var menuItemButton: NSButton!
    
    @IBAction func pressedButton(sender: NSButton) {
        NSRunningApplication.current.terminate()
    }
    @IBOutlet weak var missionControlRadio: NSButton!
    @IBOutlet weak var launchPadRadio: NSButton!
    @IBAction func actionSwitch(_ sender: NSButton) {
        let delegate = (NSApplication.shared.delegate as? AppDelegate)
        if sender === missionControlRadio {
            delegate?.setAction(menuItemButton, .missionControl)
        } else {
            delegate?.setAction(menuItemButton, .launchPad)
        }
    }
    
    override func viewDidLoad() {
        let delegate = (NSApplication.shared.delegate as? AppDelegate)
        if delegate?.buttonAction == .missionControl {
            missionControlRadio.state = .on
            launchPadRadio.state = .off
        } else {
            launchPadRadio.state = .on
            missionControlRadio.state = .off
        }
        
    }
    @IBAction func moarButtonClicked(_ sender: NSButton) {
        if !openNew(appName: "MenuMission") {
            let myPopup: NSAlert = NSAlert()
            myPopup.messageText = "Cannot open new instance"
            myPopup.informativeText = "You must place the MenuMission.app Application in your /Applications folder for this function to work"
            myPopup.alertStyle = NSAlert.Style.critical
            myPopup.addButton(withTitle: "OK")
            myPopup.runModal()
        }
    }

}


