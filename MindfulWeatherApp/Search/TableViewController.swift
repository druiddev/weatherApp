//
//  TableViewController.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/13/22.
//

import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate {
   
    var searchController = UISearchController(searchResultsController: nil)
    var zipsArray = [Zip]()
    var filteredArray = [Zip]()
    var API = "405db7bf13ea449a2506f66752e029b5"
    var zip = 11111

    override func viewDidLoad() {
        super.viewDidLoad()


        
        searchController.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        
        
        filteredArray = zipsArray

    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell_ID_3", for: indexPath) as? TableViewCell else {return tableView.dequeueReusableCell(withIdentifier: "cell_ID_3", for: indexPath)}
        
        cell.locationLabel.text = filteredArray[indexPath.row].name
        cell.zipLabel.text = filteredArray[indexPath.row].zip
        return cell
    }
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        ZipGeocoding(atURL: "http://api.openweathermap.org/geo/1.0/zip?zip=\(searchText)&appid=\(API)")
        filteredArray = zipsArray

        if searchText != "" {
            
            //grabs whats typed and filters it to show data
            filteredArray = filteredArray.filter({ $0.zip.lowercased().range(of: searchText!.lowercased()) != nil
            })
            
            
        }
        
        //reloads table so it shows
        tableView.reloadData()
    }
    
    
    //uses above function to update table
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        updateSearchResults(for: searchController)
    }
    
    
 
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
       
        

    }
 
    
    
    
    
    

}
