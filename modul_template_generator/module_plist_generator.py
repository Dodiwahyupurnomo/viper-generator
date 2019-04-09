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

class ModulePlistGenerator: 
    module_name = ''
    xml_prebuild = dict()

    def __init__(self,name):
        self.module_name = name
    

    def _create_header(self): 
        self.xml_prebuild = dict(Kind = 'Xcode.IDEFoundation.TextSubstitutionFileTemplateKind',
            Description = 'Viper module',
            Summary = 'A viper module',
            SortOrder = 1,
            
        )
    #     <key>Kind</key>
	# <string>Xcode.IDEFoundation.TextSubstitutionFileTemplateKind</string>
	# <key>Description</key>
	# <string>A Cocoa class.</string>
	# <key>Summary</key>
	# <string>A Cocoa class</string>
	# <key>SortOrder</key>
	# <string>1</string>
	# <key>DefaultCompletionName</key>
	# <string>MyClass</string>
	# <key>Platforms</key>
	# <array>
	# 	<string>com.apple.platform.macosx</string>
	# </array>
