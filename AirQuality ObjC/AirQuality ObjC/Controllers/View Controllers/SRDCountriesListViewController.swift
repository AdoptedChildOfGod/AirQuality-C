//
//  SRDCountriesListViewController.swift
//  AirQuality ObjC
//
//  Created by Shannon Draeker on 5/6/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class SRDCountriesListViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var countriesTableView: UITableView!
    @IBOutlet weak var countriesSearchBar: UISearchBar!
    
    // MARK: - Properties
    
    var countries: [String] = [] { didSet { displayCountries = countries } }
    var displayCountries: [String] = [] { didSet { countriesTableView.reloadData() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
        countriesSearchBar.delegate = self
        
        // Get the countries data from the api
        SRDAirController.fetchSupportedCountries { [weak self] (countries) in
            DispatchQueue.main.async {
                self?.countries = countries
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStatesVC" {
            guard let indexPath = countriesTableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? SRDStatesListViewController
                else { return }
            
            destinationVC.country = displayCountries[indexPath.row]
        }
    }
}

extension SRDCountriesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        
        let country = displayCountries[indexPath.row]
        cell.textLabel?.text = country
        
        return cell
    }
}

extension SRDCountriesListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty { displayCountries = countries }
        else { displayCountries = countries.filter { $0.lowercased().contains(searchText.lowercased()) } }
    }
}
