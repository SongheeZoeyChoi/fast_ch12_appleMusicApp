//
//  TrackManager.swift
//  AppleMusicStApp
//
//  Created by joonwon lee on 2020/01/12.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit
import AVFoundation

class TrackManager {
    // TODO: 프로퍼티 정의하기 - 트랙들, 앨범들, 오늘의 곡
    var tracks: [AVPlayerItem] = []
    var albums: [Album] = []
    var todaysTrack: AVPlayerItem?
    
    // TODO: 생성자 정의하기
    init() {
        let tracks = loadTracks() // 이니셜라이즈 하면서 트랙 로딩
        self.tracks = tracks // tracks에 업데이트 시키고
        self.albums = loadAlbums(tracks: tracks) //앨범 로딩
        self.todaysTrack = self.tracks.randomElement() // 트랙 중 랜덤으로
    }

    // TODO: 트랙 로드하기
    func loadTracks() -> [AVPlayerItem] {
        // 파일들 읽어서 AVPlayerItem 만들기
        // 각 파일들의 url 가져옴 // 앱 안에있는게 Bundle임
        let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []
        
//        var items: [AVPlayerItem] = []
//        for url in urls {
//            let item = AVPlayerItem(url: url)
//            items.append(item)
//        }
        //--> 고계함수 map 사용
        let items = urls.map { url in
            return AVPlayerItem(url: url)
        }
        
        return items
    }
    
    // TODO: 인덱스에 맞는 트랙 로드하기
    func track(at index: Int) -> Track? {
        let playerItem = tracks[index]
        let track = playerItem.convertToTrack()
        return track
    }

    // TODO: 앨범 로딩메소드 구현
    func loadAlbums(tracks: [AVPlayerItem]) -> [Album] {
        let trackList: [Track] = tracks.compactMap { return $0.convertToTrack() }
        let albumDics = Dictionary(grouping: trackList) { (track) in track.albumName } // 앨범 이름으로 그룹핑한 딕셔너리
        var albums: [Album] = []
        for (key, value) in albumDics {
            let title = key // 앨범이름(key)으로 그루핑한 트랙의 Dictionary
            let tracks = value // 트랙 
            let album = Album(title: title, tracks: tracks)
            albums.append(album)
        }
        return albums
    }

    // TODO: 오늘의 트랙 랜덤으로 선책
    func loadOtherTodaysTrack() {
        return self.todaysTrack = self.tracks.randomElement()
    }
}
