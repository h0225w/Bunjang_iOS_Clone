//
//  SettingView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/24.
//

import UIKit

class SettingView: UITableViewController {
    static let identifier = "SettingView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            LoginService.delete { [weak self] data in
                guard let self = self else { return }
                
                if data.isSuccess {
                    let action = {
                        self.navigationController?.popToRootViewController(animated: false)
                        
                        let storyboard = UIStoryboard.init(name: "Authentication", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "AuthNavigationController") as! UINavigationController
                        self.view.window?.windowScene?.keyWindow?.rootViewController = vc
                    }
                    
                    let alert = Helper().alert(title: "회원 탈퇴", msg: "탈퇴 처리 되었습니다.", action: action)
                    self.present(alert, animated: true)
                } else {
                    let alert = Helper().alert(title: "회원 탈퇴 실패", msg: data.message)
                    self.present(alert, animated: true)
                }
            }
        } else if indexPath.section == 1 {
            LoginService.logout {
                self.navigationController?.popToRootViewController(animated: false)
                
                // TODO: 로그아웃하고 로그인 화면으로 이동 시 "다른 방법으로 로그인" 버튼 눌렀을 때 아무 반응 없는 문제 해결 필요
                let storyboard = UIStoryboard.init(name: "Authentication", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "AuthNavigationController") as! UINavigationController
                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
                sceneDelegate.window?.rootViewController = vc
            }
        }
    }
}

// MARK: - Extension
private extension SettingView {
    func setupNavigationBar() {
        navigationItem.title = "설정"
    }
}
