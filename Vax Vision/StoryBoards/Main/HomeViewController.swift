//
//  ViewController.swift
//  Vax Vision
//
//  Created by unthinkable-mac-0025 on 23/06/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private weak var checkVaccineSlotsButton: UIButton!
    @IBOutlet private weak var downloadVaccineCertificateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add design to UI
        checkVaccineSlotsButton.layer.cornerRadius = 15.0
        downloadVaccineCertificateButton.layer.cornerRadius = 15.0
        
    }


}

