////
////  VideoPlayerView.swift
////  VideoPlayerSwiftUI
////
////  Created by Aziz Ahmed on 2024-04-01.
////
//
//import SwiftUI
//import AVKit
//
//struct VideoPlayerView: View {
//    @State private var selectedVideoIndex: Int = 0
//      @State private var isPlaying: Bool = false
//      @State private var player: AVPlayer? = nil
//    var title : String
//    var description : String
//    var author : String
//    
//    
//    
//    var body: some View {
//        VStack {
//             VideoPlayer(player: isPlaying ? player : nil)
//               .frame(height: 200)
//               .overlay(
//                 HStack {
//                   Button(action: {
//                     // Handle previous button
//                     if selectedVideoIndex > 0 {
//                       selectedVideoIndex -= 1
//                       updatePlayer()
//                     }
//                   }) {
//                     Image(systemName: "backward.fill")
//                       .opacity(selectedVideoIndex == 0 ? 0.5 : 1.0)
//                       .disabled(selectedVideoIndex == 0)
//                   }
//                   Spacer()
//                   Button(action: {
//                     isPlaying.toggle()
//                     if isPlaying {
//                       player?.play()
//                     } else {
//                       player?.pause()
//                     }
//                   }) {
//                     Image(systemName: isPlaying ? "pause.fill" : "play.fill")
//                   }
//                   Spacer()
//                   Button(action: {
//                     // Handle next button
//                     if selectedVideoIndex < videos.count - 1 {
//                       selectedVideoIndex += 1
//                       updatePlayer()
//                     }
//                   }) {
//                     Image(systemName: "forward.fill")
//                       .opacity(selectedVideoIndex == videos.count - 1 ? 0.5 : 1.0)
//                       .disabled(selectedVideoIndex == videos.count - 1)
//                   }
//                 }
//               )
//
//             List {
//               VStack(alignment: .leading) {
//                 Text(title)
//                   .font(.title2)
//                   .bold()
//                 Text(description)
//                   .font(.subheadline)
//                 Spacer()
//                   Text(Author)
//                     .font(.subheadline)
//               
//               }
//             }
//             .listStyle(.plain)
//           }
//         func updatePlayer() {
//            player?.pause()
//            player = AVPlayer(url: URL(string: videos[selectedVideo]))
//        }
//    }
//}
//
//#Preview {
//    VideoPlayerView()
//}
