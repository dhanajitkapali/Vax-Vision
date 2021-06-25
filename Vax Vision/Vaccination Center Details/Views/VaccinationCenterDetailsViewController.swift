//
//  VaccinationCenterDetailsViewController.swift
//  Vax Vision
//
//  Created by unthinkable-mac-0025 on 24/06/21.
//

import UIKit

class VaccinationCenterDetailsViewController: UIViewController {

    @IBOutlet var freeButton: UIButton!
    @IBOutlet var paidButton: UIButton!
    @IBOutlet var age18PlusButton: UIButton!
    @IBOutlet var age45PlusButton: UIButton!
    @IBOutlet var covishieldButton: UIButton!
    @IBOutlet var covaxinButton: UIButton!
    
    @IBOutlet private weak var vaccinationCenterDetailsTableView: UITableView!
    
    private var presenter : VaccinationCenterDetailsPresenter!
    var districtID : Int?
    var selectedDate : String?
    private var centerDetails = [Session]()
    private var centerDetailsBackup = [Session]()
    private var selectedFilterButtonStatus = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addDesignToUI()
        
        
        
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
    
    @IBAction func freeButtonPressed(_ sender: UIButton) {
        print("Free")
        if selectedFilterButtonStatus.contains(K.FilterParameters.FREE){
            selectedFilterButtonStatus = selectedFilterButtonStatus.filter({$0 != K.FilterParameters.FREE})
        }else{
            selectedFilterButtonStatus.append(K.FilterParameters.FREE)
        }
        filterCenterDetails()
        
//        print("free")
//        centerDetails = centerDetails.filter({$0.feeType == "Free"})
//        print(centerDetails.count)
//        vaccinationCenterDetailsTableView.reloadData()
    }
    
    @IBAction func paidButtonPressed(_ sender: UIButton) {
        print("paid")
        if selectedFilterButtonStatus.contains(K.FilterParameters.PAID){
            selectedFilterButtonStatus = selectedFilterButtonStatus.filter({$0 != K.FilterParameters.PAID})
        }else{
            selectedFilterButtonStatus.append(K.FilterParameters.PAID)
        }
        filterCenterDetails()
    }
    
    @IBAction func age18PlusButtonPressed(_ sender: UIButton) {
        print("18+")
        if selectedFilterButtonStatus.contains(K.FilterParameters.AGE_18_PLUS){
            selectedFilterButtonStatus = selectedFilterButtonStatus.filter({$0 != K.FilterParameters.AGE_18_PLUS})
        }else{
            selectedFilterButtonStatus.append(K.FilterParameters.AGE_18_PLUS)
        }
        filterCenterDetails()
    }
    
    @IBAction func age45PlusButtonPressed(_ sender: Any) {
        print("45+")
        if selectedFilterButtonStatus.contains(K.FilterParameters.AGE_45_PLUS){
            selectedFilterButtonStatus = selectedFilterButtonStatus.filter({$0 != K.FilterParameters.AGE_45_PLUS})
        }else{
            selectedFilterButtonStatus.append(K.FilterParameters.AGE_45_PLUS)
        }
        filterCenterDetails()
    }
    @IBAction func covishiledButtonPressed(_ sender: UIButton) {
        print("covishield")
        if selectedFilterButtonStatus.contains(K.FilterParameters.COVISHIELD){
            selectedFilterButtonStatus = selectedFilterButtonStatus.filter({$0 != K.FilterParameters.COVISHIELD})
        }else{
            selectedFilterButtonStatus.append(K.FilterParameters.COVISHIELD)
        }
        filterCenterDetails()
    }
    
    @IBAction func covaxinButtonPressed(_ sender: UIButton) {
        print("covaxin")
        if selectedFilterButtonStatus.contains(K.FilterParameters.COVAXIN){
            selectedFilterButtonStatus = selectedFilterButtonStatus.filter({$0 != K.FilterParameters.COVAXIN})
        }else{
            selectedFilterButtonStatus.append(K.FilterParameters.COVAXIN)
        }
        filterCenterDetails()
    }
    
    func addDesignToUI(){
        freeButton.layer.cornerRadius = 5.0
        paidButton.layer.cornerRadius = 5.0
        age18PlusButton.layer.cornerRadius = 5.0
        age45PlusButton.layer.cornerRadius = 5.0
        covishieldButton.layer.cornerRadius = 5.0
        covaxinButton.layer.cornerRadius = 5.0
    }
    
    func filterCenterDetails(){
        if selectedFilterButtonStatus.count == 0{
            centerDetails = centerDetailsBackup
        }else{
            for i in 0...selectedFilterButtonStatus.count-1{
                let selectedButton = selectedFilterButtonStatus[i]
                centerDetails = centerDetails.filter({$0.feeType == selectedButton})
                
            }
        }
        vaccinationCenterDetailsTableView.reloadData()
    } //:filterCenterDetails
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
            centerDetailsBackup = centers
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

//MARK: - Filter Button Functions
extension VaccinationCenterDetailsDelegate{
   
}

enum filterButton {
    case none
    enum free {
        case isSelected
        case notSelected
    }
}
