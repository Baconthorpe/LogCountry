//
//  LogCountry.swift
//  LogCountry
//
//  Created by Ezekiel Abuhoff on 8/30/16.
//  Copyright © 2016 Baconthorpe. All rights reserved.
//

import Foundation

// MARK: Log Level

public enum LogLevel: Int {
    case silent = 0
    case error
    case verbose
    case debug
}

// MARK:
// MARK: Automatic Configuration

private func detectDefaultLevel() -> LogLevel {
    #if LOGLEVELSILENT
        return LogLevel.silent
    #elseif LOGLEVELVERBOSE
        return LogLevel.verbose
    #elseif LOGLEVELDEBUG
        return LogLevel.debug
    #endif
    
    return LogLevel.error
}

// MARK:
// MARK: Singleton

let mainCabin = LogCabin(level: detectDefaultLevel())

// MARK:
// MARK: User-Facing Functions

public func log(_ message: String) {
    log(.error, message)
}

public func log(_ targetLevel: LogLevel, _ message: String) {
    mainCabin.log(targetLevel, message)
}

public func currentLogLevel() -> LogLevel {
    return mainCabin.level
}

public func setLogLevel(to targetLogLevel: LogLevel) {
    mainCabin.level = targetLogLevel
}

public func setLogLevelPrefix(forLevel targetLevel: LogLevel, to newPrefix: String) {
    mainCabin.setLogLevelPrefix(forLevel: targetLevel, to: newPrefix)
}

// MARK:
// MARK: LogCabin

public class LogCabin {
    public var level: LogLevel = detectDefaultLevel()
    private var prefixes: [LogLevel : String] = [.error : "",
                                                 .verbose : "VERBOSE: ",
                                                 .debug : "DEBUG: "]
    
    public convenience init() {
        self.init(level: .error)
    }
    
    public init(level targetLogLevel: LogLevel) {
        self.level = targetLogLevel
    }
    
    public func log(_ message: String) {
        self.log(.error, message)
    }
    
    public func log(_ targetLevel: LogLevel, _ message: String) {
        guard targetLevel != .silent else { return }
        if targetLevel.rawValue <= self.level.rawValue {
            if let prefix = self.prefixes[targetLevel] {
                print(prefix + message)
            } else {
                print(message)
            }
        }
    }
    
    public func setLogLevelPrefix(forLevel targetLevel: LogLevel, to newPrefix: String) {
        self.prefixes[targetLevel] = newPrefix
    }
}
