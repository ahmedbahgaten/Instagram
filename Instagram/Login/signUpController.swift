//
//  ViewController.swift
//  Instagram
//
//  Created by AHMED on 1/11/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import UIKit
import Firebase
class signUpController: UIViewController , UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    let plusButtonPhoto: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        return button
    }()
    let signUpButton :UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("SignUp", for: .normal)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    @objc func handlePlusPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController,animated: true,completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            plusButtonPhoto.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        else if let editedImage =  info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            plusButtonPhoto.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        plusButtonPhoto.layer.cornerRadius = plusButtonPhoto.layer.frame.width/2
        plusButtonPhoto.layer.masksToBounds = true
        plusButtonPhoto.layer.borderWidth = 1
        plusButtonPhoto.layer.borderColor = UIColor.black.cgColor
        
        dismiss(animated: true, completion: nil)

    }
    @objc func handleSignUp() {
        guard let email = emailTextField.text , email.isEmpty == false  else {return}
        guard let username = usernameTextField.text , username.isEmpty == false  else {return}
        guard let password = passwordTextField.text , password.isEmpty == false  else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self]  (user , error) in
            if let err = error {
                print("Failed to create a user",err)
                return
            }
            print("Successfully created")
            
            guard let self = self else {return}
            guard let image = self.plusButtonPhoto.imageView?.image else {return}
            guard let uploadData = image.jpegData(compressionQuality: 0.3) else {return}
            let filename = NSUUID().uuidString
            Storage.storage().reference().child("profile_images").child(filename).putData(uploadData, metadata: nil) { (metaData, err) in
                if let err = err {
                    print("Failed to upload profile image",err)
                    return
                }
                print("Successfully uploaded")
                guard let userID = Auth.auth().currentUser?.uid else {return}
                let storageImageRef = Storage.storage().reference().child("profile_images").child(filename)
                storageImageRef.downloadURL { (url, err) in
                    if let profileImageURL = url?.absoluteString {
                        let dictionaryValues = ["username":username,"profileImageURL":profileImageURL]
                        let values = [userID:dictionaryValues]
                        Database.database().reference().child("users").updateChildValues(values) { (err, ref) in
                            if let err = err {
                                print ("Failed",err)
                                return
                            }
                            print("Successfully created a user")
                        }
                    }
                }
                
                         
            }
        }
    }


let emailTextField:UITextField = {
    let tf = UITextField()
    tf.placeholder = "Email"
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.borderStyle = .roundedRect
    tf.font = UIFont.systemFont(ofSize: 14)
    tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    return tf
}()
@objc func handleTextInputChange() {
    let isFormValid = emailTextField.text!.count > 0 && usernameTextField.text!.count > 0 && passwordTextField.text!.count > 0
    if isFormValid {
        signUpButton.isEnabled = true
        signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        
    }
    else {
        signUpButton.isEnabled = false
        signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
    }
}


let usernameTextField:UITextField = {
    let tf = UITextField()
    tf.placeholder = "Username"
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.borderStyle = .roundedRect
    tf.font = UIFont.systemFont(ofSize: 14)
    tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    return tf
}()
let passwordTextField:UITextField = {
    let tf = UITextField()
    tf.placeholder = "Password"
    tf.isSecureTextEntry = true
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.borderStyle = .roundedRect
    tf.font = UIFont.systemFont(ofSize: 14)
    tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    return tf
}()
override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(plusButtonPhoto)
    plusButtonPhoto.anchor(top: view.topAnchor, left: nil, right: nil, bottom: nil, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, paddingTop: 40, height: 140, width: 140)
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















