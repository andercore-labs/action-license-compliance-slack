# License Compliance Check to Slack

The Arazutech License Compliance Checker Slack Action helps you maintain license compliance by verifying the licenses of Python/Node dependencies in your projects. It automatically scans your dependencies and outputs to a Slack channel.

## Inputs

- slack_webhook_url (required): Slack webhook URL for sending notifications.
- allow_list (optional): Define a regex pattern for allowed licenses.
- block_list (optional): Set a regex pattern for blocked licenses.
- python_version (optional): Specify the Python version. Default: `3.10`.
- node_version (optional): Specify the Node.js version. Default: `18`.

## Example Usage

Ensure your repository contains the necessary secrets and variables before configuring the GitHub Action. Modify your workflow YAML file as follows:

```yaml
name: License Compliance Check to Slack

on:
  push:
    branches: [ main ]
  pull_request:

jobs:
  license-slack:
    runs-on: ubuntu-latest
    env:
      RUNTIME: 'python'
      ALLOW_LIST: ${{ vars.LICENSE_CHECK_REGEX_ALLOW_LIST }}
      BLOCK_LIST: ${{ vars.LICENSE_CHECK_REGEX_BLOCK_LIST }}
    steps:
       - name: License Compliance Check to Slack
        uses: arazutech/action-slack-notification@v12
        with:
          runtime: ${{ env.RUNTIME }}
          slack_webhook_url: ${{ secrets.SLACK_WEBHOOK_URL }}
          allow_list: ${{ env.ALLOW_LIST }}
          block_list: ${{ env.BLOCK_LIST }}
          python_version: '3.9'
        if: always()
```
This example workflow sets up the Arazutech License Compliance Checker GitHub Action to run on push events to the main branch and on pull requests. Ensure that the necessary secrets and variables (SLACK_WEBHOOK_URL, REGEX_ALLOW_LIST, and REGEX_BLOCK_LIST) are properly configured in your repository settings.

## License

This GitHub Action is licensed under the MIT License.
