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
    case Silent = 0
    case Error
    case Verbose
    case Debug
}

// MARK:
// MARK: Automatic Configuration

private func detectDefaultLevel() -> LogLevel {
    #if LOGLEVELSILENT
        return LogLevel.Silent
    #elseif LOGLEVELVERBOSE
        return LogLevel.Verbose
    #elseif LOGLEVELDEBUG
        return LogLevel.Debug
    #endif
    
    return LogLevel.Error
}

private var globalLevel: LogLevel = detectDefaultLevel()
private var globalPrefixes: [LogLevel : String] = [.Error : "",
                                                   .Verbose : "VERBOSE: ",
                                                   .Debug : "DEBUG: "]

// MARK:
// MARK: User-Facing Functions

public func log(_ message: String) {
    log(.Error, message)
}

public func log(_ targetLevel: LogLevel, _ message: String) {
    guard targetLevel != .Silent else { return }
    if targetLevel.rawValue <= globalLevel.rawValue {
        if let prefix = globalPrefixes[targetLevel] {
            print(prefix + message)
        } else {
            print(message)
        }
    }
}

public func currentLogLevel() -> LogLevel {
    return globalLevel
}

public func setLogLevel(to targetLogLevel: LogLevel) {
    globalLevel = targetLogLevel
}

public func setLogLevelPrefix(forLevel targetLevel: LogLevel, to newPrefix: String) {
    globalPrefixes[targetLevel] = newPrefix
}

// MARK:
// MARK: LogCabin

public class LogCabin {
    public var level: LogLevel = detectDefaultLevel()
    private var prefixes: [LogLevel : String] = [.Error : "",
                                                 .Verbose : "VERBOSE: ",
                                                 .Debug : "DEBUG: "]
    
    public convenience init() {
        self.init(level: .Error)
    }
    
    public init(level targetLogLevel: LogLevel) {
        self.level = targetLogLevel
    }
    
    public func log(_ message: String) {
        self.log(.Error, message)
    }
    
    public func log(_ targetLevel: LogLevel, _ message: String) {
        guard targetLevel != .Silent else { return }
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
