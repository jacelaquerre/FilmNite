//
//  CommonMovieTableView.swift
//  FilmNite
//
//  Created by Sarah O'Brien on 12/1/20.
//

import Foundation
import UIKit

class CommonMovieTableView: UITableViewController{
    
    var allMovies = MovieList()
    
    @IBOutlet weak var sessionIDLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        sessionIDLabel.text = globalSessionID
        print("SessionID:" + globalSessionID)
        getSessionMovies(sessionID: globalSessionID)
        self.allMovies = sessionMovieList
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMovies.movieList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if we want to add detail view for movies, its handled here
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "commonMovieCell", for: indexPath)
        cell.textLabel?.text = allMovies.movieList[indexPath.row].title
        return cell
    }
}