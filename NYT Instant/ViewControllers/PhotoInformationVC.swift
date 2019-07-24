//
//  PhotoInformationVC.swift
//  NYT-Instant
//
//  Created by Mieczkowski, Elizabeth on 7/17/19.
//  Copyright © 2019 Mieczkowski, Elizabeth. All rights reserved.
//
import UIKit

class PhotoInformationVC: UIViewController {
    
    var refreshControl: UIRefreshControl!
    var scrollView: UIScrollView!
    
    var mainPhoto: UIImageView!
    var photoUrl: String = ""
    
    var grayBackground: UILabel!
    var logo: UIImageView!
    
    var topicLabel: UILabel!
    var topicText: String = ""
    
    var authorLabel: UILabel!
    var authorText: String = ""
    
    var photoDescriptionLabel: UILabel!
    var photoDescriptionText: String = ""
    
    var locationLabel: UILabel!
    var locationText: String = ""
    
    var locationIcon: UIImageView!
    var shareLabel: UILabel!
    var instagramButton: UIButton!
    var twitterButton: UIButton!
    var facebookButton: UIButton!
    var smsButton: UIButton!
    var mailButton: UIButton!
    var relatedReadingLabel: UILabel!
    
    var articleArray: [ArticleAsset] = []
    
    var tableView: UITableView!
    let reuseIdentifier = "articleCellReuse"
    let cellHeight: CGFloat = 130
    let cellSpacingHeight: CGFloat = 15
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .black
        
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.barStyle = .blackOpaque
        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .black
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = false
        scrollView.autoresizesSubviews = true
        view.addSubview(scrollView)
        
        logo = UIImageView(frame: .zero)
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
        logo.clipsToBounds = true
        logo.image = UIImage(named: "logo")
        navigationItem.titleView = logo
        
        mainPhoto = UIImageView(frame: .zero)
        mainPhoto.translatesAutoresizingMaskIntoConstraints = false
        mainPhoto.contentMode = .scaleAspectFill
        mainPhoto.clipsToBounds = true
        let url = URL(string: photoUrl)!
        downloadImage(from: url)
        scrollView.addSubview(mainPhoto)
        
        grayBackground = UILabel()
        grayBackground.translatesAutoresizingMaskIntoConstraints = false
        grayBackground.backgroundColor = UIColor(white: 0.20, alpha: 1.0)
        grayBackground.clipsToBounds = true
        scrollView.addSubview(grayBackground)
        
        topicLabel = UILabel()
        topicLabel.translatesAutoresizingMaskIntoConstraints = false
        topicLabel.text = topicText
        topicLabel.textColor = .white
        guard let customFont = UIFont(name: "NYTKarnakCondensed-Bold", size: UIFont.labelFontSize + 4) else {
            fatalError("""
        Failed to load the "whatever u wrote" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """
            )
        }
        topicLabel.font = UIFontMetrics.default.scaledFont(for: customFont)
        topicLabel.adjustsFontForContentSizeCategory = true
        topicLabel.textAlignment = .left
        topicLabel.clipsToBounds = true
        scrollView.addSubview(topicLabel)
        
        authorLabel = UILabel()
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.text = authorText
        authorLabel.textColor = .white
        guard let customFont1 = UIFont(name: "NYTFranklin-Bold", size: 9) else {
            fatalError("""
        Failed to load the "whatever u wrote" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """
            )
        }
        authorLabel.font = UIFontMetrics.default.scaledFont(for: customFont1)
        authorLabel.adjustsFontForContentSizeCategory = true
        authorLabel.textAlignment = .left
        authorLabel.clipsToBounds = true
        scrollView.addSubview(authorLabel)
        
        photoDescriptionLabel = UILabel()
        photoDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        photoDescriptionLabel.text = photoDescriptionText
        photoDescriptionLabel.textColor = .lightGray
        photoDescriptionLabel.lineBreakMode = .byWordWrapping
        photoDescriptionLabel.numberOfLines = 0
        photoDescriptionLabel.textColor = UIColor(white: 0.50, alpha: 1.0)
        guard let customFont3 = UIFont(name: "NYTFranklin-Medium", size: 12) else {
            fatalError("""
        Failed to load the "whatever u wrote" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """
            )
        }
        photoDescriptionLabel.font = UIFontMetrics.default.scaledFont(for: customFont3)
        photoDescriptionLabel.adjustsFontForContentSizeCategory = true
        photoDescriptionLabel.textAlignment = .left
        photoDescriptionLabel.clipsToBounds = true
        scrollView.addSubview(photoDescriptionLabel)
        
        //locationLabel = UILabel()
       // locationLabel.translatesAutoresizingMaskIntoConstraints = false
      //  locationLabel.text = locationText
       // locationLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 15)
       // locationLabel.textColor = .lightGray
       // locationLabel.textAlignment = .left
       // locationLabel.clipsToBounds = true
        
        locationLabel = UILabel(frame: .zero)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.text = locationText
        locationLabel.contentMode = .scaleAspectFit
        locationLabel.clipsToBounds = true
        //  locationLabel.text = "Decines, France"
        locationLabel.lineBreakMode = .byWordWrapping        //So that if description is too long
        locationLabel.numberOfLines = 0                      //we don't crop the sentence & just go to the next line.
        locationLabel.textColor = .white
        guard let customFont2 = UIFont(name: "NYTFranklin-Bold", size: 9) else {
            fatalError("""
        Failed to load the "whatever u wrote" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """
            )
        }
        locationLabel.font = UIFontMetrics.default.scaledFont(for: customFont2)
        locationLabel.adjustsFontForContentSizeCategory = true
        scrollView.addSubview(locationLabel)
        
        locationIcon = UIImageView(frame: .zero)
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        locationIcon.contentMode = .scaleAspectFill
        locationIcon.clipsToBounds = true
        locationIcon.image = UIImage(named: "map-marker-alt")
        scrollView.addSubview(locationIcon)
        
        shareLabel = UILabel()
        shareLabel.translatesAutoresizingMaskIntoConstraints = false
        shareLabel.text = "Share:"
        shareLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 19) //TODO: font
        shareLabel.textColor = .white
        shareLabel.textAlignment = .left
        shareLabel.clipsToBounds = true
        scrollView.addSubview(shareLabel)
        
        instagramButton = UIButton()
        instagramButton.translatesAutoresizingMaskIntoConstraints = false
        instagramButton.backgroundColor = .black
        instagramButton.clipsToBounds = true
        //        instagramButton.addTarget(self, action: #selector(pushViewController), for: .touchUpInside) TODO: add functionality to push to instagram
        instagramButton.setBackgroundImage(UIImage(named: "instaIcon"), for: .normal)
        scrollView.addSubview(instagramButton)
        
        twitterButton = UIButton()
        twitterButton.translatesAutoresizingMaskIntoConstraints = false
        twitterButton.backgroundColor = .black
        twitterButton.clipsToBounds = true
        //        instagramButton.addTarget(self, action: #selector(pushViewController), for: .touchUpInside) TODO: add functionality to push to twitter
        twitterButton.setBackgroundImage(UIImage(named: "twitterIcon"), for: .normal)
        scrollView.addSubview(twitterButton)
        
        facebookButton = UIButton()
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        facebookButton.backgroundColor = .black
        facebookButton.clipsToBounds = true
        //        instagramButton.addTarget(self, action: #selector(pushViewController), for: .touchUpInside) TODO: add functionality to push to facebook
        facebookButton.setBackgroundImage(UIImage(named: "facebookIcon"), for: .normal)
        scrollView.addSubview(facebookButton)
        
        smsButton = UIButton()
        smsButton.translatesAutoresizingMaskIntoConstraints = false
        smsButton.backgroundColor = .black
        smsButton.clipsToBounds = true
        //        instagramButton.addTarget(self, action: #selector(pushViewController), for: .touchUpInside) TODO: add functionality to push to sms
        smsButton.setBackgroundImage(UIImage(named: "smsIcon"), for: .normal)
        scrollView.addSubview(smsButton)
        
        mailButton = UIButton()
        mailButton.translatesAutoresizingMaskIntoConstraints = false
        mailButton.backgroundColor = .black
        mailButton.clipsToBounds = true
        //        instagramButton.addTarget(self, action: #selector(pushViewController), for: .touchUpInside) TODO: add functionality to push to sms
        mailButton.setBackgroundImage(UIImage(named: "mailIcon"), for: .normal)
        scrollView.addSubview(mailButton)
        
        relatedReadingLabel = UILabel()
        relatedReadingLabel.translatesAutoresizingMaskIntoConstraints = false
        relatedReadingLabel.text = "Related Reading:"
        relatedReadingLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 19)
        relatedReadingLabel.textColor = .white
        relatedReadingLabel.textAlignment = .left
        relatedReadingLabel.clipsToBounds = true
        scrollView.addSubview(relatedReadingLabel)
        
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none //hide the horizontal lines
        tableView.register(ArticleCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.backgroundColor = .black
        tableView.bounces = true
        tableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 3000)
        scrollView.addSubview(tableView)
        
        setUpConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 4000)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo:view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo:view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            mainPhoto.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor),
            mainPhoto.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainPhoto.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainPhoto.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor, constant: 230)
            ])
        NSLayoutConstraint.activate([
            grayBackground.topAnchor.constraint(equalTo: mainPhoto.bottomAnchor),
            grayBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            grayBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            grayBackground.bottomAnchor.constraint(equalTo: photoDescriptionLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10)
            ])
        
        NSLayoutConstraint.activate([
            topicLabel.topAnchor.constraint(equalTo: mainPhoto.bottomAnchor, constant: 20),
            topicLabel.heightAnchor.constraint(equalToConstant: 40),
            topicLabel.leadingAnchor.constraint(equalTo: mainPhoto.leadingAnchor, constant: 20),
            topicLabel.trailingAnchor.constraint(equalTo: mainPhoto.trailingAnchor)
            ])
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: topicLabel.bottomAnchor, constant: 3),
            authorLabel.leadingAnchor.constraint(equalTo: topicLabel.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            authorLabel.heightAnchor.constraint(equalToConstant: 30)
            ])
        NSLayoutConstraint.activate([
            photoDescriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 3),
            photoDescriptionLabel.leadingAnchor.constraint(equalTo: topicLabel.leadingAnchor),
            photoDescriptionLabel.trailingAnchor.constraint(equalTo: mainPhoto.trailingAnchor, constant: -30)
            ])
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: topicLabel.topAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -110),
            locationLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            locationLabel.bottomAnchor.constraint(equalTo: topicLabel.bottomAnchor)
            ])
        NSLayoutConstraint.activate([
            locationIcon.topAnchor.constraint(equalTo: locationLabel.topAnchor),
            locationIcon.heightAnchor.constraint(equalToConstant: 12),
            locationIcon.widthAnchor.constraint(equalToConstant: 10),
            locationIcon.trailingAnchor.constraint(equalTo: locationLabel.leadingAnchor, constant: -5),
            locationIcon.bottomAnchor.constraint(equalTo: locationLabel.bottomAnchor),
            ])
        NSLayoutConstraint.activate([
            shareLabel.topAnchor.constraint(equalTo: photoDescriptionLabel.bottomAnchor, constant: 40),
            shareLabel.leadingAnchor.constraint(equalTo: topicLabel.leadingAnchor),
            shareLabel.heightAnchor.constraint(equalToConstant: 15)
            ])
        NSLayoutConstraint.activate([
            instagramButton.topAnchor.constraint(equalTo: shareLabel.topAnchor),
            instagramButton.leadingAnchor.constraint(equalTo: shareLabel.trailingAnchor, constant: 30),
            instagramButton.widthAnchor.constraint(equalToConstant: 20),
            instagramButton.heightAnchor.constraint(equalToConstant: 20)
            ])
        NSLayoutConstraint.activate([
            twitterButton.topAnchor.constraint(equalTo: shareLabel.topAnchor),
            twitterButton.leadingAnchor.constraint(equalTo: instagramButton.trailingAnchor, constant: 30),
            twitterButton.widthAnchor.constraint(equalToConstant: 20),
            twitterButton.heightAnchor.constraint(equalToConstant: 20)
            ])
        NSLayoutConstraint.activate([
            facebookButton.topAnchor.constraint(equalTo: shareLabel.topAnchor),
            facebookButton.leadingAnchor.constraint(equalTo: twitterButton.trailingAnchor, constant: 30),
            facebookButton.widthAnchor.constraint(equalToConstant: 20),
            facebookButton.heightAnchor.constraint(equalToConstant: 20)
            ])
        NSLayoutConstraint.activate([
            smsButton.topAnchor.constraint(equalTo: shareLabel.topAnchor),
            smsButton.leadingAnchor.constraint(equalTo: facebookButton.trailingAnchor, constant: 30),
            smsButton.widthAnchor.constraint(equalToConstant: 20),
            smsButton.heightAnchor.constraint(equalToConstant: 20)
            ])
        NSLayoutConstraint.activate([
            mailButton.topAnchor.constraint(equalTo: shareLabel.topAnchor),
            mailButton.leadingAnchor.constraint(equalTo: smsButton.trailingAnchor, constant: 30),
            mailButton.widthAnchor.constraint(equalToConstant: 20),
            mailButton.heightAnchor.constraint(equalToConstant: 20)
            ])
        NSLayoutConstraint.activate([
            relatedReadingLabel.topAnchor.constraint(equalTo: instagramButton.bottomAnchor, constant: 40),
            relatedReadingLabel.leadingAnchor.constraint(equalTo: topicLabel.leadingAnchor),
            relatedReadingLabel.trailingAnchor.constraint(equalTo: mailButton.trailingAnchor),
            relatedReadingLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: relatedReadingLabel.bottomAnchor, constant: 10),
            tableView.heightAnchor.constraint(equalToConstant: 400)
            ])
    }
    
    @objc func pulledToRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.refreshControl.endRefreshing()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    @objc func backAction(){
        dismiss(animated: true, completion: nil)
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.mainPhoto.image = UIImage(data: data)
            }
        }
    }
}

extension PhotoInformationVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ArticleCell
        if(indexPath.item < self.articleArray.count) {
            cell.articleAuthorLabel.text = articleArray[indexPath.item].articleAuthor
            cell.articleDateLabel.text = articleArray[indexPath.item].articleDate + "  "
            cell.articleHeadlineLabel.text = articleArray[indexPath.item].articleHeadline
            cell.articleURL = articleArray[indexPath.item].articleUrl
        }
            return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
}

extension PhotoInformationVC: UITableViewDelegate {
    
    /// Tell the table view what height to use for each row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    /// Tell the table view what should happen if we select a row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ArticleCell
        let url = cell.articleURL
        let webVC = ArticleWebVC(articleURL: url)
        navigationController?.pushViewController(webVC, animated: true)
    }
}
