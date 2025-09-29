//
//  serverTaskWithAsyncAwait.swift
//  MashimashiGuide
//
//  Created by 工藤翔太 on 2025/09/29.
//
import Foundation

class serverTaskWithAsyncAwait {
    
    private func task1() async -> Int{
        sleep(2)
        print("Task1完了")
        return 3
    }
    
    private func task2() async -> Int{
        sleep(1)
        print("Task2完了")
        return 1
    }
    
    func executeBothTask() async throws -> Int {
        let num1 = await task1()
        let num2 = await task2()
        return num1 + num2
    }
    
}
