//
//  SRDStatesListViewController.swift
//  AirQuality ObjC
//
//  Created by Shannon Draeker on 5/6/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class SRDStatesListViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var statesTableView: UITableView!
    
    // MARK: - Properties
    
    var country: String?
    var states: [String] = [] { didSet { statesTableView.reloadData() } }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statesTableView.delegate = self
        statesTableView.dataSource = self
        
        // Get the states data from the api
        guard let country = country else { return }
        SRDAirController.fetchSupportedStates(inCountry: country) { [weak self] (states) in
            DispatchQueue.main.async {
                self?.states = states
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCitiesVC" {
            guard let indexPath = statesTableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? SRDCitiesListViewController
                else { return }
            
            destinationVC.country = country
            destinationVC.state = states[indexPath.row]
        }
    }
}

extension SRDStatesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)
        
        let state = states[indexPath.row]
        cell.textLabel?.text = state
        
        return cell
    }
}
