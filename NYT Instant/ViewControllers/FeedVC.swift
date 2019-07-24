//
//  FeedVC.swift
//  NYT Instant
//
//  Created by Mejia, Clint on 7/16/19.
//  Copyright © 2019 Toualbi, Amine. All rights reserved.
//

import UIKit
import Firebase

class FeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cellHeight : CGFloat = 370
    let cellSpacingHeight: CGFloat = 20
    let reuseIdentifier = "PostCell"
    
    var ref: DatabaseReference!
    
    var posts : Array<PostAsset> = Array()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
        for family: String in UIFont.familyNames
        {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
        
        ref = Database.database().reference()
        
        retrievePosts()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.rowHeight = cellHeight + 20
        self.setNavigationBar()
        setupConstraints()
    }
    
    
    func retrievePosts() {

        var refHandle = ref.child("photos").observe(DataEventType.value, with: { (snapshot) in
            let enumerator = snapshot.children
            var newPosts : Array<PostAsset> = Array()
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


                newPosts.append(retrievedPost)
            }
            self.posts = newPosts
            self.tableView.reloadData()
        })


    }

    //Use SafeLayoutGuide when using top & bottom anchors.
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    }
    

    func setNavigationBar() {
        let logo = UIImage(named: "toolbar_logo.png")
        let imageView = UIImageView(image:logo)
        navigationItem.titleView = imageView
    }
    
    //Update content when coming back to the view.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("didAppear()")
        self.tableView.reloadData()
    }
    
}


extension FeedVC: UITableViewDataSource {
    
    //Function how many sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Function that decides what each cell will look like.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //We use reusable cells like RecyclerView.
        //PostCell identifies the prototype cell we are using.
        print("currentPathItem = " + String(indexPath.item))
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PostTableCell
        cell.authorLabel.text = posts[indexPath.item].author
        cell.descriptionLabel.text = posts[indexPath.item].description
        cell.locationLabel.text = posts[indexPath.item].location
        cell.topicLabel.text = posts[indexPath.item].topic
        cell.photo.pin_updateWithProgress = true
        cell.photo.pin_setImage(from: URL(string: posts[indexPath.item].imageURL))
        
        return cell
    }
    
    // How many cells do we want
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0) {
            return 0
        }
        
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width,
                                              height: cellSpacingHeight))
        headerView.backgroundColor = .black
        return headerView
    }
    
}

extension FeedVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    //What to do when someone clicks on a cell in the table.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PostTableCell
        let vc = PhotoInformationVC()
        let post = posts[indexPath.item]
        vc.photoUrl = post.imageURL
        vc.authorText = post.author
        vc.topicText = post.topic
        vc.locationText = post.location
        vc.photoDescriptionText = post.description
        vc.articleArray = post.articles
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
