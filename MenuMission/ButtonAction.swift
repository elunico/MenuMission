//
//  ButtonAction.swift
//  MenuMission
//
//  Created by Thomas Povinelli on 7/22/22.
//

import Foundation

enum ButtonAction {
    case missionControl
    case launchPad
}

public let kMissionControlActionString = "missioncontrol"
public let kLaunchpadActionString = "launchpad"

func actionFromString(_ string: String) -> ButtonAction {
    switch string {
    case kMissionControlActionString:
        return .missionControl
    case kLaunchpadActionString:
        return .launchPad
    default:
        fatalError("No such action \(string)")
    }
}


func stringForAction(_ action: ButtonAction) -> String {
    switch action {
    case .missionControl:
        return kMissionControlActionString
    case .launchPad:
        return kLaunchpadActionString
    }
}
