//
//  QuizViewController.swift
//  Fisica-Equilibrio
//
//  Created by user189096 on 4/20/21.
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var imgBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgBackground.image = UIImage(named: "quiz-background")
    }

    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
