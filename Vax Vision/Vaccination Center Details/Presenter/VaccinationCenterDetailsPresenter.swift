//
//  VaccinationCenterDetailsPresenter.swift
//  Vax Vision
//
//  Created by unthinkable-mac-0025 on 24/06/21.
//

import Foundation
protocol VaccinationCenterDetailsDelegate: AnyObject {
    func presentAlert(title: String, message: String)
    func presentVaccinationCenterDetails(centers : [Session])
}

class VaccinationCenterDetailsPresenter{
    weak var delegate : VaccinationCenterDetailsDelegate!
    
    init(withDelegate : VaccinationCenterDetailsDelegate) {
        self.delegate = withDelegate
    }
    
    public func getVaccinationCenterDetails(forDistrictID : Int, forDate : String){
        var urlString = "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByDistrict?"
        urlString += "district_id=\(forDistrictID)&date=\(forDate)"
        let url = URL(string: urlString)
        //make the call
        NetworkManager().getApiData(forUrl: url!, resultType: VaccinationCenters.self) { (result) in
            switch result{
            case .success(let centersData):
                self.delegate.presentVaccinationCenterDetails(centers: centersData.sessions)
            case .failure(let error):
                self.delegate?.presentAlert(title: "Error" , message: error.localizedDescription)
            }
        }
    }
}
