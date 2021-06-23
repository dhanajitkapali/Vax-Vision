//
//  VaccineSlotBookPresenter.swift
//  Vax Vision
//
//  Created by unthinkable-mac-0025 on 23/06/21.
//

import Foundation

protocol VaccineSlotBookPresenterDelegate : AnyObject{
    func presentAlert(title: String, message: String)
    func presentStatesInDropDownList(statesData : States)
    func presentDistrictsInDropDownList(districtsData : Districts)
}

class VaccineSlotBookPresenter{
    
    weak var delegate : VaccineSlotBookPresenterDelegate?
    
    init(withDelegate delegate: VaccineSlotBookPresenterDelegate) {
        self.delegate = delegate
    }
    
    public func getStateList(){
        let urlString = "https://cdn-api.co-vin.in/api/v2/admin/location/states"
        let url = URL(string: urlString)
        //make the call
        NetworkManager().getApiData(forUrl: url!, resultType: States.self) { (result) in
            switch result{
            case .success(let states):
                //print(states.states.count)
                self.delegate?.presentStatesInDropDownList(statesData: states)
                //self.delegate?.stopAndHideLoader()
            case .failure(let error):
                print(error.localizedDescription)
                //self.delegate?.stopAndHideLoader()
                self.delegate?.presentAlert(title: "Error" , message: error.localizedDescription)
            }
        }
    }
    
    public func getDistrictList(forStateID : Int){
        var urlString = "https://cdn-api.co-vin.in/api/v2/admin/location/districts/"
        urlString += String(forStateID)
        let url = URL(string: urlString)
        //make the call
        NetworkManager().getApiData(forUrl: url!, resultType: Districts.self) { (result) in
            switch result{
            case .success(let districts):
                //print(districts.districts.count)
                self.delegate?.presentDistrictsInDropDownList(districtsData: districts)
                //self.delegate?.stopAndHideLoader()
            case .failure(let error):
                print(error.localizedDescription)
                //self.delegate?.stopAndHideLoader()
                self.delegate?.presentAlert(title: "Error" , message: error.localizedDescription)
            }
        }
    }
    
    
}
