//
//  VaccineCertificateGenerateViewController.swift
//  Vax Vision
//
//  Created by unthinkable-mac-0025 on 23/06/21.
//

import UIKit

class VaccineOTPGenerateViewController: UIViewController {

    @IBOutlet var mobileNoTextField: UITextField!
    @IBOutlet var generateOTPButton: UIButton!
    
    private var presenter : VaccineOTPGeneratePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //add design to UI
        generateOTPButton.layer.cornerRadius = 15.0
        
        //setting self as the delegate of the presenter
        presenter = VaccineOTPGeneratePresenter(withDelegate: self)
    }
    
    @IBAction func generateOTPButtonPressed(_ sender: UIButton) {
        if let no = mobileNoTextField.text , !no.isEmpty{
            if isValidMobileNo(mobileNo: no){
                presenter.generateOTP(forMobileNo: no)
            }else{
                presentAlert(title: K.TextMessage.ALERT, message: "Please Enter a valid Mobile no")
            }
        }
    }
    
    func isValidMobileNo(mobileNo : String) -> Bool {
        let PHONE_REGEX = "(0|91)?[7-9][0-9]{9}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: mobileNo)
        return result
    }
    

}

//MARK: - Delegate functions
extension VaccineOTPGenerateViewController : VaccineOTPGeneratePresenterDelegate{
    
    func otpVerified(withTransactionId: String) {
        print(withTransactionId)
    }
    
    func presentAlert(title: String, message: String) {
        DispatchQueue.main.async { [self] in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: K.TextMessage.DISMISS, style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
}
