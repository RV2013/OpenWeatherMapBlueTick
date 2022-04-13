//
//  WeatherDetailsViewController.swift
//  weatherdemo
//
//  Created by Rachit Vyas on 11/04/22.
//  Copyright © 2022 rachitvyas. All rights reserved.
//

import UIKit

struct PresentatbleWeatherItem{
  let caption: String
  let value: String?
  let childs: [PresentatbleWeatherItem]?
}

final class WeatherDetailsViewController: UIViewController {
  @IBOutlet weak var collectionViewWeatherDetails: UICollectionView!
  
  @IBOutlet weak var lblOverview: UILabel!
  
  private let cellSpacing: CGFloat = 5
  private let columns: CGFloat = 2
  
  private var cellSize: CGFloat?
  
  private var hourlyWeatherData: HourlyWeatherResponseItem?
  private var networkError: Error?
  
  private var presentableItems: [PresentatbleWeatherItem] = []
  private var weatherDetailsData: WeatherForecatsDetailPresentationModel!
  private var overViewDataItem: WeatherForeCastListItem!
  
  let cellIdentifier: String = WeatherDetailsCell2.reusableIdentifier
  
  internal static func instantiate(with weatherDetailsdata: WeatherForecatsDetailPresentationModel, summaryInfo:  WeatherForeCastListItem) -> WeatherDetailsViewController? {
    
    guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherDetailsViewController") as?  WeatherDetailsViewController else { return nil}
    vc.weatherDetailsData = weatherDetailsdata
    vc.overViewDataItem = summaryInfo
    
    return vc
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionViewWeatherDetails.delegate = self
    collectionViewWeatherDetails.dataSource = self
    collectionViewWeatherDetails.isHidden =  true
    
    if overViewDataItem != nil {
      lblOverview.text = overViewDataItem!.dayOfObservation  + " - " + overViewDataItem!.hourOfObservationDay
      self.title = overViewDataItem!.cityName
    }
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.weatherDetailsData.prepareDetails()
    if let items: [PresentatbleWeatherItem] =  self.weatherDetailsData?.detailsData["main"] {
      self.presentableItems = items
      self.collectionViewWeatherDetails.isHidden =  false
      self.collectionViewWeatherDetails.reloadData()
    }
  }
  
}


// MARK: - Data source
extension WeatherDetailsViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.presentableItems.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell: WeatherDetailsCell2 = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherDetailsCell2.reusableIdentifier, for: indexPath) as? WeatherDetailsCell2 else {
      return UICollectionViewCell()
    }
    let item = self.presentableItems[indexPath.item]
    cell.lblCaption.text = item.caption.uppercased()
    cell.lblValue.text =  item.value?.uppercased() ?? "" //"36\u{00B0}C"
    return cell
  }
}



// MARK: - UICollectionViewDelegateFlowLayout
extension WeatherDetailsViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (collectionView.frame.size.width - 10) / 2, height: 80)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return cellSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return cellSpacing
  }
  
  
  
}


