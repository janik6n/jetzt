import json
import os
import re
import sys

metadata_filename = 'jetzt_metadata.json'
metadata = {}

dep_type = 'PROD'
package = ''
package_with_version = ''

''' Read existing metadata if available. '''
if os.path.exists(metadata_filename):
    with open(metadata_filename) as metadata_file:
        metadata = json.load(metadata_file)

argv_count = 0
for arg in sys.argv:
    if argv_count > 0:
        key, value = arg.split('___')
        if key == 'dep_type':
            dep_type = value
        elif key == 'package':
            package = value
        elif key == 'package_with_version':
            package_with_version = value
        else:
            metadata[key] = value
    argv_count += 1

''' Installing a new dependency. '''
if package != '':
    installed_package, installed_version = re.split("==|>=", package_with_version)  # package==0.13.2
    # Pinned version
    if '==' in package:
        installed_version = f"=={installed_version}"
    else:
        installed_version = f">={installed_version}"

    if dep_type == 'PROD':
        if 'dependencies' in metadata:
            if isinstance(metadata['dependencies'], dict):
                metadata['dependencies'][installed_package] = installed_version
        else:
            metadata['dependencies'] = {}
            metadata['dependencies'][installed_package] = installed_version
    else:
        if 'dev_dependencies' in metadata:
            if isinstance(metadata['dev_dependencies'], dict):
                metadata['dev_dependencies'][installed_package] = installed_version
        else:
            metadata['dev_dependencies'] = {}
            metadata['dev_dependencies'][installed_package] = installed_version

''' Dump updated metadata. '''
with open(metadata_filename, 'w') as dump:
    json.dump(metadata, dump, indent=2, ensure_ascii=False)
