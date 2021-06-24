//
//  VaccinationCenterDetailsViewController.swift
//  Vax Vision
//
//  Created by unthinkable-mac-0025 on 24/06/21.
//

import UIKit

class VaccinationCenterDetailsViewController: UIViewController {

    @IBOutlet var vaccinationCenterDetailsTableView: UITableView!
    
    private var presenter : VaccinationCenterDetailsPresenter!
    var districtID : Int?
    var selectedDate : String?
    var centerDetails = [Session]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setting self as the delegate of the presenter
        presenter = VaccinationCenterDetailsPresenter(withDelegate : self)
        
        //register nib in tableView Cell
        vaccinationCenterDetailsTableView.register(UINib(nibName: K.XibWithName.VACCINATION_CENTER_DETAILS, bundle: nil), forCellReuseIdentifier: K.TableViewCellID.VACCINATION_CENTER_DETAILS_CELL_ID)
        
        //setting delegate and dataSource of tableView
        vaccinationCenterDetailsTableView.delegate = self
        vaccinationCenterDetailsTableView.dataSource = self
        
        
        if let id = districtID , let date = selectedDate{
            presenter.getVaccinationCenterDetails(forDistrictID: id, forDate: date)
        }
    }
    

}

//MARK: - Delegate Functions
extension VaccinationCenterDetailsViewController : VaccinationCenterDetailsDelegate{
    func presentAlert(title: String, message: String) {
        DispatchQueue.main.async { [self] in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func presentVaccinationCenterDetails(centers : [Session]){
        DispatchQueue.main.async { [self] in
            centerDetails = centers
            print(centerDetails.count)
            vaccinationCenterDetailsTableView.reloadData()
        }
    }
    
}

extension VaccinationCenterDetailsViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return centerDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = vaccinationCenterDetailsTableView.dequeueReusableCell(withIdentifier: K.TableViewCellID.VACCINATION_CENTER_DETAILS_CELL_ID , for: indexPath) as! VaccinationCenterDetails
        cell.selectionStyle = .none
        //cell.containerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height:223)
        cell.populateCell(withData: centerDetails[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vaccinationCenterDetailsTableView.deselectRow(at: indexPath, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 223
//    }
    
    
}
