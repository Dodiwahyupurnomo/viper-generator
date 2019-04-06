//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

#import <Foundation/Foundation.h>
#import "___VARIABLE_viperModuleName___Protocols.h"

@class ___VARIABLE_viperModuleName___WireFrame;

@interface ___VARIABLE_viperModuleName___Presenter : NSObject <___VARIABLE_viperModuleName___PresenterProtocol, ___VARIABLE_viperModuleName___InteractorOutputProtocol>

@property (nonatomic, weak) id <___VARIABLE_viperModuleName___ViewProtocol> view;
@property (nonatomic, strong) id <___VARIABLE_viperModuleName___InteractorInputProtocol> interactor;
@property (nonatomic, strong) id <___VARIABLE_viperModuleName___WireFrameProtocol> wireFrame;

@end
