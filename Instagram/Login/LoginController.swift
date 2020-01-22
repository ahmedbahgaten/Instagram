//
//  LoginController.swift
//  Instagram
//
//  Created by AHMED on 1/22/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import UIKit
class LoginController:UIViewController {
    let signUpButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't have an account? SignUp." , for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    @objc func handleShowSignUp() {
        let SignUpController = signUpController()
        navigationController?.pushViewController(SignUpController,animated:true)
    }
    let logoContainerView :UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 0, green: 120, blue: 175)
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        logoImageView.contentMode = .scaleAspectFill
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)]
            )
            logoImageView.translatesAutoresizingMaskIntoConstraints = false
            
            return view
    }()
    let emailTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
//        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    let passwordTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
//        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    let loginButton :UIButton = {
          let button = UIButton(type: .system)
          button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
          button.layer.cornerRadius = 5
          button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
          button.setTitleColor(.white, for: .normal)
          button.setTitle("Login", for: .normal)
//          button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
          button.isEnabled = false
          return button
      }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        view.addSubview(signUpButton)
        view.addSubview(logoContainerView)
        
        signUpButton.anchor(top: nil, left: view.leftAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, paddingBottom: -10, paddingLeft: 0, paddingRight: 0, paddingTop: 0, height: 0, width: 0)
        logoContainerView .anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, paddingTop: 0, height: 150, width: 0)
        setupInputFields()
    }
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,loginButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.anchor(top: logoContainerView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingBottom: 0, paddingLeft: 40, paddingRight: 40, paddingTop: 40, height: 140, width: 0)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
