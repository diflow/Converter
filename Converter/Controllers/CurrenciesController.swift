//
//  CurrenciesController.swift
//  Converter
//
//  Created by ivan on 05.01.2021.
//

import UIKit

class CurrenciesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var currencys = [CurrencyModel]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = "https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?json"
        
        NetworkManager.fetchData(url: url) { (currencyModels) in
            self.currencys = currencyModels.filter{ $0.cc == "EUR" || $0.cc == "USD"}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
            
        }
        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let currency = currencys[indexPath.row]
        
        cell.ccLabel.text = currency.cc
        cell.rateLabel.text = String(format: "%.2f", currency.rate)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToConverter" {
            
            let converterController = segue.destination as! ConverterController
            converterController.currencys = currencys
        }
    }
    
}
