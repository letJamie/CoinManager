//
//  ViewController.swift
//  CoinManager
//
//  Created by Jamie on 2020/07/18.
//  Copyright © 2020 Jamie. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let coinManager = CoinManager()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCorrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCorrency)
    }
    
    @IBOutlet weak var currencyLabel: UILabel!
    
    @IBOutlet weak var bitCoinLabel: UILabel!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        // Do any additional setup after loading the view.
        
        
    }



}

