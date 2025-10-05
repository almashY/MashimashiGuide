//
//  UnwrappedIBOutlet.swift
//  MashimashiGuide
//
//  Created by 工藤翔太 on 2025/10/04.
//

import Foundation

@propertyWrapper
struct UnwrappedIBOutlet<T> {
    private var core: UnwrappedIBOutletCore<T>
    
    init(){
        self.core = UnwrappedIBOutletCore(errorSender: FALogSender())
    }
    
    var wrappedValue: T {
        get {
            core.wrappedValue
        }
        set {
            core.wrappedValue = newValue
        }
    }
}



protocol IErrorSender {
    func sendError(message: String, code: String)
}

@propertyWrapper
struct UnwrappedIBOutletCore<T> {
    private var storage: T?
    private let errorSender: IErrorSender?
    
    init(errorSender: IErrorSender? = nil){
        self.errorSender = errorSender
    }
    
    var wrappedValue: T {
        get {
            guard let value = storage else {
                fatalError("⚠️ IBOutletがnilです！（接続されていません）")
            }
            errorSender?.sendError(message: "IBOutletの接続に失敗", code: "404")
            return value
        }
        set {
            storage = newValue
        }
    }
}
