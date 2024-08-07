import Foundation
import AVFoundation

class AudioPlayer: ObservableObject {
    @Published var songInPlay = ""
    @Published private var player: AVPlayer?
    @Published var isPlaying = false
    
    private var playerObserver: Any?
    
    deinit {
        if let observer = playerObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    func playSong(songToPlay: URL, songName: String){
        player = AVPlayer(playerItem: AVPlayerItem(url: songToPlay))
        songInPlay = songName
        player?.play()
        isPlaying = true
        
        playerObserver = NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player?.currentItem,
            queue: .main
        ) { [weak self] _ in
            self?.actionAtItemEnd()
        }
    }
    
    func pauseSong(songToPlay: URL){
        player?.pause()
        isPlaying = false
    }
    
    func actionAtItemEnd() {
        player?.seek(to: .zero)
        player?.pause()
        isPlaying = false
    }
}
