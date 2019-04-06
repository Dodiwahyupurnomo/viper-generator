//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ___VARIABLE_viperModuleName___InteractorOutputProtocol;
@protocol ___VARIABLE_viperModuleName___InteractorInputProtocol;
@protocol ___VARIABLE_viperModuleName___ViewProtocol;
@protocol ___VARIABLE_viperModuleName___PresenterProtocol;
@protocol ___VARIABLE_viperModuleName___LocalDataManagerInputProtocol;
@protocol ___VARIABLE_viperModuleName___APIDataManagerInputProtocol;


@class ___VARIABLE_viperModuleName___WireFrame;

@protocol ___VARIABLE_viperModuleName___ViewProtocol
@required
@property (nonatomic, strong) id <___VARIABLE_viperModuleName___PresenterProtocol> presenter;
/**
 * Add here your methods for communication PRESENTER -> VIEWCONTROLLER
 */
@end

@protocol ___VARIABLE_viperModuleName___WireFrameProtocol
@required
+ (id)initialWireFrame;
+ (void)present___VARIABLE_viperModuleName___ModuleFrom:(id)fromView;
/**
 * Add here your methods for communication PRESENTER -> WIREFRAME
 */
@end

@protocol ___VARIABLE_viperModuleName___PresenterProtocol
@required
@property (nonatomic, weak) id <___VARIABLE_viperModuleName___ViewProtocol> view;
@property (nonatomic, strong) id <___VARIABLE_viperModuleName___InteractorInputProtocol> interactor;
@property (nonatomic, strong) id <___VARIABLE_viperModuleName___WireFrameProtocol> wireFrame;
/**
 * Add here your methods for communication VIEWCONTROLLER -> PRESENTER
 */
@end

@protocol ___VARIABLE_viperModuleName___InteractorOutputProtocol
/**
 * Add here your methods for communication INTERACTOR -> PRESENTER
 */
@end

@protocol ___VARIABLE_viperModuleName___InteractorInputProtocol
@required
@property (nonatomic, weak) id <___VARIABLE_viperModuleName___InteractorOutputProtocol> presenter;
@property (nonatomic, strong) id <___VARIABLE_viperModuleName___APIDataManagerInputProtocol> APIDataManager;
@property (nonatomic, strong) id <___VARIABLE_viperModuleName___LocalDataManagerInputProtocol> localDataManager;
/**
 * Add here your methods for communication PRESENTER -> INTERACTOR
 */
@end

@protocol ___VARIABLE_viperModuleName___DataManagerInputProtocol
/**
 * Add here your methods for communication INTERACTOR -> DATAMANAGER
 */
@end

@protocol ___VARIABLE_viperModuleName___APIDataManagerInputProtocol <___VARIABLE_viperModuleName___DataManagerInputProtocol>
/**
 * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
 */
@end

@protocol ___VARIABLE_viperModuleName___LocalDataManagerInputProtocol <___VARIABLE_viperModuleName___DataManagerInputProtocol>
/**
 * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
 */
@end


