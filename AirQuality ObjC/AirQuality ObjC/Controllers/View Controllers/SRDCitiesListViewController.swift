//
//  SRDCitiesListViewController.swift
//  AirQuality ObjC
//
//  Created by Shannon Draeker on 5/6/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class SRDCitiesListViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var citiesTableView: UITableView!
    @IBOutlet weak var citiesSearchBar: UISearchBar!
    
    // MARK: - Properties
    
    var country: String?
    var state: String?
    var cities: [String] = [] { didSet { displayCities = cities } }
    var displayCities: [String] = [] { didSet { citiesTableView.reloadData() } }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        citiesTableView.delegate = self
        citiesTableView.dataSource = self
        citiesSearchBar.delegate = self
        
        // Get the cities data from the api
        guard let country = country, let state = state else { return }
        SRDAirController.fetchSupportedCities(inState: state, country: country) { [weak self] (cities) in
            DispatchQueue.main.async {
                self?.cities = cities
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            guard let indexPath = citiesTableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? SRDCityDetailViewController
                else { return }
            
            destinationVC.country = country
            destinationVC.state = state
            destinationVC.city = displayCities[indexPath.row]
        }
    }
}

extension SRDCitiesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        
        let city = displayCities[indexPath.row]
        cell.textLabel?.text = city
        
        return cell
    }
}

extension SRDCitiesListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           if searchText.isEmpty { displayCities = cities }
           else { displayCities = cities.filter { $0.lowercased().contains(searchText.lowercased()) } }
       }
}
