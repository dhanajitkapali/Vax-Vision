//
//  VaccinationCenterDetails.swift
//  Vax Vision
//
//  Created by unthinkable-mac-0025 on 24/06/21.
//

import UIKit

class VaccinationCenterDetails: UITableViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var vaccineCenterName: UILabel!
    @IBOutlet private weak var vaccinationCenterAddress: UILabel!
    @IBOutlet private weak var vaccinationCenterTimings: UILabel!
    @IBOutlet private weak var vaccineName: UILabel!
    @IBOutlet private weak var doseOneCapacity: UILabel!
    @IBOutlet private weak var doseTwoCapacity: UILabel!
    @IBOutlet private weak var vaccineFee: UILabel!
    @IBOutlet private weak var vaccineAgeLimit: UILabel!
    @IBOutlet private weak var registrationAtCowinButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        addDesignToUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func mapButtonPressed(_ sender: UIButton) {
        print("mapButtonPressed")
    }
    
    @IBAction func registrationAtCowinButtonPressed(_ sender: Any) {
        print("registraionButtonPressed")
    }
    
    private func addDesignToUI(){
        contentView.layer.cornerRadius = 15.0
        registrationAtCowinButton.clipsToBounds = true
        registrationAtCowinButton.layer.cornerRadius = 15.0
        registrationAtCowinButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func populateCell(withData : Session){
        self.vaccineCenterName.text = withData.name
        self.vaccinationCenterAddress.text = withData.address
        
        //get the date in required format
        let timings = getCenterTimingsInString(withDate: withData.date, from: withData.from, to: withData.to)
        self.vaccinationCenterTimings.text = timings
        self.vaccineName.text = withData.vaccine
        self.doseOneCapacity.text = String(withData.availableCapacityDose1)
        self.doseTwoCapacity.text = String(withData.availableCapacityDose2)
        self.vaccineFee.text = withData.fee == "0" ? "Free" : withData.fee
        vaccineAgeLimit.text = "Available For:- \(withData.minAgeLimit)+"
    }
    
    private func getCenterTimingsInString(withDate : String , from : String, to : String) -> String{
        let timings = withDate + " from " + from + " to " + to
        return timings
    }
}
