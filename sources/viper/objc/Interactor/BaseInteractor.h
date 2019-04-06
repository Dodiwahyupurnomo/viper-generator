//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

#import <Foundation/Foundation.h>
#import "___VARIABLE_viperModuleName___Protocols.h"


@interface ___VARIABLE_viperModuleName___Interactor : NSObject <___VARIABLE_viperModuleName___InteractorInputProtocol>

@property (nonatomic, weak) id <___VARIABLE_viperModuleName___InteractorOutputProtocol> presenter;
@property (nonatomic, strong) id <___VARIABLE_viperModuleName___APIDataManagerInputProtocol> APIDataManager;
@property (nonatomic, strong) id <___VARIABLE_viperModuleName___LocalDataManagerInputProtocol> localDataManager;

@end