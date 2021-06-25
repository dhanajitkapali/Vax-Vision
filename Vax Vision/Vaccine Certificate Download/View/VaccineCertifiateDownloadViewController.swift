//
//  VaccineCertifiateDownloadViewController.swift
//  Vax Vision
//
//  Created by unthinkable-mac-0025 on 25/06/21.
//

import UIKit

class VaccineCertifiateDownloadViewController: UIViewController {

    @IBOutlet var referenceIdTextField: UITextField!
    @IBOutlet var downloadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //add design to UI
        downloadButton.layer.cornerRadius = 15.0
    }
    
    @IBAction func downloadButtonPressed(_ sender: UIButton) {
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
