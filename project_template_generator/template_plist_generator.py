#  Copyright 2019 Dodi Wahyu Purnomo
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.


import os
import os.path

class TemplatePlistGenerator: 
    _template_name = ''
    _template_identifier = 'com.duoblack.dt.unit.manual.singleViewApplication'
    _template_description = 'This template provides a starting point for an application that uses a single view. It provides a view controller to manage the view. The app delegate create the main window and root view controller (no Storyboard).'

    _module_identifier = 'viperModuleName'
    _value_module_identifier = '___VARIABLE_viperModuleName___'
    xml_prbuild = dict()

    _objc_files = dict()
    _swift_files = dict()

    
    def __init__(self,name): 
        self._template_name = name 

        # scan all files in template viper 
        module_dir = 'Classes/Modules/Default'
        objc_dir = os.path.join(os.path.dirname(__file__),'../') + 'sources/viper/objc/'
        self._scan_objc_sources(objc_dir,module_dir,'module/objc/')

        swift_dir = os.path.join(os.path.dirname(__file__),'../') + 'sources/viper/swift/'
        self._scan_swift_sources(swift_dir,module_dir,'module/swift/')
        
        # scan all common files
        common_dir = 'Classes/Common'
        common_objc_dir = os.path.join(os.path.dirname(__file__),'../') + 'sources/app/common/objc/'
        self._scan_objc_sources(common_objc_dir,common_dir,'common/objc/')

        common_swift_dir = os.path.join(os.path.dirname(__file__),'../') + 'sources/app/common/swift/'
        self._scan_swift_sources(common_swift_dir,common_dir,'common/swift/')
        
        # scan all model files 
        models_dir = 'Classes/Models'
        models_objc_dir = os.path.join(os.path.dirname(__file__),'../') + 'sources/app/models/objc/'
        self._scan_objc_sources(models_objc_dir,models_dir,'models/objc/')

        models_swift_dir = os.path.join(os.path.dirname(__file__),'../') + 'sources/app/models/swift/'
        self._scan_swift_sources(models_swift_dir,models_dir,'models/swift/')

        # start create xml 
        self._create_header()
        self._create_option()
        self._create_definition()
    
    def _scan_objc_sources(self,walk_dir,group_key,group_path):
        for root, _, files in os.walk(walk_dir):
            for file in files: 
                if file.endswith('.h') or file.endswith('.m') or file.endswith('.xib'):
                    dir_path = root.replace(walk_dir,'')
                    filename = os.path.join(group_key,dir_path,file.replace('Base',self._value_module_identifier)) 
                    self._objc_files[os.path.join(group_path,dir_path,file)] = filename
                    
    def _scan_swift_sources(self,walk_dir,group_key,group_path):
        for root, _, files in os.walk(walk_dir):
            for file in files: 
                if file.endswith(".swift") or file.endswith('.xib'):
                    dir_path = root.replace(walk_dir,'')
                    filename = os.path.join(group_key,dir_path,file.replace('Base',self._value_module_identifier))  
                    self._swift_files[os.path.join(group_path,dir_path,file)] = filename
                    
    def _create_header(self):
        self.xml_prbuild = dict(
            CFBundleIdentifier = '',
            Kind = 'Xcode.Xcode3.ProjectTemplateUnitKind',
            Identifier = self._template_identifier,
            Ancestors = ['com.apple.dt.unit.cocoaTouchApplicationBase',
                'com.apple.dt.unit.coreDataCocoaTouchApplication'],
            Concrete = True,
            Description = self._template_description,
            SortOrder = 1
        )
    
    def _create_option(self): 
        options = []
        # generate option
        self._main_options(options)
        self._language_options(options)
        self._navigation_option(options)
        # save options
        self.xml_prbuild['Options'] = options

    def _main_options(self,options = []):
        main = dict(
            Identifier = self._module_identifier,
            Required = True,
            Name = 'Base Module Name:',
            Description = 'The base VIPER module name',
            Type = 'text',
            Default = 'Dashboard'
        )
        options.append(main)
        return options
    
    def _language_options(self,options = []):
        objc_files = []
        for value in self._objc_files.values(): 
            objc_files.append(value)
        
        swift_files = []
        for value in self._swift_files.values():
            swift_files.append(value)

        units = dict()
        units['Objective-C'] = dict(Nodes = objc_files)
        units['Swift'] = dict(Nodes = swift_files)
        language_opt = dict(
            Identifier = 'languageChoice',
            Units = units
        )
        options.append(language_opt)
        return options
    
    def _navigation_option(self,options = []):
        nav_opt = dict()
        nav_opt['Identifier'] = 'navigationController'
        nav_opt['Name'] = 'Embed in Navigation Controller'
        nav_opt['Description'] = 'Is the root view controller embedded in a navigation controller'
        nav_opt['Type'] = 'checkbox'
        nav_opt['Default'] = False

        nav_opt_false = []
        nav_opt_true = []
        self.__navigation_option_false(nav_opt_false)
        self.__navigation_option_true(nav_opt_true)
        nav_opt['Units'] = dict(false = nav_opt_false,true = nav_opt_true)

        options.append(nav_opt)
        return options

    def __navigation_option_false(self,options = []):
        value_opt = dict()
        value_opt['RequiredOptions'] = dict(languageChoice = 'Objective-C')
        value_opt['Definitions'] = {'AppDelegate.m:implementation:methods:applicationdidFinishLaunchingWithOptions:body':
        """self.window = [[UIWindow alloc] initWithFrame:[UIScreen.mainScreen bounds]];
self.window.backgroundColor = UIColor.whiteColor;
self.window.rootViewController = [{}WireFrame initialWireFrame];
[self.window makeKeyAndVisible];""".format(self._value_module_identifier)}
        value_opt['RequiredOptions'] = dict(languageChoice = 'Swift')
        value_opt['Definitions'] = {'AppDelegate.swift:implementation:methods:applicationdidFinishLaunchingWithOptions:body':
        """window = UIWindow(frame: UIScreen.main.bounds)
window?.backgroundColor = .white
window?.rootViewController = {}WireFrame.initialWireFrame()
window?.makeKeyAndVisible()""".format(self._value_module_identifier)}

        options.append(value_opt)
        return options

    def __navigation_option_true(self,options = []):
        value_opt = dict()
        value_opt['RequiredOptions'] = dict(languageChoice = 'Objective-C')
        value_opt['Definitions'] = {'AppDelegate.m:implementation:methods:applicationdidFinishLaunchingWithOptions:body':
        """self.window = [[UIWindow alloc] initWithFrame:[UIScreen.mainScreen bounds]];
self.window.backgroundColor = UIColor.whiteColor;
{}ViewController *rootViewController = [{}WireFrame initialWireFrame];
UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
self.window.rootViewController = navigationController;
[self.window makeKeyAndVisible];""".format(self._value_module_identifier,self._value_module_identifier)}
        value_opt['RequiredOptions'] = dict(languageChoice = 'Swift')
        value_opt['Definitions'] = {'AppDelegate.swift:implementation:methods:applicationdidFinishLaunchingWithOptions:body':
        """window = UIWindow(frame: UIScreen.main.bounds)
window?.backgroundColor = .white
let rootViewController = {}WireFrame.initialWireFrame()
let navigationController = UINavigationController(rootViewController: rootViewController)
window?.rootViewController = navigationController
window?.makeKeyAndVisible()""".format(self._value_module_identifier)}

        options.append(value_opt)
        return options

    def _create_definition(self):
        definitions = dict()
        definitions['*:implementation:methods:applicationWillResignActive:comments'] = """//Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
//Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game."""
        definitions['*:implementation:methods:applicationDidEnterBackground:comments'] = """//Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
//If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits."""
        definitions['*:implementation:methods:applicationWillEnterForeground:comments'] = '//Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.'
        definitions['*:implementation:methods:applicationDidBecomeActive:comments'] = '//Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.'
        definitions['*:implementation:methods:applicationWillTerminate:comments'] = """//Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//Saves changes in the application's managed object context before the application terminates."""

        # create  group 
        self.__create_definision_module(definitions,self._objc_files)
        self.__create_definision_module(definitions,self._swift_files)
        self.xml_prbuild['Definitions'] = definitions


    def __create_definision_module(self,definisions = {},object_dict = None):
        if object_dict != None: 
            for key, value in object_dict.items(): 
                dict_def = dict()
                group = str(value).split('/')
                if len(group) > 1:
                    dict_def['Group'] = group[:-1] 
                
                dict_def['Path'] = key
                
                definisions[value] = dict_def
    