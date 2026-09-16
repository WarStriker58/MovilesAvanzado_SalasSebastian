//
//  ViewController.swift
//  actividadlab5
//
//  Created by Tecsup on 16/09/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loanAmountTextField: UITextField!
    @IBOutlet weak var interestRateTextField: UITextField!
    @IBOutlet weak var loanTermTextField: UITextField!
    
    @IBOutlet weak var monthlyPaymentLabel: UILabel!
    @IBOutlet weak var totalPaymentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        monthlyPaymentLabel.text = "Cuota mensual: -$0.00"
        totalPaymentLabel.text = "Total a pagar: -$0.00"
    }

    @IBAction func calcularPrestamo(_ sender: Any) {
        let P = Double(loanAmountTextField.text ?? "") ?? 0
        let annualRate = Double(interestRateTextField.text ?? "") ?? 0
        let years = Double(loanTermTextField.text ?? "") ?? 0
                
        if P <= 0 || annualRate <= 0 || years <= 0 {
            monthlyPaymentLabel.text = "Por favor, ingresa valores válidos."
            totalPaymentLabel.text = ""
            return
        }
        
        let r = (annualRate / 100) / 12
                
        let n = years * 12
                
        let compoundedInterest = pow(1 + r, n)
        let monthlyPayment = P * (r * compoundedInterest) / (compoundedInterest - 1)
                
        let totalPayment = monthlyPayment * n
                
        monthlyPaymentLabel.text = String(format: "Cuota Mensual: $%.2f", monthlyPayment)
        totalPaymentLabel.text = String(format: "Monto Total a Pagar: $%.2f", totalPayment)
    }
}
