//
//  MP3Player.swift
//  PitchPerfect
//
//  Created by Swift on 07/02/2017.
//  Copyright © 2017 Swift. All rights reserved.
//

import Foundation
import AVFoundation

class MP3Player: NSObject, AVAudioPlayerDelegate
{
    var player: AVAudioPlayer?
    var currentTrackIndex = 0
    var tracks = [String]()
    
}
