//
//  Block.swift
//  Fisica-Equilibrio
//
//  Created by user190336 on 5/1/21.
//

import UIKit

class Block: NSObject {
    var weight: Int
    var image: UIImage
    
    init(weight: Int, image: UIImage) {
        self.weight = weight
        self.image = image
    }
}
