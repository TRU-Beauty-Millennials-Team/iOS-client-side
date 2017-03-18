//
//  CharacterListItem.swift
//  TruNarutoClient
//
//  Created by Nurlan on 18/03/2017.
//  Copyright © 2017 Nurlan. All rights reserved.
//

import Foundation
import UIKit

class CharacterListItem {
    var name: String
    var img: URL?

    init(name: String, img: URL) {
        self.name = name
        self.img = img
    }

}
