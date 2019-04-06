//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

#import "___VARIABLE_viperModuleName___WireFrame.h"

@implementation ___VARIABLE_viperModuleName___WireFrame

+ (id)initialWireFrame
{
    // Generating module components
    ___VARIABLE_viperModuleName___ViewController *view = [[___VARIABLE_viperModuleName___ViewController alloc] initWithNibName:@"___VARIABLE_viperModuleName___" bundle:nil];
    ___VARIABLE_viperModuleName___Presenter *presenter = [___VARIABLE_viperModuleName___Presenter new];
    ___VARIABLE_viperModuleName___Interactor *interactor = [___VARIABLE_viperModuleName___Interactor new];
    ___VARIABLE_viperModuleName___APIDataManager *APIDataManager = [___VARIABLE_viperModuleName___APIDataManager new];
    ___VARIABLE_viperModuleName___LocalDataManager *localDataManager = [___VARIABLE_viperModuleName___LocalDataManager new];
    ___VARIABLE_viperModuleName___WireFrame *wireFrame= [___VARIABLE_viperModuleName___WireFrame new];
    
    // Connecting
    view.presenter = presenter;
    presenter.view = view;
    presenter.wireFrame = wireFrame;
    presenter.interactor = interactor;
    interactor.presenter = presenter;
    interactor.APIDataManager = APIDataManager;
    interactor.localDataManager = localDataManager;
    
    return view;
}

+ (void)present___VARIABLE_viperModuleName___ModuleFrom:(UIViewController*)fromViewController
{
    // Generating module components
    ___VARIABLE_viperModuleName___ViewController *view = [[___VARIABLE_viperModuleName___ViewController alloc] init];
    ___VARIABLE_viperModuleName___Presenter *presenter = [___VARIABLE_viperModuleName___Presenter new];
    ___VARIABLE_viperModuleName___Interactor *interactor = [___VARIABLE_viperModuleName___Interactor new];
    ___VARIABLE_viperModuleName___APIDataManager *APIDataManager = [___VARIABLE_viperModuleName___APIDataManager new];
    ___VARIABLE_viperModuleName___LocalDataManager *localDataManager = [___VARIABLE_viperModuleName___LocalDataManager new];
    ___VARIABLE_viperModuleName___WireFrame *wireFrame= [___VARIABLE_viperModuleName___WireFrame new];
    
    // Connecting
    view.presenter = presenter;
    presenter.view = view;
    presenter.wireFrame = wireFrame;
    presenter.interactor = interactor;
    interactor.presenter = presenter;
    interactor.APIDataManager = APIDataManager;
    interactor.localDataManager = localDataManager;
    
    //TOODO - New view controller presentation (present, push, pop, .. )
}

@end
