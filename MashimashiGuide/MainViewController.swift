//
//  ViewController.swift
//  MashimashiGuide
//
//  Created by 工藤翔太 on 2025/06/17.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 基本ルール画面を初期選択にする
        self.selectedIndex = 0
        
        // タブバーのカラーを変更する
        changeTaBarColor(.white)
    }
    
    func changeTaBarColor(_ barColor: UIColor) {
        // UITabBarの外観を設定
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = barColor
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        
        // タブバーアイテムの色
        UITabBar.appearance().tintColor = UIColor.red
        UITabBar.appearance().unselectedItemTintColor = UIColor.darkGray
        
        // 既存のタブバーに変更を反映させる
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            for view in window.subviews {
                view.removeFromSuperview()
                window.addSubview(view)
            }
        }
        
    }
    
}

