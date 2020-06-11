//
//  ViewController.swift
//  Currency converter
//
//  Created by Admin on 08.06.2020.
//  Copyright © 2020 Kolenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
        
    var myCurrency:[String] = []
    var myValues:[Double] = []
    
    var activeCurrency:Double = 0;
    
    //Objects
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var output: UILabel!
    
    //Creating picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return myCurrency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return myCurrency[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        activeCurrency = myValues[row]
    }
    
    //BUTTON
    @IBAction func action(_ sender: AnyObject)
    {
        if (input.text != "")
        {
        output.text = String(Double(input.text!)! * activeCurrency)
        }
    }
           
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getting data
        let url = URL(string: "https://api.exchangeratesapi.io/latest")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil
            {
                print ("ERROR")
            }
            else
            {
                if let content = data
                {
                    do
                    {
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        if let rates = myJson["rates"] as? NSDictionary
                        {
                            for (key, value) in rates
                            {
                                
                                do {
                                self.myCurrency.append((key as?  String)!)
                                self.myValues.append((value as? Double)!)
                                    }
                            }
                        }
                    }
                    catch
                    {
                }
            }
        }
            self.pickerView.reloadAllComponents()
    }
    task.resume()
        
}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // Do any additional setup after loading the view, typically from a nib.
    }




