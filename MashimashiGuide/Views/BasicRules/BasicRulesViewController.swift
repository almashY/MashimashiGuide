//
//  BasicRulesViewController.swift
//  MashimashiGuide
//
//  Created by 工藤翔太 on 2025/10/19.
//

import UIKit

class BasicRulesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func didTapLogout(_ sender: Any) {
        let alert = UIAlertController(title: "サインアウト", message: "本当にサインアウトしますか？", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "サインアウト", style: .destructive) { [weak self] _ in
            AuthService.shared.signOut { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success():
                        // 画面遷移（Login へ）
                        self?.switchToLogin()
                    case .failure(let error):
                        let err = UIAlertController(title: "エラー", message: error.localizedDescription, preferredStyle: .alert)
                        err.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(err, animated: true)
                    }
                }
            }
        })
        present(alert, animated: true)
    }
    
    // root を Login に差し替える補助（下に詳細）
    private func switchToLogin() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = scene.delegate as? SceneDelegate,
              let window = delegate.window else {
            return
        }
        let loginStoryboard = UIStoryboard(name: "LoginViewController", bundle: nil)
        let loginVC = loginStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
        let nav = UINavigationController(rootViewController: loginVC)
        window.rootViewController = nav
        UIView.transition(with: window, duration: 0.35, options: .transitionCrossDissolve, animations: nil)
    }
}
