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
}
