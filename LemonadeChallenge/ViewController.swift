//
//  ViewController.swift
//  LemonadeChallenge
//
//  Created by Adriel Carsete on 5/25/15.
//  Copyright (c) 2015 Adriel Carsete. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var lemonLabel: UILabel!
    @IBOutlet weak var iceCubeLabel: UILabel!
    
    @IBOutlet weak var lemonsToBuyLabel: UILabel!
    @IBOutlet weak var iceCubesToBuyLabel: UILabel!
    
    @IBOutlet weak var lemonsToMixLabel: UILabel!
    @IBOutlet weak var iceCubsToMixLabel: UILabel!
    
    @IBOutlet weak var temperatureImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var mixJarProgress: UIImageView!
    
    
    var lemonsToBuy = 0
    var iceCubesToBuy = 0
    var lemonsToMix = 0
    var iceCubesToMix = 0
    var temperature = 0
    
    var myMoney = 10
    var myLemons = 1
    var myIceCubes = 1
    
    var priceOfGlass = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        weatherRandom()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //STEP ONE BUTTONS
    
    //STORE LEMONS
    @IBAction func plusLemonToBuyButton(sender: AnyObject) {
       
        if (myMoney >= 2) {
            myMoney -= 2
            self.moneyLabel.text = "$ \(self.myMoney)"
            self.lemonsToBuy++
            self.lemonsToBuyLabel.text = String(self.lemonsToBuy)
            self.myLemons++
            self.lemonLabel.text = "\(myLemons) Lemons"
        }
        
    }
    @IBAction func lessLemonToBuyButton(sender: AnyObject) {
        
        if (self.lemonsToBuy > 0 && self.myLemons > 0) {
            myMoney += 2
            self.moneyLabel.text = "$ \(self.myMoney)"
            self.lemonsToBuy--
            self.lemonsToBuyLabel.text = String(self.lemonsToBuy)
            self.myLemons--
            self.lemonLabel.text = "\(myLemons) Lemons"
        }
    }
    //STORE ICE CUBES
    @IBAction func plusIceCubeToBuyButton(sender: AnyObject) {
        
        if (myMoney >= 1) {
            myMoney--
            self.moneyLabel.text = "$ \(self.myMoney)"
            self.iceCubesToBuy++
            self.iceCubesToBuyLabel.text = String(self.iceCubesToBuy)
            self.myIceCubes++
            self.iceCubeLabel.text = "\(myIceCubes) Ice Cubes"
        }
    }
    @IBAction func lessIceCubeToBuyButton(sender: AnyObject) {
        
        if (self.iceCubesToBuy > 0 && self.myIceCubes > 0) {
            myMoney++
            self.moneyLabel.text = "$ \(self.myMoney)"
            self.iceCubesToBuy--
            iceCubesToBuyLabel.text = String(iceCubesToBuy)
            self.myIceCubes--
            self.iceCubeLabel.text = "\(myIceCubes) Ice Cubes"
            
        }
    }
    //STEP TWO BUTTONS
    //MIX LEMONS
    @IBAction func plusLemonToMixButton(sender: AnyObject) {
        
        if (myLemons > 0) {
            myLemons--
            self.lemonLabel.text = "\(myLemons) Lemons"
            self.lemonsToMix++
            self.lemonsToMixLabel.text = String(lemonsToMix)
            mixingJar()
        }
    }
    @IBAction func lessLemonToMixButton(sender: AnyObject) {
        
        if (lemonsToMix > 0) {
            self.myLemons++
            self.lemonLabel.text = "\(myLemons) Lemons"
            self.lemonsToMix--
            lemonsToMixLabel.text = String(lemonsToMix)
            mixingJar()
        }
        
    }
    //MIX ICE CUBES
    @IBAction func plusIceCubeToMixButton(sender: AnyObject) {
        
        if (myIceCubes > 0) {
            myIceCubes--
            self.iceCubeLabel.text = "\(myIceCubes) Ice Cubes"
            self.iceCubesToMix++
            iceCubsToMixLabel.text = String(iceCubesToMix)
            mixingJar()
        }
    }
    @IBAction func lessIceCubeToMixButton(sender: AnyObject) {
        
        if (iceCubesToMix > 0) {
            myIceCubes++
            self.iceCubeLabel.text = "\(myIceCubes) Ice Cubes"
            self.iceCubesToMix--
            iceCubsToMixLabel.text = String(iceCubesToMix)
            mixingJar()
        }
    }
    
    
    
    //START DAY BUTTON
    @IBAction func startDayButtonPressed(sender: AnyObject) {
        if (self.lemonsToMix > 0 && self.iceCubesToMix > 0) {
            updateViewLemonade()
            startDay()
        }
        else {
            showAlertWithText(header: "Warning", message: "You need to mix some Lemonade to sell")
        }
    }
    
    func updateViewLemonade() {
       
        weatherRandom()
        mixingJar()
        
        self.lemonsToBuy = 0
        self.lemonsToBuyLabel.text = String(self.lemonsToBuy)
        self.iceCubesToBuy = 0
        self.iceCubesToBuyLabel.text = String(self.iceCubesToBuy)
        self.lemonsToMix = 0
        self.lemonsToMixLabel.text = String(self.lemonsToMix)
        self.iceCubesToMix = 0
        self.iceCubsToMixLabel.text = String(self.iceCubesToMix)
        
    }
    
    func weatherRandom() {
        self.temperature = Int(arc4random_uniform(UInt32(45)))
        self.temperatureLabel.text = "\(temperature) c"
       
        if (self.temperature < 19) {
            self.temperatureImage.image = UIImage(named: "Cold")
        }
        else if (self.temperature < 30) {
            self.temperatureImage.image = UIImage(named: "Mild")
        }
        else {
            self.temperatureImage.image = UIImage(named: "Warm")
        }
    }
    
    func mixingJar() {
        var mixedValue = Double(lemonsToMix) / Double(iceCubesToMix * 2)
        
        if (self.lemonsToMix > 0 && self.iceCubesToMix > 0) {
            if (mixedValue <= 0.4)  {
                self.mixJarProgress.image = UIImage(named: "Progress25")
                self.priceOfGlass = 2
            }
            else if (mixedValue <= 0.6)  {
                self.mixJarProgress.image = UIImage(named: "Progress50")
                self.priceOfGlass = 1
            }
            else {
                self.mixJarProgress.image = UIImage(named: "Progress75")
                self.priceOfGlass = 2
            }
        }
        else {
            self.mixJarProgress.image = UIImage(named: "Progress0")
            self.priceOfGlass = 0
        }
    }
    
    func showAlertWithText (header: String = "TODAY'S SALES", message: String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    func startDay () {
        var randomCustomers = 0
        var moneyIncome = 0
        if (self.temperature < 19) {
            randomCustomers = Int(arc4random_uniform(UInt32(9)))
            moneyIncome = (randomCustomers - Int(arc4random_uniform(UInt32(3)))) * self.priceOfGlass
            myMoney += moneyIncome
            moneyLabel.text = "$ \(self.myMoney)"
        }
        else if (self.temperature < 30) {
            randomCustomers = Int(arc4random_uniform(UInt32(15)))
            moneyIncome = (randomCustomers - Int(arc4random_uniform(UInt32(5)))) * self.priceOfGlass
            myMoney += moneyIncome
            moneyLabel.text = "$ \(self.myMoney)"
        }
        else {
            randomCustomers = Int(arc4random_uniform(UInt32(15))) + 4
            moneyIncome = (randomCustomers - Int(arc4random_uniform(UInt32(5)))) * self.priceOfGlass
            myMoney += moneyIncome
            moneyLabel.text = "$ \(self.myMoney)"
        }
        
        showAlertWithText(message: "Today's Lemonade Sales \(randomCustomers) with an income of $ \(moneyIncome)")
    }
    
    
    
}

