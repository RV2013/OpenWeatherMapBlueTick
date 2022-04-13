//
//  ViewController.swift
//  weatherdemo
//
//  Created by Rachit Vyas on 11/04/22.
//  Copyright © 2022 rachitvyas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    DataManager().searchReopsitory(searchString: "london") { (hourlyWeather:HourlyWeatherResponseItem?, error: Error?) in
      debugPrint(hourlyWeather)
      debugPrint(error)
    }
  }


}

