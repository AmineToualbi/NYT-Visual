//
//  ExploreVC.swift
//  NYT Instant
//
//  Created by Mejia, Clint on 7/16/19.
//  Copyright © 2019 Toualbi, Amine. All rights reserved.
//

import UIKit
import Firebase

class ExploreVC: UIViewController {

    // Mark: - Properties
    let exploreCollectionView = ExploreDeskCollectionView()
    var ref: DatabaseReference!
    var desks = [String: [PostAsset]]()

    // Mark: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        setDelegates()
        setupView()
        setUpData()
    }

    // Mark: - setup methods
    private func setNavigationBar() {
        let logo = UIImage(named: "toolbar_logo.png")
        let imageView = UIImageView(image:logo)
        navigationItem.titleView = imageView
        navigationItem.title = "Explore"
    }

    private func setDelegates() {
        exploreCollectionView.deskCollectionView.dataSource = self
        exploreCollectionView.deskCollectionView.delegate = self
    }

    private func setUpData() {
        ref = Database.database().reference()
        retrievePosts()
    }

    private func setupView() {
        self.view.backgroundColor = UIColor.black
        exploreCollectionViewConstraints()
    }

    // Mark: - constraints
    private func exploreCollectionViewConstraints() {
        view.addSubview(exploreCollectionView)
        exploreCollectionView.translatesAutoresizingMaskIntoConstraints = false
        exploreCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        exploreCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        exploreCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        exploreCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        exploreCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    // Mark: - helper function
    func retrievePosts() {

        var refHandle = ref.child("photos").observe(DataEventType.value, with: { (snapshot) in
            let enumerator = snapshot.children
            var data = [String: [PostAsset]]()

            while let listObject = enumerator.nextObject() as? DataSnapshot {

                let post = listObject.value as! [String: AnyObject]
                let imageURL = post["imageUrl"] as! String
                let author = post["author"] as! String
                let description = post["description"] as! String
                let location = post["location"] as! String
                let topic = post["topic"] as! String
                let desk = post["desk"] as! String

                let tags = post["tags"] as! [String]

                let articleDict = post["articles"] as! [String: [String: String]]
                var articles: [ArticleAsset] = []
                for (key, value) in articleDict {
                    guard
                        let data = try? JSONSerialization.data(withJSONObject: value, options: []),
                        let article = try? JSONDecoder().decode(ArticleAsset.self, from: data) else {
                            continue
                    }

                    articles.append(article)
                }

                 let retrievedPost = PostAsset(postImageURL: imageURL, postAuthor: author, postDescription: description, postLocation: location, postTopic: topic, postDesk: desk, postTags: tags, postArticles: articles)

                if data.keys.contains(desk) {
                    data[desk]?.append(retrievedPost)
                } else {
                    data[desk] = [retrievedPost]
                }

            }

            self.desks.merge(dict: data)
            DispatchQueue.main.async {
                self.exploreCollectionView.deskCollectionView.reloadData()
            }
        })


    }
}

extension ExploreVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return desks.keys.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreDeskCollectionViewCell.identifier, for: indexPath) as! ExploreDeskCollectionViewCell
        cell.delegate = self
        let deskKeys = Array(desks.keys)
        let title = deskKeys[indexPath.row]
        let postAsset = desks[title]!
        cell.configureDeskCell(with: title, and: postAsset)

        return cell
    }
}

extension ExploreVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 205)
    }
}

extension ExploreVC: ExploreAssetCellDelegate {
    func pushPhotoPage(for post: PostAsset) {
        let vc = PhotoInformationVC()
        vc.photoUrl = post.imageURL
        vc.authorText = post.author
        vc.topicText = post.topic
        vc.locationText = post.location
        vc.photoDescriptionText = post.description
        vc.articleArray = post.articles
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
