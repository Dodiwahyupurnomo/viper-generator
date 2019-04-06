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
import sys
import shutil
from subprocess import call
sys.path.append(os.path.join(os.path.dirname(__file__),'../') + 'lib/')
from plistlib import dump
from .template_plist_generator import TemplatePlistGenerator

class TemplateBuilder: 
    _project_template_path = ''
    _group_name = ''

    def __init__(self,name):
        self._group_name = name

        project_template_root_path = os.path.expanduser('~/Library/Developer/Xcode/Templates/Project Templates/')
        self._project_template_path = os.path.join(project_template_root_path,name)

    def create(self):
        template_file_path = os.path.join(self._project_template_path,'Single App.xctemplate/')
        root_path = os.path.abspath(os.path.join(os.path.dirname(__file__),'../'))
        assets_path = root_path + '/assets/'
        module_path = root_path + '/sources/viper/'
        common_path = root_path + '/sources/app/common/'
        models_path = root_path + '/sources/app/models/'

        if os.path.exists(template_file_path):
            listtener = input('Current directory template already exists, are you sure to replace (y/n) :')
            while (True):
                if listtener == 'y':
                    break
                elif listtener == 'n':
                    return
                else:
                    self.create()
                    return

        print('Executing...')
        # copying files 
        # copy assets icon 
        path_assets_icon = os.path.join(assets_path,'template_icon/')
        for root, _, files in os.walk(path_assets_icon):
            for file in files:
                src_path = os.path.join(root,file)
                self._copy(src_path,template_file_path)
        
        # copying modules 
        for root, _, files in os.walk(module_path):
            for file in files:
                src_path = os.path.join(root,file)
                dst_path = os.path.join(template_file_path,'module',src_path.replace(module_path,'')).replace(file,'')
                self._copy(src_path,dst_path)
        
        # copying common 
        for root, _, files in os.walk(common_path):
            for file in files:
                src_path = os.path.join(root,file)
                dst_path = os.path.join(template_file_path,'common',src_path.replace(common_path,'')).replace(file,'')
                self._copy(src_path,dst_path)
        
        # copying models 
        for root, _, files in os.walk(models_path):
            for file in files:
                src_path = os.path.join(root,file)
                dst_path = os.path.join(template_file_path,'models',src_path.replace(models_path,'')).replace(file,'')
                self._copy(src_path,dst_path)
        
        # generate xml plist 
        plist_generator = TemplatePlistGenerator(self._group_name)
        xml_plist = plist_generator.xml_prbuild

        # create plist 
        plist_path = os.path.join(template_file_path,'TemplateInfo.plist')
        if not os.path.exists(plist_path):
            open(plist_path,'a').close()
            
        with open(plist_path,'wb') as fp:
            dump(xml_plist,fp)
            pass

        print('Template installed successfully.')
    
    def _copy(self,src,dest):
        if not os.path.exists(dest):
            os.makedirs(dest)

        try:
            shutil.copy2(src,dest)  
        except shutil.Error as e:
            print('Failed to copy {} with error message {}'.format(src,e))      
        except OSError as e:
            print('Failed to copy {} with error message {}'.format(src,e))
        