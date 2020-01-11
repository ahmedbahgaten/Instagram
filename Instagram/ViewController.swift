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
        return button
    }()
    let signUpButton :UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
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
        return tf
    }()
    let usernameTextField:UITextField = {
          let tf = UITextField()
          tf.placeholder = "Username"
          tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
          tf.borderStyle = .roundedRect
          tf.font = UIFont.systemFont(ofSize: 14)
          return tf
      }()
    let passwordTextField:UITextField = {
          let tf = UITextField()
          tf.placeholder = "Password"
        tf.isSecureTextEntry = true
          tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
          tf.borderStyle = .roundedRect
          tf.font = UIFont.systemFont(ofSize: 14)
          return tf
      }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(plusButtonPhoto)
        plusButtonPhoto.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, paddingTop: 40, height: 140, width: 140)
        plusButtonPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        setupInputFields()
    }
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField,usernameTextField,passwordTextField,signUpButton])
        view.addSubview(stackView)
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.anchor(top: plusButtonPhoto.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingBottom: 0, paddingLeft: 40, paddingRight: 40, paddingTop: 20, height: 200, width: 0)
    }
}
extension UIView {
    func anchor(top:NSLayoutYAxisAnchor? ,left:NSLayoutXAxisAnchor?,right:NSLayoutXAxisAnchor?,bottom:NSLayoutYAxisAnchor?,paddingBottom:CGFloat,paddingLeft:CGFloat,paddingRight:CGFloat, paddingTop :CGFloat,height:CGFloat,width:CGFloat ) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
        self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
    }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
    }
}
}
















