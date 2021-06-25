//
//  VaccineCertificateGenerate.swift
//  Vax Vision
//
//  Created by unthinkable-mac-0025 on 23/06/21.
//

import Foundation

protocol VaccineOTPGeneratePresenterDelegate : AnyObject{
    func presentAlert(title: String, message: String)
    func otpVerified(withTransactionId : String)
}

class VaccineOTPGeneratePresenter{
    
    private var delegate : VaccineOTPGeneratePresenterDelegate!
    
    init(withDelegate : VaccineOTPGeneratePresenterDelegate) {
        self.delegate = withDelegate
    }
    
    public func generateOTP(forMobileNo : String){
        let urlString = "https://cdn-api.co-vin.in/api/v2/auth/public/generateOTP"
        let url = URL(string: urlString)
        
        let request = MobileNo(mobileNo: forMobileNo)
        
        do{
            //ennode the request to JSON
            let encodedRequest = try JSONEncoder().encode(request)
            //make the call
            NetworkManager().postApiData(requestUrl: url!, requestBody: encodedRequest, resultType: OTPVerified.self) { (result) in
                switch result{
                case .success(let resultData):
                    self.delegate.otpVerified(withTransactionId: resultData.txnID)
                case .failure(let error):
                    self.delegate?.presentAlert(title: K.TextMessage.ERROR , message: error.localizedDescription)
                }
            }
        } catch let err{
            print("Error ->\(err)")
        }
        
        
    }
}

struct MobileNo : Codable{
    let mobileNo : String
}

struct OTPVerified: Codable {
    let txnID: String

    enum CodingKeys: String, CodingKey {
        case txnID = "txnId"
    }
}
