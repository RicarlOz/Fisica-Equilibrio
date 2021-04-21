//
//  ViewControllerItems.swift
//  
//
//  Created by user190336 on 4/20/21.
//

import UIKit

class ViewControllerItems: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var pcIndex: UIPageControl!
    @IBOutlet weak var cvBlocks: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgView.layer.cornerRadius = 10
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ViewControllerItems:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Hi")
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print((indexPath.row + 1) * 5)
        let cell = cvBlocks.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        
        cell.imgBlock.image = UIImage(named: "\((indexPath.row + 1) * 5)")
        cell.lbWeight.text = String((indexPath.row + 1) * 5)
        
        return cell
    }
    
    
}
