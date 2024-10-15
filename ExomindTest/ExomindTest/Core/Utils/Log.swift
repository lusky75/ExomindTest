//
//  Log.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 15/10/2024.
//

import Foundation

/**
 Simple Logger class
 */
struct Log {
    /// Prints in debug only
    static func debug(_ msg: Any, line: Int = #line, fileName: String = #file, funcName: String = #function, tag: String = "DEBUG") {
        let fname = (fileName as NSString).lastPathComponent
        let dateToPrint = DateFormatter.loggerDateFormatter.string(from: Date())
        print("[\(tag)][\(fname) \(funcName):\(line)][\(dateToPrint)]", msg)
    }
    
    /// Prints an error message in debug only
    static func error(_ msg: Any, line: Int = #line, fileName: String = #file, funcName: String = #function) {
        debug(msg, line: line, fileName: fileName, funcName: funcName, tag: "ERROR")
    }
}

fileprivate extension DateFormatter {
    static let loggerDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSSS"
        return formatter
    }()
}
