//
//  LogCountryTests.swift
//  LogCountryTests
//
//  Created by Ezekiel Abuhoff on 10/2/16.
//  Copyright © 2016 Zeke Abuhoff. All rights reserved.
//

import XCTest
@testable import LogCountry

class LogCountryTests: XCTestCase {
    
    // MARK:
    // MARK: Utility
    
    let message = "MESSAGE"
    
    func configurePrefixes() {
        setLogLevelPrefix(forLevel: .error, to: "ERROR PREFIX: ")
        setLogLevelPrefix(forLevel: .verbose, to: "VERBOSE PREFIX: ")
        setLogLevelPrefix(forLevel: .debug, to: "DEBUG PREFIX: ")
    }
    
    func logAtAllLevels() {
        log(.error, message)
        log(.verbose, message)
        log(.debug, message)
    }
    
    func readFile(named fileName: String) -> String? {
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let path = dir.appendingPathComponent(fileName)
        
        do {
            let text = try String(contentsOf: path, encoding: .utf8)
            return text
        }
        catch { return nil }
    }
    
    func deleteFile(named fileName: String) {
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let path = dir.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: path)
        } catch { return }
    }
    
    // MARK:
    // MARK: Basic Logging
    
    func testLogToSilent() {
        setLogLevel(to: .silent)
        
        configurePrefixes()
        logAtAllLevels()
    }
    
    func testLogToError() {
        setLogLevel(to: .error)
        
        configurePrefixes()
        logAtAllLevels()
    }
    
    func testLogToVerbose() {
        setLogLevel(to: .verbose)
        
        configurePrefixes()
        logAtAllLevels()
    }
    
    func testLogToDebug() {
        setLogLevel(to: .debug)
        
        configurePrefixes()
        logAtAllLevels()
    }
    
    // MARK:
    // MARK: LogCabin
    
    func testLoggingFromLogCabin() {
        let cabin = LogCabin(level: .debug)
        cabin.setLogLevelPrefix(forLevel: .error, to: "CABIN ERROR: ")
        cabin.setLogLevelPrefix(forLevel: .verbose, to: "CABIN VERBOSE: ")
        cabin.setLogLevelPrefix(forLevel: .debug, to: "CABIN DEBUG: ")
        
        cabin.log(.error, message)
        cabin.log(.verbose, message)
        cabin.log(.debug, message)
    }
    
    // MARK:
    // MARK: Log to File
    
    func testLogToFile() {
        let fileName = "bean"
        deleteFile(named: fileName)
        
        writeLogs(to: fileName)
        
        configurePrefixes()
        logAtAllLevels()
        
        let whatIRead = readFile(named: fileName)
        guard let presentLogs = whatIRead else { XCTFail(); return }
        XCTAssert(presentLogs == "ERROR PREFIX: MESSAGE\nVERBOSE PREFIX: MESSAGE\nDEBUG PREFIX: MESSAGE")
    }
}
