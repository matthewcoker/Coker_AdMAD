//
//  Albums.swift
//  Lab2-AMAD
//
//  Created by Matthew Coker on 2/19/20.
//  Copyright © 2020 Matthew Coker. All rights reserved.
//

import Foundation
import UIKit

struct AlbumbsDataModel: Codable {
    var album: String
    var songs: [String]
}

enum DataError: Error {
    case NoDataFile
    case CouldNotDecode
    case CouldNotEncode
}

class AlbumsDataController{
    var allData = [AlbumbsDataModel]()
    let fileName = "Albums"
    let dataFileName = "data.plist"
    
    init() {
        //get our app instance
        let app = UIApplication.shared
        //subscribe to willResignActive notification
        NotificationCenter.default.addObserver(self, selector: #selector(AlbumsDataController.writeData(_:)), name: UIApplication.willResignActiveNotification, object: app)
    }
    func loadData() throws {
        //check for file and get URL if possible
        if let dataURL = Bundle.main.url(forResource: fileName, withExtension: "plist" ) {
            let decoder = PropertyListDecoder()
            do {
                //get byte buffer (raw data)
                let data = try Data (contentsOf: dataURL)
                //decode to our model
                allData = try decoder.decode([AlbumbsDataModel].self, from: data)
                
            }
            catch {
                throw DataError.CouldNotDecode
            }
        }
        else {
            //couldn't get path
            throw DataError.NoDataFile
        }
    }
    
    func getDataFile(datafile: String) -> URL {
        //get path for data file
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = dirPath[0] //documents directory
        
        // URL for our plist
        return docDir.appendingPathComponent(datafile)
    }

    
    @objc func writeData(_ notification: NSNotification) throws {
        print("Writing data to \(dataFileName)")
        let dataFileURL = getDataFile(datafile: dataFileName)
        //get an encoder
        let encoder = PropertyListEncoder()
        //set format — plist is a type of xml
        encoder.outputFormat = .xml
        do {
            let data = try encoder.encode(allData.self)
            try data.write(to: dataFileURL)
        } catch {
            print(error)
            throw DataError.CouldNotEncode
        }
        
    }
    
    //fetch all the albums
    func getAlbums() -> [String] {
        //init empty array
        var allAlbumbs = [String]()
        //loop through data and append to array
        for item in allData {
            allAlbumbs.append(item.album)
        }
        return allAlbumbs
    }
    
    //get array of songs based on album
    func getSongs(idx: Int) -> [String] {
        return allData[idx].songs
    }
    
    //add a song
    func addSong(dataIdx: Int, newSong: String, songIdx: Int) {
        allData[dataIdx].songs.insert(newSong, at: songIdx)
    }
    
    //delete a song
    func deleteSong(dataIdx: Int, songIdx: Int) {
        allData[dataIdx].songs.remove(at: songIdx)
    }
    
}
