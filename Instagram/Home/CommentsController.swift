//
//  CommentsController.swift
//  Instagram
//
//  Created by AHMED on 2/10/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import UIKit
import Firebase
class CommentsController : UICollectionViewController,UICollectionViewDelegateFlowLayout {
    var comments = [Comment]()
    var post:Post?
    let cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .onDrag
        navigationItem.title = "Comments"
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: cellId)
        fetchComments()
    }
    fileprivate func fetchComments() {
        print("Fetching comments..")
        guard let postId = self.post?.id else {return}
        let ref = Database.database().reference().child("comments").child(postId)
        ref.observe(.childAdded, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String:Any] else {return}
            guard let uid = dictionary["uid"] as? String else {return}
            
            Database.fetchUserWithUID(uid: uid) { (user) in
                let comment = Comment(user: user, dictionary: dictionary)
                self.comments.append(comment)
                self.collectionView.reloadData()
            }
            
        }) { (err) in
            print("Failed to observe comments")
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CommentCell
        cell.comment = comments[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 0)
        let dummyCell = CommentCell(frame: frame)
        dummyCell.comment = comments[indexPath.row]
        dummyCell.layoutIfNeeded()
        let targetSize = CGSize(width: view.frame.width, height: 0)
        let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
        let height = max(40 + 8 + 8 , estimatedSize.height)
        return CGSize(width: view.frame.width, height: height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar.isHidden = true
    }
    let commentTextField :UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter comment"
        return tf
    }()
    lazy var containerView:UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.frame = CGRect(x: 0, y: 0, width:100, height: 50)
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        containerView.addSubview(submitButton)
        submitButton.setAnchor(top: containerView.topAnchor, left: nil, right: containerView.rightAnchor, bottom: containerView.bottomAnchor, paddingBottom: 0, paddingLeft: 0, paddingRight: 12, paddingTop: 0, height: 0, width: 50)
        containerView.addSubview(commentTextField)
        commentTextField.setAnchor(top: containerView.topAnchor, left: containerView.leftAnchor, right: submitButton.leftAnchor, bottom: containerView.bottomAnchor, paddingBottom: 0, paddingLeft: 5, paddingRight: 0, paddingTop: 0, height: 0, width: 0)
        let lineSeparatorView = UIView()
        lineSeparatorView.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        containerView.addSubview(lineSeparatorView)
        lineSeparatorView.setAnchor(top: containerView.topAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, bottom: nil, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, paddingTop: 0, height: 0.5, width: 0)
        return containerView
    }()
    
    @objc func handleSubmit() {
        print("Handling submit...")
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let postId = post?.id ?? ""
        let values = ["text":commentTextField.text ?? "","creationDate":Date().timeIntervalSince1970,"uid":uid] as [String : Any]
        Database.database().reference().child("comments").child(postId).childByAutoId().updateChildValues(values) { (err, ref) in
            if let err = err {
                print("failed to upload comments",err)
                return
            }
            print("Successfully inserted comment.")
            self.commentTextField.text = ""
        }
    }
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    override var canBecomeFirstResponder: Bool {
        return true
    }
}
