//
//  ViewController.swift
//  TruNarutoClient
//
//  Created by Nurlan on 18/03/2017.
//  Copyright © 2017 Nurlan. All rights reserved.
//

import UIKit

class CharacterListViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var collectionView: UICollectionView!
    var characterList: Array<CharacterListItem?> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        NarutoCharactersAPI.getCharacterList(page: 1, onComplite: loadData)
    }

    func loadData(data: Data?, response: URLResponse?, err: Error?) {
        var json: Dictionary<String, AnyObject>?
        do {
            json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? Dictionary<String, AnyObject>
        } catch {
            print(error)
        }

        for (characterName, url) in json! {
            characterList.append(CharacterListItem(name: characterName, img: URL(string: url as! String)!))
            print(characterName, "ok")
        }
        print(characterList.count)
        collectionView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
    }

    private func configureUI() {
        view.backgroundColor = UIColor.white

        // Configure CollectionView
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 80, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 150, height: 120)

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: "characterCell")

        collectionView.backgroundColor = UIColor.white
        view.addSubview(collectionView)

        // Configure Navbar
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 70))
        navbar.tintColor = UIColor.lightGray
        let navItem = UINavigationItem(title: "Select Character")
        let navBarbutton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: nil)
        navItem.leftBarButtonItem = navBarbutton
        navbar.items = [navItem]
        view.addSubview(navbar)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterList.count
    }

    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath as IndexPath) as! CharacterCell
        cell.backgroundColor = UIColor.orange
        let name = (characterList[indexPath.row]?.name)!
        let img = characterList[indexPath.row]?.img
        cell.initUI(img: img, title: name)
        return cell
    }
}

import UIKit
class CharacterCell: UICollectionViewCell {
    private var myLabel: UILabel?
    private var imageView: UIImageView?

    public func initUI(img: URL?, title: String) {

        if (imageView == nil) {
            myLabel = UILabel()
            imageView = UIImageView()
            addSubview(myLabel!)
            addSubview(imageView!)
        }
        downloadImage(url: img!)


        myLabel!.text = title.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        myLabel!.font = UIFont(name: "HelveticaNeue", size: 14)
        myLabel!.backgroundColor = UIColor.blue
        myLabel!.sizeToFit()
        myLabel!.frame.origin = CGPoint(x: frame.width - (myLabel?.frame.width)! - 7, y: frame.height - 15)
        layer.cornerRadius = 8
    }

    func downloadImage(url: URL) {
        Server.getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { () -> Void in
                self.imageView!.image = UIImage(data: data)!
                self.imageView!.frame.size = CGSize(width: self.frame.width, height: self.frame.height)
            }
        }
    }
}

