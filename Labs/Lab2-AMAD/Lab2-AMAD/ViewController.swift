//
//  ViewController.swift
//  Lab2-AMAD
//
//  Created by Matthew Coker on 2/19/20.
//  Copyright © 2020 Matthew Coker. All rights reserved.
//

import UIKit
class ViewController: UITableViewController, UISearchBarDelegate {
    
    var searchController = UISearchController()
    var albumsList = [String]()
    var albumsDataController = AlbumsDataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            try albumsDataController.loadData()
            albumsList = albumsDataController.getAlbums()
            let resultsController = SearchResultsController()
            resultsController.allWords = albumsList
            //tell the search controller to use our
            searchController = UISearchController (searchResultsController: resultsController)
            //add some placeholder text
            searchController.searchBar.placeholder = "Filter"
            searchController.searchBar.sizeToFit() //make it fit the parent view
            //add a header that consists of the search bar that belongs to our search controller
            tableView.tableHeaderView = searchController.searchBar
            //tell it which object will be updating the results
            searchController.searchResultsUpdater = resultsController
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
