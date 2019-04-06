//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit

class ___VARIABLE_viperModuleName___WireFrame: NSObject,___VARIABLE_viperModuleName___WireFrameProtocol {
    class func initialWireFrame()-> UIViewController{
        let view = ___VARIABLE_viperModuleName___ViewController()
        let presenter = ___VARIABLE_viperModuleName___Presnter()
        let interactor = ___VARIABLE_viperModuleName___Interactor()
        let localDataManager = ___VARIABLE_viperModuleName___LocalDataManager()
        let APIDataManager = ___VARIABLE_viperModuleName___APIDataManager()
        let wireFrame = ___VARIABLE_viperModuleName___WireFrame()
        
        //connection
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        interactor.presenter = presenter
        interactor.localDataManager = localDataManager
        interactor.APIDataManager = APIDataManager
        
        return view
    }

}
