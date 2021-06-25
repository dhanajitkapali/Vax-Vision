//
//  VaccineSlotBookViewController.swift
//  Vax Vision
//
//  Created by unthinkable-mac-0025 on 23/06/21.
//

import UIKit

class VaccineSlotBookViewController: UIViewController {

    @IBOutlet private weak var selectStateMenuButton: UIButton!
    @IBOutlet private weak var selectDistrictMenuButton: UIButton!
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var checkSlotsButton: UIButton!
    
    private let transparentView = UIView()
    private let dropDownMenuTableView = UITableView()
    private var selectedDropDownMenuButton = UIButton()
    
    private var dataSource = [String]()
    private var statesInfo = [State]()
    private var districtsInfo = [District]()
    private var currentDropDown = dropDownSelected.none
    private var stateID : Int?
    private var districtID : Int?
    private var dateSelected : String?
    private var presenter : VaccineSlotBookPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add design to UI
        selectStateMenuButton.layer.cornerRadius = 15.0
        selectDistrictMenuButton.layer.cornerRadius = 15.0
        checkSlotsButton.layer.cornerRadius = 15.0
        
        //setting self delegate of presenter
        presenter = VaccineSlotBookPresenter(withDelegate : self)

        
        //initailizing the dateSelected
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateSelected = dateFormatter.string(from: datePicker.date)
        
        //setting the DatePicker
        datePicker.date = Date()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.addTarget(self, action: #selector(dateSetter), for: .valueChanged)

        //setting delegate and dataSorce of tableViews
        dropDownMenuTableView.delegate = self
        dropDownMenuTableView.dataSource = self
        dropDownMenuTableView.register(UITableViewCell.self, forCellReuseIdentifier: K.TableViewCellID.DROP_DOWN_MENU_CELL_ID)
    }
    
    @IBAction func selectStateMenuButtonPressed(_ sender: UIButton) {
        selectedDropDownMenuButton = selectStateMenuButton
        currentDropDown = .sate
        //get all the States to populate the DropDownList
        presenter.getStateList()
    }
    
    @IBAction func selectDistrictMenuButtonPressed(_ sender: UIButton) {
        selectedDropDownMenuButton = selectDistrictMenuButton
        currentDropDown = .district
        if let id = stateID{
            //get all the Districts to populate the dropDownList
            presenter.getDistrictList(forStateID: id)
        }else{
            presentAlert(title: K.TextMessage.ALERT, message: K.TextMessage.STATE_NOT_SELECTED)
        }
    }
    
    @IBAction func checkSlotsButtonPressed(_ sender: UIButton) {
        if let _ = districtID , let _ = dateSelected{
            performSegue(withIdentifier: K.SegueID.VACCINE_BOOK_TO_DETAILS, sender: self)
        }else{
            presentAlert(title: K.TextMessage.ALERT, message: K.TextMessage.DISTRICT_NOT_SELECTED)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.SegueID.VACCINE_BOOK_TO_DETAILS{
            let destinationVC = segue.destination as! VaccinationCenterDetailsViewController
            destinationVC.districtID = districtID
            destinationVC.selectedDate = dateSelected
        }
    }
    
    @objc private func dateSetter(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.string(from: datePicker.date)
        dateSelected = date
    }
    
}

//MARK: - Presenter functions
extension VaccineSlotBookViewController : VaccineSlotBookPresenterDelegate{
    func presentDistrictsInDropDownList(districtsData: Districts) {
        DispatchQueue.main.async { [self] in
            dataSource = []
            for i in 0...districtsData.districts.count-1{
                dataSource.append(districtsData.districts[i].districtName)
            }
            districtsInfo = districtsData.districts
            addDropDownMenu(withFrame: selectStateMenuButton.frame)
        }
    }
    
    func presentStatesInDropDownList(statesData: States) {
        DispatchQueue.main.async { [self] in
            dataSource = []
            for i in 0...statesData.states.count-1{
                dataSource.append(statesData.states[i].stateName)
            }
            statesInfo = statesData.states
            addDropDownMenu(withFrame: selectStateMenuButton.frame)
        }
    }
    
    func presentAlert(title: String, message: String) {
        DispatchQueue.main.async { [self] in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: K.TextMessage.DISMISS, style: .cancel, handler: nil))
            self.present(alert, animated: true)
//            print("Error -> presentAlert From VaccineSlots")
            if stateID == nil{
                removeDropDownMenu()
            }
        }
    }
}

extension VaccineSlotBookViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dropDownMenuTableView.dequeueReusableCell(withIdentifier: K.TableViewCellID.DROP_DOWN_MENU_CELL_ID , for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDropDownMenuButton.setTitle(dataSource[indexPath.row], for: .normal)
        if currentDropDown == .sate{
            stateID = statesInfo[indexPath.row].stateID
                //indexPath.row
        }
        if currentDropDown == .district{
            districtID = districtsInfo[indexPath.row].districtID
        }
        removeDropDownMenu()
    }
}

//MARK: - DropDownMenu
extension VaccineSlotBookViewController {
    func addDropDownMenu(withFrame : CGRect){
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        //setting the frames of tableView used for DropDownMenu, setting height = 0 initially
        dropDownMenuTableView.frame = CGRect(x: withFrame.origin.x, y: withFrame.origin.y + withFrame.height, width: withFrame.width, height: 0)
        self.view.addSubview(dropDownMenuTableView)
        dropDownMenuTableView.layer.cornerRadius = 5.0
        dropDownMenuTableView.reloadData()
        
        //remove the Menu on tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeDropDownMenu))
        transparentView.addGestureRecognizer(tapGesture)
        
        //adding animation for appearance of DropDownMenu
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.transparentView.alpha = 0.9
            let dropDownMenuFullHeight = self.dataSource.count * 45
            self.dropDownMenuTableView.frame = CGRect(x: withFrame.origin.x + 5, y: withFrame.origin.y + withFrame.height, width: withFrame.width, height: dropDownMenuFullHeight < 350 ? CGFloat(dropDownMenuFullHeight) : 350 )
        } completion: { (done) in
            if(done){
                
            }
        }

    }
    
    @objc func removeDropDownMenu(){
        let withFrame = selectedDropDownMenuButton.frame
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.transparentView.alpha = 0
            self.dropDownMenuTableView.frame = CGRect(x: withFrame.origin.x, y: withFrame.origin.y + withFrame.height, width: withFrame.width, height: 0)
        } completion: { (done) in
            if(done){
                
            }
        }
    }
}

//MARK: - Enums
enum dropDownSelected{
    case sate
    case district
    case none
}
