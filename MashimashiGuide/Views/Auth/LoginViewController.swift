
import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController {
    
    @IBOutlet weak var GoogleSignInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ボタンをタップした時のアクションを指定。SignInファンクションを呼び出すよ。
        GoogleSignInButton.addTarget(self, action: #selector(SignIn), for: .touchUpInside)
    }
    
    @objc func SignIn() {
        print("サインインします。")
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Google Sign-Inの設定を準備
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // サインイン開始（UIViewControllerを渡す！）
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard
                let user = result?.user,
                let idToken = user.idToken?.tokenString
            else {
                return
            }
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase Sign-In error: \(error.localizedDescription)")
                    return
                }
                print("Googleアカウントでサインしました。")
                // ✅ ログイン成功時に画面遷移
                self.switchToMain()
            }
        }
    }
    
    // LoginViewController 内
    private func switchToMain() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate,
              let window = sceneDelegate.window else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
        
        window.rootViewController = tabBarController
        
        
    }

}
