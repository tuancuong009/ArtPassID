//
//  RiskSearchViewController.swift
//  ArtPassID
//
//  Created by QTS Coder on 13/5/25.
//  Copyright © 2025 QTS Coder. All rights reserved.
//

import UIKit
import DynamsoftMRZScannerBundle
import Alamofire
class RiskSearchViewController: BaseVC {
    var data: [(String, String)] = [
        ("Name", ""),
        ("Sex", ""),
        ("Age", ""),
        ("Document Type", ""),
        ("Document Number", ""),
        ("Issuing State", ""),
        ("Nationality", ""),
        ("Date Of Birth(YYYY-MM-DD)", ""),
        ("Date Of Expire(YYYY-MM-DD)", ""),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func doMRZScan(_ sender: Any) {
        let vc = MRZScannerViewController()
        vc.hidesBottomBarWhenPushed = true
        let config = MRZScannerConfig()
        config.license = "t0086pwAAAHvjBmOt1VggYNHL0n52yHdlJNJg2EtKZmcKILuURpSjYCKw24dvXblwg++H2UfsrrSz/hxrO1VZBkdR6EROhS8PanbEs+I+HX+IQbrCHhXVIfQ=;t0089pwAAAF4ebO0mKn7HEfGXswIOlgQXy2uA8W7I5bRiynU0CjrWX2EP1VYfDiMuZyGlOY04f+MYVnSuHQM7ljgKyOHPOQ2lX3RrUe/xwbV//GWOtQN/ABxcIf8="
        // some other settings
        vc.config = config
        
        vc.onScannedResult = { [weak self] result in
            guard let self = self else { return }
            switch result.resultStatus {
            case .finished:
                if let data = result.data {
                    let param = ["owner_username": APP_DELEGATE.userObj.username, "first_name": data.firstName , "middle_name": "", "last_name": data.lastName, "dob": data.dateOfBirth, "birth_country": data.nationality, "nationality": data.nationality, "gender": data.sex]
                    self.data = [
                        ("Name", data.firstName + " " + data.lastName),
                        ("Sex", data.sex.capitalized),
                        ("Age", String(data.age)),
                        ("Document Type", data.documentType),
                        ("Document Number", data.documentNumber),
                        ("Issuing State", data.issuingState),
                        ("Nationality", data.nationality),
                        ("Date Of Birth(YYYY-MM-DD)", data.dateOfBirth),
                        ("Date Of Expire(YYYY-MM-DD)", data.dateOfExpire),
                    ]
                    DispatchQueue.main.async {
                        print(self.data)
                        ApiHelper.shared.createPersonOnboard(param) { success, errer in
                            if let error = errer, let msg = error.msg{
                                APP_DELEGATE.showAlert(msg)
                            }
                        }
                    }
                }
            case .canceled:
                break
            case .exception:
                DispatchQueue.main.async {
                    print(result.errorString)
                }
            default:
                break
            }
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func doBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

