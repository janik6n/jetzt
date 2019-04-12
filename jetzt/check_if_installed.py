import json
import os
import re
import sys

metadata_filename = 'jetzt_metadata.json'
metadata = {}

dep_type = ''
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
    argv_count += 1

''' Check, if the needed package is found in metadata. '''

package_parts = re.split("==|>=", package)  # package or package==0.13.2

package_parts[0] = package_parts[0].strip()

if dep_type == 'PROD':
    if 'dependencies' in metadata:
        if isinstance(metadata['dependencies'], dict):
            if package_parts[0] in metadata['dependencies']:
                # Package found.
                sys.exit(0)
            else:
                sys.exit(1)
else:
    if 'dev_dependencies' in metadata:
        if isinstance(metadata['dev_dependencies'], dict):
            if package_parts[0] in metadata['dev_dependencies']:
                # Package found.
                sys.exit(0)
            else:
                sys.exit(1)

# By default, the package is not found.
sys.exit(1)
