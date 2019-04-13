import json
import os
import re
import sys


def check_for_new(pip_list=None, requirement=None):
    package, version = re.split("==|>=", requirement)  # pipdeptree>=0.13.2

    for item in pip_list:
        if isinstance(item, dict):
            if package == item['name']:
                update = {
                    'package': package,
                    'installed_version': item['version'],
                    'latest_version': item['latest_version']
                }
                return f"{item['name']}: {item['version']} => {item['latest_version']}", update
        else:
            print("An error occured. JSON returned by pip is not valid.")
            return "Error", None

    return "Ok", None


def main():
    pip_json = sys.argv[1]
    dep_type = sys.argv[2]
    delete_pip_json = sys.argv[3]

    metadata_filename = 'jetzt_metadata.json'
    metadata = {}

    ''' Read existing metadata if available. '''
    if os.path.exists(metadata_filename):
        with open(metadata_filename) as metadata_file:
            metadata = json.load(metadata_file)

    ''' Read pip output in json format. '''
    if os.path.exists(pip_json):
        with open(pip_json) as json_file:
            data = json.load(json_file)
    else:
        sys.exit("Error occured, pip check failed. Did you run the command on project's home directory?")

    results = []
    updates = {}

    ''' Check against installed dependencies. '''
    if dep_type == 'PROD':
        dependencies = 'dependencies'
    else:
        dependencies = 'dev_dependencies'

    if dependencies in metadata:
        if isinstance(metadata[dependencies], dict):
            for key, value in metadata[dependencies].items():
                result, update = check_for_new(data, f"{key}{value}")
                results.append(result)
                if update is not None:
                    # update['required_for'] = dependencies
                    updates[update['package']] = update

    actionable_count = 0
    for result in results:
        if result != 'Ok':
            actionable_count += 1
            if actionable_count == 1:
                print("Dependency updates are available:")
            print(result)

    if actionable_count == 0:
        print("All dependencies are up to date.")
        if 'pending_dependency_updates' in metadata:
            metadata['pending_dependency_updates'][dependencies] = {}
    else:
        if 'pending_dependency_updates' not in metadata:
            metadata['pending_dependency_updates'] = {}
        metadata['pending_dependency_updates'][dependencies] = updates
        print('You can install the updates with "jetzt --update"')

    ''' Dump updated metadata. '''
    with open(metadata_filename, 'w') as dump:
        json.dump(metadata, dump, indent=2, ensure_ascii=False)

    if delete_pip_json == 'DeletePipJson':
        os.remove(pip_json)


if __name__ == '__main__':
    main()
