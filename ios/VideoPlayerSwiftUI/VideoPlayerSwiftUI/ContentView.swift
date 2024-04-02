//
//  ContentView.swift
//  VideoPlayerSwiftUI
//
//  Created by Michael Gauthier on 2021-01-06.
//

import SwiftUI
import AVKit
import MarkdownKit

struct ContentView: View {
    @State var videomodel = [VideoModel]()
    @State private var selectedVideoIndex: Int = 0
    @State private var isPlaying: Bool = false
    @State private var player: AVPlayer? = nil
    
    var body: some View {
        VStack  {
            Text("Video Player")
                .font(.title2)
            if videomodel.count > 0 {
                VideoPlayer(player: isPlaying ? player : nil)
                    .frame(height: 200)
                    .overlay(
                        HStack {
                            Spacer()
                            Button{
                                previous()
                            }label: {
                                ZStack {
                                    Circle()
                                        .frame(width: 60 , height: 60)
                                        .foregroundColor(.white)
                                    Image("previous")
                                        .renderingMode(.template)
                                        .foregroundColor(.black)
                                        .opacity(selectedVideoIndex == 0 ? 0.5 : 1.0)
                                }
                                .overlay(Circle()
                                    .stroke(Color.black,lineWidth: 2))
                            }
                            .disabled(selectedVideoIndex == 0)
                            
                            Spacer()
                            Button {
                                play()
                            } label : {
                                ZStack {
                                    Circle()
                                        .frame(width: 90 , height: 90)
                                        .foregroundColor(.white)
                                        .overlay(Circle()
                                            .stroke(Color.black,lineWidth: 2))
                                    
                                    Image(isPlaying ? "pause" : "play")
                                        .renderingMode(.template)
                                        .foregroundColor(.black)
                                }
                            }
                            Spacer()
                            Button {
                                Next()
                            } label: {
                                ZStack {
                                    Circle()
                                        .frame(width: 60 , height: 60)
                                        .foregroundColor(.white)
                                        .overlay(Circle()
                                            .stroke(Color.black,lineWidth: 2))
                                    
                                    Image("next")
                                        .renderingMode(.template)
                                        .foregroundColor(.black)
                                        .opacity(selectedVideoIndex == videomodel.count - 1 ? 0.5 : 1.0)
                                }
                                .overlay(Circle()
                                    .stroke(Color.black,lineWidth: 2))
                            }
                            .disabled(selectedVideoIndex == videomodel.count - 1)
                            Spacer()
                        }
                    )
                
                ScrollView() {
                    VStack(alignment: .leading) {
                        Text(.init(videomodel[selectedVideoIndex].title))
                            .font(.title2)
                        
                        Text(.init(videomodel[selectedVideoIndex].author.name))
                            .font(.subheadline)
                            .padding(.bottom)
                        
                        Text(.init(videomodel[selectedVideoIndex].description))
                            .font(.title2)
                    }
                    .padding([.horizontal,.vertical])
                }
            }
        }
        .onAppear() {
            Task {
                do {
                    try await FetchData()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func play() {
        isPlaying.toggle()
        if isPlaying {
            player?.play()
        } else {
            player?.pause()
        }
    }
    
    func previous() {
        if isPlaying {
            player?.pause()
            isPlaying.toggle()
        }
        
        if selectedVideoIndex > 0 {
            selectedVideoIndex -= 1
            LoadPlayer()
        }
    }
    
    func Next() {
        if isPlaying {
            player?.pause()
            isPlaying.toggle()
        }
        if selectedVideoIndex < videomodel.count - 1 {
            selectedVideoIndex += 1
        }
        LoadPlayer()
    }
    
    func LoadPlayer() {
        player = AVPlayer(url: URL(string: videomodel[selectedVideoIndex].hlsURL)!)
    }
    
    func FetchData() async throws {
        
        guard let url = URL(string: "http://localhost:4000/videos") else {
            print("Invalid url...")
            return }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { return }
        
        let jsonbody = try JSONDecoder().decode([VideoModel].self, from: data)
        let sortedVideos = jsonbody.sorted(by: { $0.publishedAt < $1.publishedAt }) // Date sort
        
        DispatchQueue.main.async {
            self.videomodel = sortedVideos
        }
        LoadPlayer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
