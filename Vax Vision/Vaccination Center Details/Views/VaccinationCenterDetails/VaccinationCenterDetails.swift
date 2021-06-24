//
//  VaccinationCenterDetails.swift
//  Vax Vision
//
//  Created by unthinkable-mac-0025 on 24/06/21.
//

import UIKit

class VaccinationCenterDetails: UITableViewCell {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var vaccineCenterName: UILabel!
    @IBOutlet var vaccinationCenterAddress: UILabel!
    @IBOutlet var vaccinationCenterTimings: UILabel!
    @IBOutlet var vaccineName: UILabel!
    @IBOutlet var doseOneCapacity: UILabel!
    @IBOutlet var doseTwoCapacity: UILabel!
    @IBOutlet var vaccineFee: UILabel!
    @IBOutlet var vaccineAgeLimit: UILabel!
    @IBOutlet var registrationAtCowinButton: UIButton!
    
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
    }
    
    @IBAction func registrationAtCowinButtonPressed(_ sender: Any) {
    }
    
    private func addDesignToUI(){
        //contentView.layer.cornerRadius = 15.0
//        registrationAtCowinButton.clipsToBounds = true
//        registrationAtCowinButton.layer.cornerRadius = 15.0
//        registrationAtCowinButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
}
