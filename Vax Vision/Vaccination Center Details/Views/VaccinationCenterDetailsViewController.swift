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
        if selectedFilterButtonStatus.contains(K.FilterParameters.FREE){ //button already selected
            selectedFilterButtonStatus = selectedFilterButtonStatus.filter({$0 != K.FilterParameters.FREE})
            sender.backgroundColor = UIColor.systemGray5
        }else{
            selectedFilterButtonStatus.append(K.FilterParameters.FREE)
            sender.backgroundColor = UIColor.red
        }
        filterCenterDetails()
        
    }
    
    @IBAction func paidButtonPressed(_ sender: UIButton) {
        if selectedFilterButtonStatus.contains(K.FilterParameters.PAID){
            selectedFilterButtonStatus = selectedFilterButtonStatus.filter({$0 != K.FilterParameters.PAID})
            sender.backgroundColor = UIColor.systemGray5
        }else{
            selectedFilterButtonStatus.append(K.FilterParameters.PAID)
            sender.backgroundColor = UIColor.red
        }
        filterCenterDetails()
    }
    
    @IBAction func age18PlusButtonPressed(_ sender: UIButton) {
        if selectedFilterButtonStatus.contains(K.FilterParameters.AGE_18_PLUS){
            selectedFilterButtonStatus = selectedFilterButtonStatus.filter({$0 != K.FilterParameters.AGE_18_PLUS})
            sender.backgroundColor = UIColor.systemGray5
        }else{
            selectedFilterButtonStatus.append(K.FilterParameters.AGE_18_PLUS)
            sender.backgroundColor = UIColor.red
        }
        filterCenterDetails()
    }
    
    @IBAction func age45PlusButtonPressed(_ sender: UIButton) {
        if selectedFilterButtonStatus.contains(K.FilterParameters.AGE_45_PLUS){
            selectedFilterButtonStatus = selectedFilterButtonStatus.filter({$0 != K.FilterParameters.AGE_45_PLUS})
            sender.backgroundColor = UIColor.systemGray5
        }else{
            selectedFilterButtonStatus.append(K.FilterParameters.AGE_45_PLUS)
            sender.backgroundColor = UIColor.red
        }
        filterCenterDetails()
    }
    @IBAction func covishiledButtonPressed(_ sender: UIButton) {
        if selectedFilterButtonStatus.contains(K.FilterParameters.COVISHIELD){
            selectedFilterButtonStatus = selectedFilterButtonStatus.filter({$0 != K.FilterParameters.COVISHIELD})
            sender.backgroundColor = UIColor.systemGray5
        }else{
            selectedFilterButtonStatus.append(K.FilterParameters.COVISHIELD)
            sender.backgroundColor = UIColor.red
        }
        filterCenterDetails()
    }
    
    @IBAction func covaxinButtonPressed(_ sender: UIButton) {
        if selectedFilterButtonStatus.contains(K.FilterParameters.COVAXIN){
            selectedFilterButtonStatus = selectedFilterButtonStatus.filter({$0 != K.FilterParameters.COVAXIN})
            sender.backgroundColor = UIColor.systemGray5
        }else{
            selectedFilterButtonStatus.append(K.FilterParameters.COVAXIN)
            sender.backgroundColor = UIColor.red
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
            //print("\(selectedFilterButtonStatus) ->\(selectedFilterButtonStatus.count)")
            centerDetails = centerDetailsBackup
            for i in 0...selectedFilterButtonStatus.count-1{
                let selectedButton = selectedFilterButtonStatus[i]
                switch selectedButton{
                case K.FilterParameters.FREE:
                    centerDetails = centerDetails.filter({$0.feeType == selectedButton})
                case K.FilterParameters.PAID:
                    centerDetails = centerDetails.filter({$0.feeType == selectedButton})
                case K.FilterParameters.AGE_18_PLUS:
                    centerDetails = centerDetails.filter({$0.minAgeLimit == 18})
                case K.FilterParameters.AGE_45_PLUS:
                    centerDetails = centerDetails.filter({$0.minAgeLimit == 45})
                case K.FilterParameters.COVISHIELD:
                    centerDetails = centerDetails.filter({$0.vaccine == selectedButton})
                case K.FilterParameters.COVAXIN:
                    centerDetails = centerDetails.filter({$0.vaccine == selectedButton})
                default:
                    centerDetails = centerDetailsBackup
                }
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
            alert.addAction(UIAlertAction(title: K.TextMessage.DISMISS, style: .cancel, handler: nil))
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
    
}


