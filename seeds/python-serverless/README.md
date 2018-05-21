# New Serverless project

This scaffold is for a Serverless project with Python 3.6 runtime in AWS.

## Prerequisites

You should have the following installed for this to work.

1. Python 3.6+
2. Node.js v8+
3. Docker

## How to use

After scaffolding, do the following.

### Edit code

Time to edit `handler.py`. For example:

1. Import requests
2. Use requests

```
r = requests.get('https://koodimaa.com')
response = f"{r.status_code}\n{r.text}"
print(response)
```

## Install new requirements

Install requests with jep:
`jep install requests`

## Test the app locally

Run:
`python handler.py`

... which should return response as expected.

## Prepare for deployment

Edit `serverless.yml` as needed. At least check the following:

1. stage: [Stage to deploy]
2. region: [AWS Region to deploy]
3. stackTags: [Tag your resources]
4. service: [Service Name]
5. testFunction: [Function name]

*Note 1:*

Serverless uses `dev` as the default stage and `us-east-1` as the default region.

*Note 2:*

Exclude unnecessary files, for example:

```
package:
  exclude:
    - README.md
    - requirements-dev.txt
    - .vscode
```
## Deploy to AWS

Run to deploy (and update) the service:

`serverless deploy`

## Test the function

Run to test the function:

`serverless invoke -f testFunction --log`


## Remove the service

In the project directory, run:

`serverless remove`


## Install development dependencies

For example, install `flake8` (already installed):

`jep install flake8 --dev`

The development dependencies are added to their own requirements file `requirements-dev.txt`. This way the dev dependencies won't be installed to Lambda, as they are not needed there.

## Maintenance

Check for updates to this tool from time to time.

Also pull the latest Docker build image  with
`docker pull lambci/lambda:build-python3.6`

## Miscellaneous

[The Serverless Python Requirements plugin](https://www.npmjs.com/package/serverless-python-requirements)

