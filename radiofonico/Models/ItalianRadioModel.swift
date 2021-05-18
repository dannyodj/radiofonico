//
//  ItalianRadioModel.swift
//  radiofonico
//
//  Created by Layne Johnson on 5/14/21.
//

import Foundation
import UIKit

class ItalianRadioModel {
    
    let audioPlayer = AudioPlayer()
    
    let italianRadioSongs = ["Lucio Dalla - Washington.mp3", "Mango - Bella d'Estate.mp3", "Franco Battiato - Summer On A Solitary Beach.mp3" ]
    
    let defaultSongLabel = "Press play to vibe"
    
    var song = ""
    
    var isPlaying = false
    
    func chooseSong() -> String {
        song = italianRadioSongs.randomElement()!
        return song
    }
    
//    func setSongLabel(song: String) {
//        // Modify song name string for display
//        let modifiedSong = song.replacingOccurrences(of: ".mp3", with: "", options: [.caseInsensitive, .regularExpression])
//        // Set song label
//        songLabel.text = modifiedSong
//    }
    
    @IBAction func playPreviousSong(_ sender: UIButton) {
        
        if isPlaying == true {
            
            // Get index of current song
            print("Current song: \(song)")
            let songIndex = italianRadioSongs.firstIndex(of: "\(song)")
            print("Song index: \(songIndex!)")
            
            // Get index of previous song
            var previousSongIndex = songIndex! - 1
            print("previous song index: \(previousSongIndex)")
            
            // Reset index at end of array
            if previousSongIndex > italianRadioSongs.count - 1 || previousSongIndex < 0 {
                
                previousSongIndex = italianRadioSongs.endIndex - 1
                let previousSong = italianRadioSongs[previousSongIndex]
                song = previousSong
                audioPlayer.playSound(song)
//                setSongLabel(song: song)
            } else {
                
                // Play previous song
                let previousSong = italianRadioSongs[previousSongIndex]
                print("previous song: \(previousSong)")
                song = previousSong
                print("New Current Song: \(song)")
                audioPlayer.playSound(song)
                
                // Set song label for next song
                // TODO: Refactor; add setSongLabel label function to playSound function
//                setSongLabel(song: previousSong)
            }
        } else {
            
            // Add animation to "Press play to vibe"
            print(defaultSongLabel)
        }
    }

    
    @IBAction func radioOnOff(_ sender: UIButton) {
        
        // Toggle radio state
        sender.isSelected.toggle()
        
        if sender.isSelected == true {
            isPlaying = true
            song = italianRadioSongs[0]
//            setSongLabel(song: song)
            audioPlayer.playSound(song)
        } else if sender.isSelected == false {
            isPlaying = false
            audioPlayer.audioPlayer?.pause()
//            setSongLabel(song: defaultSongLabel)
        }
    }
    
    @IBAction func playNextSong(_ sender: UIButton) {
        
        if isPlaying == true {
            // Get index of current song
            print("Current song: \(song)")
            let songIndex = italianRadioSongs.firstIndex(of: "\(song)")
            print("Song index: \(songIndex!)")
            
            // Get index of next song
            var nextSongIndex = songIndex! + 1
            print("Next song index: \(nextSongIndex)")
            
            // Reset index at end of array
            if nextSongIndex > italianRadioSongs.count - 1 {
                nextSongIndex = 0
                let nextSong = italianRadioSongs[nextSongIndex]
                song = nextSong
                audioPlayer.playSound(song)
//                setSongLabel(song: song)
            } else {
                // Play next song
                let nextSong = italianRadioSongs[nextSongIndex]
                print("Next song: \(nextSong)")
                song = nextSong
                print("New Current Song: \(song)")
                audioPlayer.playSound(song)
                
                // Set song label for next song
                // TODO: Refactor; add setSongLabel label function to playSound function
//                setSongLabel(song: nextSong)
            }
        } else {
            // Add animation to "Press play to vibe"
            print(defaultSongLabel)
        }
    }
    
}
