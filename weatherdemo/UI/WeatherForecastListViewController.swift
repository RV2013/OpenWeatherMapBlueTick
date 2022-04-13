//
//  WeatherForecastListViewController.swift
//  weatherdemo
//
//  Created by Rachit Vyas on 12/04/22.
//  Copyright © 2022 rachitvyas. All rights reserved.
//

import UIKit

protocol WeatherForecastListVCDelegateProtocol: AnyObject
{
  func weatherDataReceived(with data: [WeatherForeCastListItem]?, error: Error?)
}

struct WeatherForeCastListItem {
  let dayOfObservation: String // today | Wed, Thu etc....
  let minTemperature: String
  let maxTemperature: String
  let isCurrentHour: Bool
  let weatherTypeImage: UIImage?
  let hourOfObservationDay: String //3 PM, 12 AM
  let cityName: String
}

class WeatherForecastListViewController: UIViewController {
  
  @IBOutlet weak var searchBarCity: UISearchBar!
  @IBOutlet weak var tableViewList: UITableView!
  
  @IBOutlet weak var loadingView: UIView!
  @IBOutlet weak var loadingViewVStack: UIStackView!
  @IBOutlet weak var loadingViewVStackHStack: UIStackView!
  @IBOutlet weak var loadingViewVStackButton: UIButton!
  @IBOutlet weak var loadingViewVStackHStackActivityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var loadingViewVStackHStackFailureImageView: UIImageView!
  @IBOutlet weak var loadingViewVStackHStackSuccessImageView: UIImageView!
  @IBOutlet weak var loadingViewVStackHStackLabelMessage: UILabel!
  
  
  
  private lazy var viewModel: WeatherForecastListViewModel = {
    return WeatherForecastListViewModel()
  }()
  
  private var forecastListItems: [WeatherForeCastListItem] = []
  

    override func viewDidLoad() {
      super.viewDidLoad()
      
      searchBarCity.delegate =  self
      searchBarCity.text = ""
      tableViewList.delegate =  self
      tableViewList.dataSource =  self
      tableViewList.separatorStyle = .none
      
      viewModel.weatherForecastListVCDelegate = self
      
      loadingView.layer.borderColor = UIColor.systemBlue.cgColor
      loadingView.layer.borderWidth = 2.0
      loadingView.layer.cornerRadius = 5.0
      
      loadingViewVStackButton.layer.borderColor = UIColor.systemBlue.cgColor
      loadingViewVStackButton.backgroundColor = .systemBlue
      loadingViewVStackButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
      loadingViewVStackButton.layer.borderWidth = 1.0
      loadingViewVStackButton.layer.cornerRadius = 3.0
      
      self.hideNetworkActivity(on: nil, errorMessage: nil)

        // Do any additional setup after loading the view.
    }
  
  private func configCell(_ cell: WeatherForecastListCell, with configurationData: WeatherForeCastListItem) -> WeatherForecastListCell {
    cell.lblToday.text =  configurationData.dayOfObservation
    cell.lblTime.text =  configurationData.hourOfObservationDay
    cell.lblMinTemperature.text =  configurationData.minTemperature
    cell.lblMaxTemperature.text = configurationData.maxTemperature
    cell.viewCurrentHour.backgroundColor = .clear
    return cell
  }
  
  private func fetchWeatherDataFor(_ city: String) {
    showNetworkActivity(cancelAfter: TimeInterval() )
    viewModel.fetchWeatherData(for: city)
  }
  
  private func showNetworkActivity(cancelAfter: TimeInterval) {
    
    tableViewList.isHidden =  true
    
    loadingView.isHidden =  false
    view.bringSubviewToFront(loadingView)
    
    loadingViewVStackHStackActivityIndicator.startAnimating()
    loadingViewVStackHStackActivityIndicator.isHidden =  false
    loadingViewVStackHStackFailureImageView.isHidden =  true
    loadingViewVStackHStackSuccessImageView.isHidden = true
    loadingViewVStackHStackLabelMessage.text = "Loading..."
    loadingViewVStackHStackLabelMessage.textColor = .systemBlue
    
    loadingViewVStackButton.isHidden =  true
    loadingViewVStackButton.isUserInteractionEnabled =  false
    
  }
  
  private func hideNetworkActivity(on success: Bool?, errorMessage: String?) {
    
    loadingViewVStackHStackActivityIndicator.stopAnimating()
    loadingViewVStackHStackActivityIndicator.isHidden =  true
    
    if success == nil {
      tableViewList.isHidden =  true
      loadingView.isHidden =  true
      view.sendSubviewToBack(loadingView)
      
      loadingViewVStackHStackFailureImageView.isHidden =  true
      loadingViewVStackHStackSuccessImageView.isHidden = true
      loadingViewVStackHStackLabelMessage.text = ""
      loadingViewVStackHStackLabelMessage.textColor = .systemBlue
      loadingViewVStackButton.isHidden =  true
      loadingViewVStackButton.isUserInteractionEnabled =  false
    }
    else if success! == true {
      loadingViewVStackHStackFailureImageView.isHidden =  true
      loadingViewVStackHStackSuccessImageView.isHidden = false
      loadingViewVStackHStackLabelMessage.text = "Weather Details received successfuly"
      loadingViewVStackHStackLabelMessage.textColor = .systemBlue
      loadingViewVStackButton.isHidden =  false
      loadingViewVStackButton.isUserInteractionEnabled =  true
    }
    else {
      loadingViewVStackHStackFailureImageView.isHidden =  false
      loadingViewVStackHStackSuccessImageView.isHidden = true
      loadingViewVStackHStackLabelMessage.text = errorMessage ??  "Failed.. Failed.. Failed.. Failed.. Failed.. Failed.. "
      loadingViewVStackHStackLabelMessage.textColor = .systemRed
      loadingViewVStackButton.isHidden =  false
      loadingViewVStackButton.isUserInteractionEnabled =  true
    }
    
  }
  
  @IBAction func actionDismissLoadingView(sender : UIButton) {
    
    loadingViewVStackHStackActivityIndicator.stopAnimating()
    loadingViewVStackHStackActivityIndicator.isHidden =  true
    
    loadingView.isHidden =  true
    view.sendSubviewToBack(loadingView)
    
    loadingViewVStackHStackFailureImageView.isHidden =  true
    loadingViewVStackHStackSuccessImageView.isHidden = true
    loadingViewVStackHStackLabelMessage.text = ""
    loadingViewVStackHStackLabelMessage.textColor = .systemBlue
    loadingViewVStackButton.isHidden =  true
    loadingViewVStackButton.isUserInteractionEnabled =  false
  }
  
  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WeatherForecastListViewController: UISearchBarDelegate{
  
//  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//    // validate searchBar text
//  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    //viewModel.searchKeyword = searchBar.text
    searchBar.resignFirstResponder()
    if (searchBar.text ?? "").count >= 3 {
      self.fetchWeatherDataFor(searchBar.text ?? "")
    }
    
    
  }
  
  func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
    
  }
  

}

extension WeatherForecastListViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return forecastListItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell: WeatherForecastListCell = tableView.dequeueReusableCell(withIdentifier: WeatherForecastListCell.reusableIdentifier, for: indexPath) as? WeatherForecastListCell else {
       return UITableViewCell()
    }
    return configCell(cell, with: forecastListItems[indexPath.row])
  }
}


extension WeatherForecastListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if let requiredData: HourlyDataItem = viewModel.selectItem(at: indexPath.row) ,
      let detailsVC: WeatherDetailsViewController = WeatherDetailsViewController.instantiate(with: WeatherForecatsDetailPresentationModel.init(with: requiredData), summaryInfo: forecastListItems[indexPath.row] ){
      navigationController?.pushViewController(detailsVC, animated: true)
    }
  }
}


extension WeatherForecastListViewController: WeatherForecastListVCDelegateProtocol {
  func weatherDataReceived(with data: [WeatherForeCastListItem]?, error: Error?) {
    forecastListItems = data ?? []
    DispatchQueue.main.async {[weak self] in
      if let _: [WeatherForeCastListItem] =  data, error == nil {
        self?.hideNetworkActivity(on: true, errorMessage: nil)
        self?.tableViewList.isHidden = false
        self?.tableViewList.reloadData()
      }
      else {
        self?.hideNetworkActivity(on: false, errorMessage: error?.localizedDescription)
      }
      
    }
   
  }
}
