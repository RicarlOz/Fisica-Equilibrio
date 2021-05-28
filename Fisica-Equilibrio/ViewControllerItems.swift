//
//  ViewControllerItems.swift
//  
//
//  Created by user190336 on 4/20/21.
//

import UIKit
import AVFoundation

protocol AddBrickProtocol {
    func addBrick(brickWeight: Int)
}

class ViewControllerItems: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var pcIndex: UIPageControl!
    @IBOutlet weak var cvBlocks: UICollectionView!
    var delegate : AddBrickProtocol!
    var player: AVAudioPlayer?
    var sound: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = cvBlocks.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            let size = CGSize(width: cvBlocks.frame.width / 3, height: cvBlocks.frame.height / 2 - 20)
            layout.itemSize = size
        }
        
        bgView.layer.cornerRadius = 10
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    @IBAction func changePage(_ sender: Any) {
        switch pcIndex.currentPage {
        case 0:
            cvBlocks.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
            pcIndex.currentPage = 0
        case 1:
            cvBlocks.scrollToItem(at: IndexPath(item: 6, section: 0), at: .centeredHorizontally, animated: true)
            pcIndex.currentPage = 1
        case 2:
            cvBlocks.scrollToItem(at: IndexPath(item: 12, section: 0), at: .centeredHorizontally, animated: true)
            pcIndex.currentPage = 2
        default:
            cvBlocks.scrollToItem(at: IndexPath(item: 19, section: 0), at: .right, animated: true)
            pcIndex.currentPage = 3
        }
    }
    
    // MARK: - Collection View Protocol Methods
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
        
        if cvBlocks.contentOffset.x < cvBlocks.frame.width {
            pcIndex.currentPage = 0
        }
        else if cvBlocks.contentOffset.x < cvBlocks.frame.width * 2 {
            pcIndex.currentPage = 1
        }
        else if cvBlocks.contentOffset.x < cvBlocks.frame.width * 3 {
            pcIndex.currentPage = 2
        }
        else {
            pcIndex.currentPage = 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        playSound(sound: "button")
        delegate.addBrick(brickWeight: (indexPath.row + 1) * 5)
        dismiss(animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    //funcion para reproducir sonido
    func playSound(sound: String) {
        let pathToSound = Bundle.main.path(forResource: sound, ofType: "mp3")!
        let url = URL(fileURLWithPath: pathToSound)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            if self.sound {
                player?.play()
            }
        } catch {
            print("hubo un error con el sonido: " + sound)
        }
    }
    
}
