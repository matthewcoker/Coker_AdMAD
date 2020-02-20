//
//  DetailViewController.swift
//  Lab2-AMAD
//
//  Created by Matthew Coker on 2/20/20.
//  Copyright © 2020 Matthew Coker. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    var albumsData = AlbumsDataController()
    var selectedAlbum = 0
    var songList = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        songList = albumsData.getSongs(idx: selectedAlbum)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return songList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = songList[indexPath.row]

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            songList.remove(at: indexPath.row)
            albumsData.deleteSong(dataIdx: selectedAlbum, songIdx: indexPath.row)
            //update table
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let fromRow = fromIndexPath.row
        let toRow = to.row
        
        let moveSong = songList[fromRow]
        songList.swapAt(fromRow, toRow)
        
        albumsData.deleteSong(dataIdx: selectedAlbum, songIdx: fromRow)
        albumsData.addSong(dataIdx: selectedAlbum, newSong: moveSong, songIdx: toRow)
    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        //check the id of segue
        if segue.identifier == "save" {
            //downcast to access members
            let source = segue.source as! AddSongViewController
            
            //double check to make sure new country name is not empty
            if source.addedSong.isEmpty == false {
                //add new country to data model (notify of changes)
                albumsData.addSong(dataIdx: selectedAlbum, newSong: source.addedSong, songIdx: songList.count)
                //add to working copy
                songList.append(source.addedSong)
                //update table view based on data changes
                tableView.reloadData()
            }
        }
    }

}
