import json
import os
import sys

metadata_filename = 'jetzt_metadata.json'
metadata = {}

dep_type = ''

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
    argv_count += 1

''' List installed packages from metadata. '''

if dep_type == 'PROD':
    if 'dependencies' in metadata:
        if isinstance(metadata['dependencies'], dict):
            for key, value in metadata['dependencies'].items():
                print(f"{key}{value}")
else:
    if 'dev_dependencies' in metadata:
        if isinstance(metadata['dev_dependencies'], dict):
            for key, value in metadata['dev_dependencies'].items():
                print(f"{key}{value}")
