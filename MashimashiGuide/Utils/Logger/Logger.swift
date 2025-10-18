//
//  Logger.swift
//  MashimashiGuide
//
//  Created by 工藤翔太 on 2025/10/18.
//

import Foundation

enum LogLevel: String {
    case debug = "DEBUG"
    case info = "INFO"
    case warning = "WARNING"
    case error = "ERROR"
}

final class Logger {
    static let shared = Logger()
    private let dateFormatter: DateFormatter
    
    var minimumLogLevel: LogLevel = .debug
    
    private init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    }
    
    private func log(_ message: String, level: LogLevel,
                     file: String = #file, function: String = #function, line: Int = #line) {
        guard shouldLog(level) else { return }
        
        let timestamp = dateFormatter.string(from: Date())
        let fileName = (file as NSString).lastPathComponent
        print("\(timestamp) [\(level.rawValue)] [\(fileName):\(line)] \(function) - \(message)")
    }
    
    private func shouldLog(_ level: LogLevel) -> Bool {
        let order: [LogLevel] = [.debug, .info, .warning, .error]
        guard
            let minIndex = order.firstIndex(of: minimumLogLevel),
            let currentIndex = order.firstIndex(of: level)
        else { return true }
        return currentIndex >= minIndex
    }
    
    func d(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .debug, file: file, function: function, line: line)
    }
    
    func i(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .info, file: file, function: function, line: line)
    }
    
    func w(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .warning, file: file, function: function, line: line)
    }
    
    func e(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .error, file: file, function: function, line: line)
    }
}

/// グローバルエイリアス
let log = Logger.shared
