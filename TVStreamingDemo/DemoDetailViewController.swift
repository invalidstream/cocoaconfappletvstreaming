//
//  DemoDetailViewController.swift
//  TVStreamingDemo
//
//  Created by Chris Adamson on 9/8/16.
//  Copyright © 2016 Subsequently & Furthermore, Inc. All rights reserved.
//

import UIKit
import AVKit

class DemoDetailViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var playButton: UIButton!
    
    var playerVC : AVPlayerViewController?
    
    var demoItem : DemoItem? {
        didSet {
            titleLabel.text = demoItem?.title
            descriptionLabel.text = demoItem?.description
        }
    }

    override var preferredFocusedView: UIView {
        return playButton
    }
    
    @IBAction func handlePlayButtonTapped(_ sender: AnyObject) {
        guard let demoItem = demoItem else { return }

        self.playerVC?.player?.pause()
        
        let playerVC = AVPlayerViewController()
        playerVC.showsPlaybackControls = true
        let player = AVPlayer(url: demoItem.url)
        playerVC.player = player
        present(playerVC, animated: true)
        player.play()
        
        self.playerVC = playerVC
    }
}
