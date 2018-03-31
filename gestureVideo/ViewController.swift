//
//  ViewController.swift
//  gestureVideo
//
//  Created by mac on 2018. 3. 30..
//  Copyright © 2018년 swift. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{
    
    @IBOutlet var videoView: UIView!
    var player : AVPlayer!
    var playerLayer : AVPlayerLayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://s3.ap-northeast-2.amazonaws.com/project-sm/%EC%B2%AD%ED%95%98+(CHUNG+HA)+-+Roller+Coaster+MV.mp4")!
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resize
        
        videoView.layer.addSublayer(playerLayer)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player.play()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = videoView.frame
    }


}

