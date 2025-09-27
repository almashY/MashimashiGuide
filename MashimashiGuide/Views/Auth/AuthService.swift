// AuthService.swift
import Foundation
import FirebaseAuth
import GoogleSignIn

final class AuthService {
    static let shared = AuthService()
    private init() {}
    
    /// サインアウト（Firebase と Google の両方）
    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        // 1) Firebase からサインアウト（throws）
        do {
            try Auth.auth().signOut()
        } catch {
            completion(.failure(error))
            return
        }
        
        // 2) Google サインアウト（ローカル状態をクリア）
        GIDSignIn.sharedInstance.signOut()
        
        // 3) （任意）Google のアクセス権を完全に取り消す場合:
        // GIDSignIn.sharedInstance.disconnect { error in ... } // 必要なら使う
        
        // 4) ローカルに保存しているアプリ固有データを消す
        // UserDefaults.standard.removeObject(forKey: "someKey")
        // Keychain で保存しているトークンがあれば削除する
        
        completion(.success(()))
    }
}
