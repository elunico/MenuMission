//
//  LaunchUtils.swift
//  MenuMission
//
//  Created by Thomas Povinelli on 7/22/22.
//

import Foundation

func runAll(executablePaths: [String]) -> Bool {
    for path in executablePaths {
        if run(executablePath: path) {
            return true
        }
    }
    return false
}

func run(executablePath: String) -> Bool{
    let missionControl = URL(fileURLWithPath: executablePath)
    if missionControl.isFileURL && (try? missionControl.checkResourceIsReachable()) != nil {
        let p = Process()
        p.executableURL = missionControl
        if (try? p.run()) == nil {
            return false
        }
        return true
    }
    return false
}

fileprivate func open(appName: String, arguments: [String]) -> Bool {
    let open = URL(fileURLWithPath: "/usr/bin/open")
    if open.isFileURL && (try? open.checkResourceIsReachable()) != nil {
        let p = Process()
        p.executableURL = open
        p.arguments = arguments
        if (try? p.run()) == nil {
            return false
        }
        return true
    }
    return false
}

@discardableResult
func open(appName: String) -> Bool {
    let arguments = ["-a", appName]
    return open(appName: appName, arguments: arguments)
}
