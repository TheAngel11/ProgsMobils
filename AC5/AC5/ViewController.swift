//
//  ViewController.swift
//  AC5
//
//  Created by Pol Valero on 3/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    struct Weather {
        var date: String?
        var meteo: String?
        var meteoDescription: String?
        var temp: String?
        var minTemp: String?
        var maxTemp: String?
    }
    
    var weather: Weather = Weather()
    
    var weatherForecast: [Weather] = []

    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var meteoLabel: UILabel!
    
    @IBOutlet weak var maxMinTempLabel: UILabel!
    
    func changeWeatherLabels() {
        cityLabel.text = "Barcelona"
        tempLabel.text = weather.temp! + "ºC"
        meteoLabel.text = weather.meteo! + " - " + weather.meteoDescription!
        maxMinTempLabel.text = "Max. " + weather.maxTemp! + "ºC  " + "Min. " + weather.minTemp! + "ºC "
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        APIManager.shared.requestWeatherForCity("Barcelona", "es") {
            (response) in DispatchQueue.main.async {
                self.weather.meteo = response.main
                self.weather.meteoDescription = response.description
                self.weather.temp = response.temp
                self.weather.minTemp = response.tempMin
                self.weather.maxTemp = response.tempMax
                
                self.changeWeatherLabels()
            }
        }
        

       

        APIManager.shared.requestForecastForCity("Barcelona", "es") { (response) in
            
            for item in response.list {
                print("----------------")
                
                self.weatherForecast.append(Weather(date: item.date, meteo: item.main, meteoDescription: item.description, temp: item.temp))
                
                print(self.weatherForecast.last)
            }
        }

        // print the structure saved

    }


}

