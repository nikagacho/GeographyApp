//
//  AudioPlayerProtocol.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 22.03.24.
//

import Foundation
import AVFoundation
//MARK: - Base Protocol
protocol AudioPlayerProtocol: AnyObject {
    var isSoundOn: Bool { get set }
    var audioPlayer: AVAudioPlayer? { get set }
    func playSound(soundFileName: String)
}
//MARK: - Extension
extension AudioPlayerProtocol where Self: ObservableObject {
    func playSound(soundFileName: String) {
        if isSoundOn {
            guard let url = Bundle.main.url(forResource: soundFileName, withExtension: "mp3") else { return }
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Unable to locate audio file: \(soundFileName)")
            }
        }
    }
}
