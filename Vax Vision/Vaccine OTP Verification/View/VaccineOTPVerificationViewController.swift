//
//  VaccineOTPVerificationViewController.swift
//  Vax Vision
//
//  Created by unthinkable-mac-0025 on 25/06/21.
//

import UIKit

class VaccineOTPVerificationViewController: UIViewController {

    @IBOutlet var mobileNoTextField: UITextField!
    @IBOutlet var otpTextField: UITextField!
    @IBOutlet var otpSubmitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //add design to UI
        otpSubmitButton.layer.cornerRadius = 15.0
    }
    
    @IBAction func otpSubmitButtonPressed(_ sender: UIButton) {
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
