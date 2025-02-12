//
//  StartViewController.swift
//  SampleNewsApplication
//
//  Created by Damotharan KG on 10/02/25.
//

import UIKit

class StartViewController: BaseViewController {

    @IBOutlet weak var startBtn: UIButtonCustom!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func startBtnAction(_ sender: Any) {
        let sID = String(describing: ListOfNewsViewController.self)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: sID) as? ListOfNewsViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
