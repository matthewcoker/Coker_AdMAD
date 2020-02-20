//
//  ViewController.swift
//  Lab2-AMAD
//
//  Created by Matthew Coker on 2/19/20.
//  Copyright © 2020 Matthew Coker. All rights reserved.
//

import UIKit
class ViewController: UITableViewController {
    var albumsList = [String]()
    var albumsDataController = AlbumsDataController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            try albumsDataController.loadData()
            albumsList = albumsDataController.getAlbums()
        } catch {
            print (error)
        }
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
        cell.textLabel?.text = albumsList[indexPath.row]
        return cell
    }
    
    override func prepare ( for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SongSegue" {
            //get reference to DetailViewController (need to downcast from UIViewController)
            let detailVC = segue.destination as! DetailViewController
            //get the cell that triggered the segue (need to downcast)
            let indexPath = tableView.indexPath( for : sender as! UITableViewCell )
            //set data in destination controller
            if let selection = indexPath?.row {
                detailVC.selectedAlbum = selection
                detailVC.title = albumsList[selection]
                detailVC.albumsData = albumsDataController
            }
        }
    }
    
}
