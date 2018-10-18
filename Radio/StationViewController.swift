//
//  StationViewController.swift
//  Radio
//
//  Created by Georgy Dyagilev on 18/10/2018.
//  Copyright © 2018 Georgy Dyagilev. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class StationViewController: UIViewController {
    
    var streamURL: String = ""
    
    var player: AVPlayer?
    var playItem: AVPlayerItem?
    var playButton: UIButton?
       
    override func viewDidLoad() {
        super.viewDidLoad()
        print(streamURL)
        streamAudioFrom(streamURL)
    }
    
    func streamAudioFrom(_ stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
        
        let playerItem: AVPlayerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        let playerLayer = AVPlayerLayer(player: player!)
        playerLayer.frame = CGRect(x: 0, y: 0, width: 10, height: 50)
        self.view.layer.addSublayer(playerLayer)
        
        playButton = UIButton(type: UIButton.ButtonType.system) as UIButton
        let xPostion: CGFloat = view.center.x - 75
        let yPostion: CGFloat = view.center.y - 75
        let buttonWidth: CGFloat = 150
        let buttonHeight: CGFloat = 150
        
        playButton!.frame = CGRect(x: xPostion, y: yPostion, width: buttonWidth, height: buttonHeight)
        playButton!.setImage(UIImage(named: "play"), for: UIControl.State.normal)
        playButton!.tintColor = UIColor.black
        playButton!.addTarget(self, action: #selector(StationViewController.playButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(playButton!)
    }
    
    @objc func playButtonTapped(_ sender: UIButton) {
        if player?.rate == 0 {
            player?.play()
            playButton!.setImage(UIImage(named: "pause"), for: UIControl.State.normal)
        } else {
            player?.pause()
            playButton!.setImage(UIImage(named: "play"), for: UIControl.State.normal)
        }
    }
}
