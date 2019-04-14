import json
import os
import sys

metadata_filename = 'jetzt_metadata.json'
metadata = {}

dep_type = ''
silent = False
force_version_pin = False

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
        elif key == 'silent':
            if value == 'YES':
                silent = True
        elif key == 'versionpin':
            if value == 'YES':
                force_version_pin = True
    argv_count += 1

''' List installed packages from metadata. '''

if dep_type == 'PROD':
    with open('requirements.txt', 'w') as f:
        if 'dependencies' in metadata:
            if isinstance(metadata['dependencies'], dict):
                for key, value in metadata['dependencies'].items():
                    if force_version_pin:
                        value = value.replace('>=', '==')
                    if not silent:
                        print(f"{key}{value}")
                    f.write(f"{key}{value}\n")
else:
    with open('requirements-dev.txt', 'w') as f:
        if 'dev_dependencies' in metadata:
            if isinstance(metadata['dev_dependencies'], dict):
                for key, value in metadata['dev_dependencies'].items():
                    if force_version_pin:
                        value = value.replace('>=', '==')
                    if not silent:
                        print(f"{key}{value}")
                    f.write(f"{key}{value}\n")
