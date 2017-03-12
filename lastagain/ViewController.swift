//
//  ViewController.swift
//  lastagain
//
//  Created by Marc Condon on 3/11/17.
//  Copyright © 2017 Marc Condon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var totalCheckAmountField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalTipLabel: UILabel!
    @IBOutlet weak var bartableControl: UISegmentedControl!
    @IBOutlet weak var totalCheckCalcLabel: UILabel!
    @IBOutlet weak var explanitoryTaxLabel: UILabel!
    @IBOutlet weak var calculatedTaxLabel: UILabel!
    @IBOutlet weak var preTaxAdjustTotal: UILabel!
    @IBOutlet weak var debitCardTaxLabel: UILabel!
    @IBOutlet weak var cashTravelAdjustmentControll: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }

    @IBAction func bartChanged(_ sender: Any) {
        calculateTip.self(Any.self)
    }
    
    @IBAction func cashdebitmode(_ sender: Any) {
        calculateTip.self(Any.self)
    }
    
    @IBAction func calculateTip(_ sender: Any) {

        let tipPercentagesBARTnonBART = [0.10, 0.08]
        let total_check_amount = Double(totalCheckAmountField.text!) ?? 0
        let tax = tipPercentagesBARTnonBART[bartableControl.selectedSegmentIndex]
        let fmtTx = String(format: "$%.2f", tax)
        let fmtTot = String(format: "$%.2f", total_check_amount)
        let adjustedaftertaxtotal = total_check_amount - (tax * total_check_amount)
        let tip = (adjustedaftertaxtotal * 0.20)
        
        totalCheckCalcLabel.text = String(format: "$%.2f", total_check_amount)
        explanitoryTaxLabel.text = "Minus Tax \(fmtTx)X\(fmtTot)"
        calculatedTaxLabel.text = String(format: "-$%.2f", tax * total_check_amount)
        preTaxAdjustTotal.text = String(format: "$%.2f", total_check_amount - (tax * total_check_amount))
        debitCardTaxLabel.text = String(format: "$%.2f", total_check_amount + 0.20 * (total_check_amount - (tax * total_check_amount)))
        
        tipAmountLabel.text = String(format: "$%.2f", tip)
        // Round Total
        if cashTravelAdjustmentControll.selectedSegmentIndex == 0 {
            // No rounding, using debit card
            totalTipLabel.text = String(format: "$%.2f", total_check_amount + tip)
        } else if cashTravelAdjustmentControll.selectedSegmentIndex == 1 {
            // Round to nearest $ definitely don't want any coinage returned
            totalTipLabel.text = String(format: "$%.2f", ceil(total_check_amount + tip))
            tipAmountLabel.text = String(format: "$%.2f", tip + ceil(total_check_amount + tip) - (total_check_amount + tip))
        } else if cashTravelAdjustmentControll.selectedSegmentIndex == 2 {
            // Round to nearest $5, je ne sais quoi
            for i in 0...4 {
                if ceil((total_check_amount + tip + Double(i))).truncatingRemainder(dividingBy: 5.00) == 0 {
                    totalTipLabel.text = String(format: "$%.2f", ceil(total_check_amount + tip + Double(i)))
                    tipAmountLabel.text = String(format: "$%.2f", tip + (ceil(total_check_amount + tip + Double(i)) - (total_check_amount + tip)))

                }
            }


        }
    }
}

