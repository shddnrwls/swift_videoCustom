//
//  MainViewController.swift
//  gestureVideo
//
//  Created by mac on 2018. 4. 12..
//  Copyright © 2018년 swift. All rights reserved.
//

import UIKit

class MainViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    

    let videoTitle = ["청하-롤러코스터","청하-롤러코스터","청하-롤러코스터"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! VideoCollectionViewCell
        cell.titleLbl.text = videoTitle[indexPath.row]
        cell.userLbl.text = "노욱진"
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "videoView") as! ViewController
        self.present(view, animated: true, completion: nil)
    }



}
