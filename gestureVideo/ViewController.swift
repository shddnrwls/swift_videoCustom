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
    @IBOutlet var durationLbl: UILabel!
    @IBOutlet var currentLbl: UILabel!
    @IBOutlet var timeSlider: UISlider!
    var player : AVPlayer!
    var playerLayer : AVPlayerLayer!
    var isVideoPlayer = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://s3.ap-northeast-2.amazonaws.com/project-sm/%EC%B2%AD%ED%95%98+(CHUNG+HA)+-+Roller+Coaster+MV.mp4")!
        player = AVPlayer(url: url)
        player.currentItem?.addObserver(self, forKeyPath: "duration", options: [.new,.initial], context: nil)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resize
        
        videoView.layer.addSublayer(playerLayer)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = videoView.frame
    }

    @IBAction func playAction(_ sender: UIButton) {
        if isVideoPlayer{
            player.pause()
            sender.setTitle("Play", for: .normal)
        }else {
            player.play()
            sender.setTitle("Pause", for: .normal)
        }
        isVideoPlayer = !isVideoPlayer
    }
    @IBAction func forwardAction(_ sender: UIButton) {
        guard let duration = player.currentItem?.duration else{ return }
        let currentTime = CMTimeGetSeconds(player.currentTime())
        let newTime = currentTime + 10.0
        
        if newTime < (CMTimeGetSeconds(duration) - 10.0){
            let time: CMTime = CMTimeMake(Int64(newTime*1000), 1000)
            player.seek(to: time)
        }
    }
    
    @IBAction func backwardAction(_ sender: UIButton) {
        let currentTime = CMTimeGetSeconds(player.currentTime())
        var newTime = currentTime - 10.0
        if newTime < 0 {
            newTime = 0
        }
        let time: CMTime = CMTimeMake(Int64(newTime*1000), 1000)
        player.seek(to: time)
        
    }
    @IBAction func sliderChangeAction(_ sender: UISlider) {
    }
}

