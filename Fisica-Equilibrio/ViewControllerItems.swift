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
    
    @IBAction func changePage(_ sender: Any) {
        switch pcIndex.currentPage {
        case 0:
            cvBlocks.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
        case 1:
            cvBlocks.scrollToItem(at: IndexPath(item: 6, section: 0), at: .centeredHorizontally, animated: true)
        case 2:
            cvBlocks.scrollToItem(at: IndexPath(item: 12, section: 0), at: .centeredHorizontally, animated: true)
        default:
            cvBlocks.scrollToItem(at: IndexPath(item: 19, section: 0), at: .right, animated: true)
        }
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
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvBlocks.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        
        cell.imgBlock.image = UIImage(named: "\((indexPath.row + 1) * 5)")
        cell.lbWeight.text = String((indexPath.row + 1) * 5) + " Kg"
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(cvBlocks.contentOffset.x)
        
        if cvBlocks.contentOffset.x < 550 {
            pcIndex.currentPage = 0
        }
        else if cvBlocks.contentOffset.x < 1100 {
            pcIndex.currentPage = 1
        }
        else if cvBlocks.contentOffset.x < 1295 {
            pcIndex.currentPage = 2
        }
        else {
            pcIndex.currentPage = 3
        }
    }
}
