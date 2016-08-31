//
//  LogCountryTests.swift
//  LogCountryTests
//
//  Created by Ezekiel Abuhoff on 8/31/16.
//  Copyright © 2016 Zeke Abuhoff. All rights reserved.
//

import XCTest
@testable import LogCountry

class LogCountryTests: XCTestCase {
    
    // MARK:
    // MARK: Utility
    
    let message = "MESSAGE"
    
    func configurePrefixes() {
        setLogLevelPrefix(forLevel: .Error, to: "ERROR PREFIX: ")
        setLogLevelPrefix(forLevel: .Verbose, to: "VERBOSE PREFIX: ")
        setLogLevelPrefix(forLevel: .Debug, to: "DEBUG PREFIX: ")
    }
    
    func logAtAllLevels() {
        log(.Error, message)
        log(.Verbose, message)
        log(.Debug, message)
    }
    
    // MARK:
    // MARK: Basic Logging
    
    func testLogToSilent() {
        setLogLevel(to: .Silent)
        
        configurePrefixes()
        logAtAllLevels()
    }
    
    func testLogToError() {
        setLogLevel(to: .Error)
        
        configurePrefixes()
        logAtAllLevels()
    }
    
    func testLogToVerbose() {
        setLogLevel(to: .Verbose)
        
        configurePrefixes()
        logAtAllLevels()
    }
    
    func testLogToDebug() {
        setLogLevel(to: .Debug)
        
        configurePrefixes()
        logAtAllLevels()
    }
    
    // MARK:
    // MARK: LogCabin
    
    func testLoggingFromLogCabin() {
        let cabin = LogCabin(level: .Debug)
        cabin.setLogLevelPrefix(forLevel: .Error, to: "CABIN ERROR: ")
        cabin.setLogLevelPrefix(forLevel: .Verbose, to: "CABIN VERBOSE: ")
        cabin.setLogLevelPrefix(forLevel: .Debug, to: "CABIN DEBUG: ")
        
        cabin.log(.Error, message)
        cabin.log(.Verbose, message)
        cabin.log(.Debug, message)
    }
}

