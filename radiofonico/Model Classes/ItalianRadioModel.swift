//
//  ItalianRadioModel.swift
//  radiofonico
//
//  Created by Layne Johnson on 5/14/21.
//

import Foundation
import UIKit
import AVFoundation

var audioPlayer: AVAudioPlayer?

class ItalianRadioModel {
    
    let italianRadioSongs = ["Lucio Dalla-Washington.mp3", "Mango-Bella d'Estate.mp3", "Franco Battiato-Summer On A Solitary Beach.mp3" ]
    
    var myFavorites = [String]()
    
    let defaultSongLabel = ""
    let defaultArtistLabel = ""
    
    var song = ""
    var isPlaying = false
    
    func setSongLabel(song: String, songLabel: UILabel, artistLabel: UILabel) {
        
        if song.contains("-") {
            
            let delimiter = "-"
            
            // Song filename format: Lucio Dalla-Washington.mp3
            let songInfo = song.components(separatedBy: delimiter)
            print(songInfo)
            
            let song = songInfo[1]
            print(song)
            
            let artist = songInfo[0]
            print(artist)
            
            // Remove .mp3 from song string
            let modifiedSong = song.replacingOccurrences(of: ".mp3", with: "", options: [.caseInsensitive, .regularExpression])
            print(modifiedSong)
            
            // Set UILabel text
            songLabel.text = modifiedSong
            artistLabel.text = artist
        }
    }
    
    func chooseSong() -> String {
        
        song = italianRadioSongs.randomElement()!
        return song
    }
    
    func playSound(_ soundName: String) {
        
        let path = Bundle.main.path(forResource: soundName, ofType:nil)!
        
        let url = URL(fileURLWithPath: path)
        
        do {
            // Create the audio player
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            // Play the sound effect
            audioPlayer?.play()
        } catch {
            print("Could not summon audio player")
        }
    }
    
    func playPreviousSong() -> String {
        
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
                playSound(song)
                
                return song
                
            } else {
                
                // Play previous song
                let previousSong = italianRadioSongs[previousSongIndex]
                print("previous song: \(previousSong)")
                song = previousSong
                print("New Current Song: \(song)")
                playSound(song)
                
                return song
            }
            
        } else {
            
            return defaultSongLabel
        }
    }
    
    func radioOnOff(sender: UIButton) -> String {
        
        // Toggle radio state
        sender.isSelected.toggle()
        
        if sender.isSelected == true {
            isPlaying = true
            song = italianRadioSongs[0]
            playSound(song)
            
            return song
            
        } else if sender.isSelected == false {
            isPlaying = false
            audioPlayer?.pause()
        }
        return defaultSongLabel
    }
    
    func playNextSong() -> String {
        
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
                playSound(song)
                return song
                
            } else {
                // Play next song
                let nextSong = italianRadioSongs[nextSongIndex]
                print("Next song: \(nextSong)")
                song = nextSong
                print("New Current Song: \(song)")
                playSound(song)
                
                return song
            }
        } else {
            // Add animation to "Press play to vibe"
            return defaultSongLabel
        }
    }
    
    func addFavorite(song: String) {
        
        // Filter array for song index
        let indexArray = italianRadioSongs.indices.filter { italianRadioSongs[$0].localizedCaseInsensitiveContains("\(song)") }
        
        // Retrieve index from filtered array
        let index = indexArray[0]
        
        // Find favorite song
        let favorite = italianRadioSongs[index]
        
        // Add song to favorites
        myFavorites.append(favorite)
    }
    
    func removeFavorite(song: String) {
        
        // Filter array for song index
        let indexArray = myFavorites.indices.filter { myFavorites[$0].localizedCaseInsensitiveContains("\(song)") }
        
        // Retrieve index from filtered array
        let index = indexArray[0]
        
        // Remove song from favorites
        myFavorites.remove(at: index)
    }
    
    func checkFavorite(song: String) -> Bool {
        
        myFavorites.contains(song)
    }
    
} // END ItalianRadioModel class
