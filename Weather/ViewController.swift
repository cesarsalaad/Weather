//
//  ViewController.swift
//  Weather
//
//  Created by Cesar Tesen on 3/24/20.
//  Copyright © 2020 Cesar Tesen. All rights reserved.
//

import UIKit

var parsedWeather = Weather()

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadWeather()
        Temperature.text = "\(parsedWeather.main.temp)°"
    }
    
    @IBAction func updateWeather(_ sender: Any) {
        loadWeather()
        Temperature.text = "\(parsedWeather.main.temp)°"
    }
    @IBOutlet weak var Temperature: UILabel!
}

let session: URLSession = .shared
private func loadWeather()
{
    let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=33.952763&lon=118.4405604&appid=45e00b3433c2ad9f4a0575e78c775d79")!
    let task = session.dataTask(with: url) { (data, response, error) in
        guard let data = data else { return }
        do {
            parsedWeather = try JSONDecoder().decode(Weather.self, from: data)
            print(parsedWeather.main.temp)
        }
        catch {
            print("JSONParsing Error: \(error)")
        }
    }
    task.resume()
}
