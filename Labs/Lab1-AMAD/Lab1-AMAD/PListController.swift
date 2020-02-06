//
//  PListController.swift
//  Lab1-AMAD
//
//  Created by Matthew Coker on 2/5/20.
//  Copyright © 2020 Matthew Coker. All rights reserved.
//

import Foundation

enum DataError : Error {
case BadFilePath
case CouldNotDecodeData
case NoData
}

class PListController {
    var artistAlbumData: [DependentPList]?
    let filename = "artist-albums"
    func loadData () throws {
        print ( "Loading data...." )
        //get our file based on the file path
        if let pathURL = Bundle.main.url(forResource: filename, withExtension: "plist" ) { //we
            let decoder = PropertyListDecoder ()
            do {
                //get file contents
                let data = try Data (contentsOf: pathURL)
                //decode them using our struct as the type to decode to
                artistAlbumData = try decoder.decode([ DependentPList ].self , from: data)
                print ( "Data loaded" )
            
            } catch {
                throw DataError . CouldNotDecodeData
            }
        }
            //error fetching data file
        else {
            throw DataError . BadFilePath
        }
    }

    //grab all the artist and return them in an array of strings or throw error
    func getAllArtists () throws -> [ String ] {
        var artists = [ String ]()
        //make sure we got data
        if let data = artistAlbumData {
            for artist in data {
                artists.append(artist.name)
            }
            return artists
        }
        else {
            //we don't have data!
            throw DataError . NoData
        }
    }
    //get the albums for any of the artists or throw an error
    func getAlbums (idx: Int) throws -> [ String ] {
        if let data = artistAlbumData {
            return data[idx].albums
        }
        else {
            //we don't have data!
            throw DataError . NoData
        }
    }
}
