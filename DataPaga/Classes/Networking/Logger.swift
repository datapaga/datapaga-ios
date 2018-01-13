//
//  Logger.swift
//  datapaga-ios
//
//  Created by Jonathan Solorzano on 1/3/18.
//  https://www.linkedin.com/in/felixsolorzano
//  Copyright © 2018 datapaga. All rights reserved.
//

import Foundation

// Enum for showing the type of Log Types
enum LogEvent: String {
    case error = "[🔥]" // error
    case info = "[ℹ️]" // info
    case warning = "[⚠️]" // warning
}

class Logger {
    
    static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    class func log(_ exception: DataPagaException, event: LogEvent, fileName: String = #file, line: Int = #line, column: Int = #column,funcName: String = #function) {
        
        #if DEBUG
            print("\(Date().toString()) \(event.rawValue) \(funcName) DataPaga -> [\(exception.error.code)]: \(exception.error.message)")
        #endif
    }
}

internal extension Date {
    func toString() -> String {
        return Logger.dateFormatter.string(from: self as Date)
    }
}
