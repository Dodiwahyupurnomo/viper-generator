#!/usr/bin/env python3

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


import re
from project_template_generator.template_builder import TemplateBuilder


def help(): 
    print('Usage:')
    print('quit \t\t-To quit installations')
    print('install \t-To start installations')
    print('help \t\t-To show guide')
    pass

def strat_installation(listenner):
    if len(listenner) > 1 and listenner[1] != None and len(listenner[1]) > 3 and re.match("[a-zA-Z]+",str(listenner[1])):
        template_builder = TemplateBuilder(str(listenner[1]))
        template_builder.create()
    else:
        print('Please enter your template group name. The template group name must be more than 3 characters and only alphabetical characters.')

while (True): 
    listenner = input('Template generator -> $ ').split()
    if len(listenner) > 0 and listenner[0] != None and listenner[0] != '':
        if listenner[0] == 'install':
            strat_installation(listenner)
        elif listenner[0] == 'help':
            help()
        elif listenner[0] ==  'quit':
            break
        else: 
            help()
    else:
        help()
    pass