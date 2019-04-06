//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit

protocol ___VARIABLE_viperModuleName___ViewProtocol: class {
    var presenter : ___VARIABLE_viperModuleName___PresenterProtocol? {get set}
    //Add here your method to communication PRESENTER -> ViewControler

}

protocol ___VARIABLE_viperModuleName___WireFrameProtocol:class {
    //Add here your methods for communication PRESENTER -> WIREFRAME

}

protocol ___VARIABLE_viperModuleName___PresenterProtocol: class {
    var view : ___VARIABLE_viperModuleName___ViewProtocol? {get set}
    var interactor : ___VARIABLE_viperModuleName___InteractorInputProtocol? {get set}
    var wireFrame : ___VARIABLE_viperModuleName___WireFrameProtocol? {get set}
    //Add here your methods to communication VIEWCONTROLLER -> Presenter

}

protocol ___VARIABLE_viperModuleName___InteractorOutputProtocol: class {
    //Add here your methods to communication INTERACTOR -> Presenter
}

protocol ___VARIABLE_viperModuleName___InteractorInputProtocol: class {
    var presenter : ___VARIABLE_viperModuleName___InteractorOutputProtocol? {get set}
    var APIDataManager : ___VARIABLE_viperModuleName___APIDataManagerInputProtocol? {get set}
    var localDataManager : ___VARIABLE_viperModuleName___LocalDataManagerInputProtocol? {get set}
    //Add here your method to communication PRESENTER -> Interactor
}

protocol ___VARIABLE_viperModuleName___DataManagerInputProtocol: class {
    //Add here your method to comminication INTERACTOR -> DataManager
}

protocol ___VARIABLE_viperModuleName___APIDataManagerInputProtocol: ___VARIABLE_viperModuleName___DataManagerInputProtocol {
    //Add here your methods to communication INTERACTOR -> APIDataManager
}

protocol ___VARIABLE_viperModuleName___LocalDataManagerInputProtocol: ___VARIABLE_viperModuleName___DataManagerInputProtocol {
    //Add here your methods to communication INERACTOR -> LocalDataManager
}
