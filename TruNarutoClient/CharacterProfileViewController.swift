//
//  CharacterProfileViewController.swift
//  TruNarutoClient
//
//  Created by Nurlan on 18/03/2017.
//  Copyright © 2017 Nurlan. All rights reserved.
//

import Foundation
import UIKit

class CharacterProfileViewController: UIViewController {

    var name: String = ""

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor.white
        NarutoCharactersAPI.getCharacter(name: name, onComplite: loadData)
    }

    func loadData(data: Data?, response: URLResponse?, err: Error?) {
        var json: Dictionary<String, AnyObject>?
        do {
            json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? Dictionary<String, AnyObject>
        } catch {
            print(error)
        }

        for (_, text) in json! {
            let info = UILabel()
            info.numberOfLines = 0
            info.text = (text as! String).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            print(info.text)
            info.sizeToFit()
            info.textColor = UIColor.black
            info.frame = CGRect(x: 5, y: 5, width: self.view.frame.width, height: self.view.frame.height)
            print(info.frame)
            self.view.addSubview(info)
        }
    }


}
