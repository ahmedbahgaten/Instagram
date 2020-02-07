//
//  UserProfileController.swift
//  Instagram
//
//  Created by AHMED on 1/13/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import UIKit
import Firebase
class UserProfileController:UICollectionViewController,UICollectionViewDelegateFlowLayout {
    var posts = [Post]()
    var user:User?
    let cellID = "collectionViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        collectionView.register(UserProfilePhotoCell.self, forCellWithReuseIdentifier: cellID)
        setupLogOutButton()
        fetchUser()
        fetchOrderedPosts()
    }
    fileprivate func fetchOrderedPosts() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("posts").child(uid)
        ref.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String:Any] else {return}
            guard let user = self.user else {return}
            let post = Post(user:user,dictionary: dictionary)
            self.posts.insert(post, at: 0)
            self.collectionView.reloadData()
        }) { (err) in
            print("Failed to Fetch Ordered Posts",err.localizedDescription)
        }
    }
    
    fileprivate func setupLogOutButton () {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear"), style: .plain, target: self, action: #selector(handleLogOut))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    @objc func handleLogOut () {
        let Alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let logOutAction = UIAlertAction(title: "Log Out", style: .destructive) { (_) in
            do {
                try Auth.auth().signOut()
                let loginViewController = LoginController()
                self.navigationController?.pushViewController(loginViewController, animated: true)
                
            } catch let signOutError {
                print("Failed to sign out",signOutError)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        Alert.addAction(logOutAction)
        Alert.addAction(cancelAction)
        present(Alert,animated: true,completion: nil)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3) / 3
        return CGSize(width: width, height: width)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! UserProfilePhotoCell
        cell.post = posts[indexPath.row]
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! UserProfileHeader
        header.backgroundColor = .white
        header.user = self.user
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200 )
    }
    
    fileprivate func fetchUser () {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.fetchUserWithUID(uid: uid) { (user) in
            self.user = user
            self.navigationItem.title = self.user?.username
            self.collectionView.reloadData()
        }
    }
}

