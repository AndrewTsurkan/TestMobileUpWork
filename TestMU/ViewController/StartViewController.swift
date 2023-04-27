//
//  ViewController.swift
//  TestMU
//
//  Created by Андрей Цуркан on 22.04.2023.
//

import UIKit

class StartViewController: UIViewController {
    
    private var authService: AuthService!
    private let haederLabel = UILabel()
    private let enterButton = UIButton()
    private var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHaederLabel()
        setupEnterButton()
        view.backgroundColor = UIColor(named: "colorSetDark")
        authService = SceneDelegate.shared().authService
    }
    
    private func setupHaederLabel() {
        view.addSubview(haederLabel)
        haederLabel.translatesAutoresizingMaskIntoConstraints = false
        
        haederLabel.text = "Mobile\u{00A0}Up\nGallery"
        haederLabel.font = UIFont(name: "SFProText-Bold", size: 44)
        haederLabel.numberOfLines = 2
        haederLabel.textColor = UIColor(named: "colorSetLight")
        
        [haederLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: screenHeight/4),
         haederLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
         haederLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)].forEach{ $0.isActive = true }
    }
    
    private func setupEnterButton() {
        view.addSubview(enterButton)
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        
        enterButton.setTitle("Вход через VK", for: .normal)
        enterButton.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 15)
        enterButton.backgroundColor = UIColor(named: "colorSetLight")
        enterButton.layer.cornerRadius = 12
        enterButton.setTitleColor(UIColor(named: "colorSetDark"), for: .normal)
        enterButton.addTarget(self, action: #selector(actionEnterButton), for: .touchUpInside)
        
        [enterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42),
         enterButton.heightAnchor.constraint(equalToConstant: 52),
         enterButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
         enterButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)].forEach{ $0.isActive = true }
    }
    
    @objc func actionEnterButton() {
        authService.wakeUpSession()
    }
    
}

