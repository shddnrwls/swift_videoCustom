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
        addTimeObserver()
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
        player.seek(to: CMTimeMake(Int64(sender.value*1000), 1000))
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "duration", let duration = player.currentItem?.duration.seconds, duration > 0.0 {
            self.durationLbl.text = getTimeString(from: player.currentItem!.duration)
        }
    }
    func getTimeString(from time:CMTime) -> String {
        let totalSeconds = CMTimeGetSeconds(time)
        let hours = Int(totalSeconds/3600)
        let minutes = Int(totalSeconds/60) % 60
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        if hours < 0{
            return String(format: "%i:%02i:%02i", arguments: [hours,minutes,seconds])
        }else{
            return String(format: "%02i:%02i", arguments: [minutes,seconds])
        }
    }
    func addTimeObserver(){
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let mainQueue = DispatchQueue.main
        _ = player.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using: {[weak self]
            time in
            guard let currentItem = self?.player.currentItem else {return}
            self?.timeSlider.maximumValue = Float(currentItem.duration.seconds)
            self?.timeSlider.minimumValue = 0
            self?.timeSlider.value = Float(currentItem.currentTime().seconds)
            self?.currentLbl.text = self?.getTimeString(from: currentItem.currentTime())
        })
    }
}

