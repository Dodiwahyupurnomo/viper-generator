//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit

class ___VARIABLE_viperModuleName___ViewController: UIViewController,___VARIABLE_viperModuleName___ViewProtocol {
    var presenter: ___VARIABLE_viperModuleName___PresenterProtocol?

    init() {
        super.init(nibName: "___VARIABLE_viperModuleName___", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
