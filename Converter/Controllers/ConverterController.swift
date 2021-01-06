//
//  ConverterController.swift
//  Converter
//
//  Created by ivan on 05.01.2021.
//

import UIKit

class ConverterController: UIViewController {
    
    var currencys = [CurrencyModel]()
    var list = ["USD", "EUR","UAH"]
    var change = true
    var currentCurrencyRate: Double = 0
    var secondCurrencyRate: Double = 0
    
    @IBOutlet weak var secondCurrencyLabel: UILabel!
    @IBOutlet weak var secondCurrencyTF: UITextField!
    
    @IBOutlet weak var currentCurrencyLabel: UILabel!
    @IBOutlet weak var currentCurrencyTF: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.isHidden = true
        
        secondCurrencyLabel.isUserInteractionEnabled = true
        secondCurrencyLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapSecondCurrency)))
        
        currentCurrencyLabel.isUserInteractionEnabled = true
        currentCurrencyLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapCurrentCurrency)))
        
        let newDictionary = CurrencyModel(rate: 1.00, cc: "UAH")
        currencys.append(newDictionary)
        
        defaultValue()
    }
    
    func defaultValue() {
        
        currentCurrencyRate = currencys[0].rate
        currentCurrencyLabel.text = currencys[0].cc
        
        secondCurrencyRate = currencys[0].rate
        secondCurrencyLabel.text = currencys[0].cc
    }
    
    @objc func tapCurrentCurrency() {
        change = false
        picker.reloadAllComponents()
        picker.isHidden = false
    }
    
    @objc func tapSecondCurrency() {
        change = true
        picker.reloadAllComponents()
        picker.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        picker.isHidden = true
    }
    
    func result(textField: UITextField) {
        if textField == secondCurrencyTF {
            let text = secondCurrencyTF.text ?? "0"
            
            if let value1 = Double(text) {
                let value = value1 * secondCurrencyRate / currentCurrencyRate
                currentCurrencyTF.text = String(format: "%.2f", value)
            } else {
                currentCurrencyTF.text = ""
            }
        }
        if textField == currentCurrencyTF {
            let text = currentCurrencyTF.text ?? "0"
            
            if let value1 = Double(text) {
                let value = value1 * currentCurrencyRate / secondCurrencyRate
                secondCurrencyTF.text = String(format: "%.2f", value)
            } else {
                secondCurrencyTF.text = ""
            }
        }
    }
    
    @IBAction func secondTFEditionChanged(_ sender: Any) {
        result(textField: secondCurrencyTF)
    }
    @IBAction func currentTFEditionChanged(_ sender: Any) {
        result(textField: currentCurrencyTF)
    }
}


extension ConverterController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if change == true {
            secondCurrencyLabel.text = list[row]
            secondCurrencyRate = currencys[row].rate
            result(textField: currentCurrencyTF)
        } else {
            currentCurrencyLabel.text = list[row]
            currentCurrencyRate = currencys[row].rate
            result(textField: secondCurrencyTF)
        }
        picker.isHidden = true
    }
}
