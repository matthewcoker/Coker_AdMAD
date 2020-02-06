//
//  FirstViewController.swift
//  Lab1-AMAD
//
//  Created by Matthew Coker on 2/5/20.
//  Copyright © 2020 Matthew Coker. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDataSource,
UIPickerViewDelegate {
    
    let artistComponent = 0
    let albumComponent = 1
    var artistAlbums = PListController ()
    var artists = [ String ]()
    var albums = [ String ]()
    
    @IBOutlet weak var PListPicker: UIPickerView!
    @IBOutlet weak var choiceLabel: UILabel!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == artistComponent {
            return artists.count
        } else if component == albumComponent {
            return albums.count
        } else {
            print ( "Unknown component" )
            return -1
        }
    }
    
    func pickerView (_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == artistComponent {
            return artists[row]
        } else if component == albumComponent {
            return albums[row]
        } else {
            print ( "Unkown component" )
            return "Unknown component"
        }
    }
    
    func pickerView (_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //need to update albums if user selects a new artists
        if component == artistComponent {
            //get the new list of albums
            do {
                albums = try artistAlbums.getAlbums(idx: row)
            }
            catch {
                print (error)
            }
            //update the album component
            PListPicker.reloadComponent(albumComponent)
            PListPicker.selectRow( 0 , inComponent: albumComponent, animated: true )
        }
        let artist = pickerView.selectedRow(inComponent: artistComponent)
        let album = pickerView.selectedRow(inComponent: albumComponent)
        choiceLabel.text = "You like \(albums[album]) by \(artists[artist]) "
    }
    

    override func viewDidLoad() {
        super .viewDidLoad()
        //load the data using our data class
        do {
            try artistAlbums.loadData()
            artists = try artistAlbums.getAllArtists()
            //use first index on load since that is what the artist component will be set to
            albums = try artistAlbums.getAlbums(idx: 0 )
        } catch {
            print (error)
        }
    }
}
