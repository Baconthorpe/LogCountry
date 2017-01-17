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
// MARK: Singleton

let mainCabin = LogCabin(level: .error)

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

public func writeLogs(to file: String) {
    mainCabin.write(to: file)
}

public func stopWritingLogsToFile() {
    mainCabin.stopWritingToFile()
}

// MARK:
// MARK: LogCabin

public class LogCabin {
    public var level: LogLevel = .error
    private var writePath: String?
    private var prefixes: [LogLevel : String] = [.error : "",
                                                 .verbose : "VERBOSE: ",
                                                 .debug : "DEBUG: "]
    
    public convenience init() {
        self.init(level: .error)
    }
    
    public init(level targetLogLevel: LogLevel) {
        self.level = targetLogLevel
    }
    
    public func write(to file: String) {
        writePath = file
    }
    
    public func stopWritingToFile() {
        writePath = nil
    }
    
    public func log(_ message: String) {
        self.log(.error, message)
    }
    
    public func log(_ targetLevel: LogLevel, _ message: String) {
        logToFileIfAppropriate(targetLevel, message: message)
        
        guard targetLevel != .silent else { return }
        if targetLevel.rawValue <= self.level.rawValue {
            print((self.prefixes[targetLevel] ?? "") + message)
        }
    }
    
    public func setLogLevelPrefix(forLevel targetLevel: LogLevel, to newPrefix: String) {
        self.prefixes[targetLevel] = newPrefix
    }
    
    private func logToFileIfAppropriate(_ targetLevel: LogLevel, message: String) {
        guard let specifiedWritePath = self.writePath else { return }
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let assembledMessage = (self.prefixes[targetLevel] ?? "") + message
        let appendingMessage = "\n\(assembledMessage)"
        let path = dir.appendingPathComponent(specifiedWritePath)
        
        var fileExists = false
        do {
            let reachable = try path.checkResourceIsReachable()
            fileExists = reachable
        } catch { }
        
        if fileExists {
            do {
                let data: Data = appendingMessage.data(using: .utf8)!
                let fileHandle = try FileHandle(forWritingTo: path)
                
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
            } catch { return }
        } else {
            do {
                try assembledMessage.write(to: path, atomically: true, encoding: .utf8)
            }
            catch { return }
        }
    }
}
