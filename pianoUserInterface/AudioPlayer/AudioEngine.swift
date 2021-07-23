//
//  AudioEngine.swift
//  pianoUserInterface
//
//  Created by Stefan Hopman on 7/22/21.
//

import AVFoundation


extension AVAudioEngine{
    
    //this functions attemps to start the audio engine
    //it check if it is already running. If it is, then it will do nothing
    //otherwise it attempt to start the audio engine
    func startNote(){
        guard !self.isRunning else {
            return
        }
        do {
           try self.start()
        } catch let error {
            print(error)
        }
    }

}
