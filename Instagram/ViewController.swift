//
//  ViewController.swift
//  Instagram
//
//  Created by AHMED on 1/11/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let plusButtonPhoto: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let signUpButton :UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("SignUp", for: .normal)
        return button
    }()
    let emailTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let usernameTextField:UITextField = {
          let tf = UITextField()
          tf.placeholder = "Username"
          tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
          tf.borderStyle = .roundedRect
          tf.font = UIFont.systemFont(ofSize: 14)
          tf.translatesAutoresizingMaskIntoConstraints = false
          return tf
      }()
    let passwordTextField:UITextField = {
          let tf = UITextField()
          tf.placeholder = "Password"
        tf.isSecureTextEntry = true
          tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
          tf.borderStyle = .roundedRect
          tf.font = UIFont.systemFont(ofSize: 14)
          tf.translatesAutoresizingMaskIntoConstraints = false
          return tf
      }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(plusButtonPhoto)
        NSLayoutConstraint.activate([
            plusButtonPhoto.heightAnchor.constraint(equalToConstant: 140),
            plusButtonPhoto.widthAnchor.constraint(equalToConstant: 140),
            plusButtonPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusButtonPhoto.topAnchor.constraint(equalTo: view.topAnchor, constant: 40)
        ])
        setupInputFields()
        

    }
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField,usernameTextField,passwordTextField,signUpButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: plusButtonPhoto.bottomAnchor, constant: 20),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            stackView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
















