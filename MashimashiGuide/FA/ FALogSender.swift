//
//   FALogSender.swift
//  MashimashiGuide
//
//  Created by 工藤翔太 on 2025/10/04.
//

import FirebaseAnalytics

class FALogSender: IErrorSender {
    
    func sendError(message: String, code: String) {
        Analytics.logEvent("log_error", parameters: [
            "message": message,
            "error_code": code
        ])
    }
    
}
