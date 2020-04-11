//
//  ViewController.swift
//  firestoredemo
//
//  Created by App Dev on 2020-04-07.
//  Copyright © 2020 App Dev. All rights reserved.
//

import UIKit
import Firebase
import AVKit

class ViewController: UIViewController {

    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var logInButton: UIButton!
    
    func setupElements(){
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleFilledButton(logInButton)
    }

    func loadBackgroundVideo() {
        //find the URL of the video in the bundle
        let bundlePath = Bundle.main.path(forResource: "loginbg", ofType: "mp4")
        if bundlePath == nil {
            return
        }
        let videoURL = URL(fileURLWithPath: bundlePath!)
        //create a videoplayer item
        let videoItem = AVPlayerItem(url: videoURL)
        //create a videoplayer
        let videoPlayer = AVPlayer(playerItem: videoItem)
        //create a videoplayer layer
        let videoLayer = AVPlayerLayer(player: videoPlayer)
        //Add that videoplayer layer to the view
        view.layer.insertSublayer(videoLayer, at: 0)
        //Frame the Video
        videoLayer.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        //Play the Video
        videoPlayer.playImmediately(atRate: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadBackgroundVideo()
    }
    
    override func viewDidLoad() {
        setupElements()
        super.viewDidLoad()
        //let db = Firestore.firestore()
        // Do any additional setup after loading the view.
        //db.collection("wine").addDocument(data: ["firstName": "James", "lastName":"Johnson", "age":38])
    }


}


