//
//  AudioPlayer.swift
//  pianoUserInterface
//
//  Created by Stefan Hopman on 6/30/21.
//

import AVFoundation

var player: AVAudioPlayer?

func playSound() {
    guard let url = Bundle.main.url(forResource: "microsoft", withExtension: "mp3") else { return }
    do {
           try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
           try AVAudioSession.sharedInstance().setActive(true)

           /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
           player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

           guard let player = player else { return }

           player.play()

       } catch let error {
           print(error.localizedDescription)
       }
    }
    func stopSound() {
        player?.stop()
}
