//
//  SRDCityDetailViewController.swift
//  AirQuality ObjC
//
//  Created by Shannon Draeker on 5/6/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class SRDCityDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateCountryLabel: UILabel!
    @IBOutlet weak var airQualityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    // MARK: - Properties
    
    var country: String?
    var state: String?
    var city: String?
    var cityAirQuality: SRDCityAirQuality? { didSet { updateViews() } }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get the city air quality data from the api
        guard let country = country, let state = state, let city = city else { return }
        SRDAirController.fetchData(forCity: city, state: state, country: country) { [weak self] (cityAirQuality) in
            DispatchQueue.main.async {
                self?.cityAirQuality = cityAirQuality
            }
        }
    }
    
    func updateViews() {
        guard let country = country, let state = state, let city = city, let cityAirQuality = cityAirQuality else { return }
        
        cityLabel.text = city
        stateCountryLabel.text = "\(state), \(country)"
        airQualityLabel.text = "Air Quality: \(cityAirQuality.pollution.airQuality) AQI"
        temperatureLabel.text = "Temperature: \(cityAirQuality.weather.temperature)ºC"
        humidityLabel.text = "Humidity: \(cityAirQuality.weather.humidity)%"
        windSpeedLabel.text = "Wind Speed: \(cityAirQuality.weather.windSpeed) (m/s)"
    }
}
