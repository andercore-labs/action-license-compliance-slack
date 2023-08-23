# Flexible Slack Notification

The Arazutech License Compliance Checker Slack Action helps you maintain license compliance by verifying the licenses of Python/Node dependencies in your projects. It automatically scans your dependencies and outputs to a Slack channel.

## Inputs

- slack_webhook_url (required): Slack webhook URL for sending notifications.
- allow_list (optional): Define a regex pattern for allowed licenses.
- block_list (optional): Set a regex pattern for blocked licenses.

## Example Usage

Ensure your repository contains the necessary secrets and variables before configuring the GitHub Action. Modify your workflow YAML file as follows:

```yaml
name: Flexible Slack License Notifications

on:
  push:
    branches: [ main ]
  pull_request:

jobs:
  notify-slack:
    runs-on: ubuntu-latest
    env:
      RUNTIME: 'python'
      ALLOW_LIST: ${{ vars.LICENSE_CHECK_REGEX_ALLOW_LIST }}
      BLOCK_LIST: ${{ vars.LICENSE_CHECK_REGEX_BLOCK_LIST }}
    steps:
       - name: License Check Slack
        uses: arazutech/action-slack-notification@v12
        with:
          runtime: ${{ env.RUNTIME }}
          slack_webhook_url: ${{ secrets.SLACK_WEBHOOK_URL }}
          allow_list: ${{ env.ALLOW_LIST }}
          block_list: ${{ env.BLOCK_LIST }}
        if: always()
```
This example workflow sets up the Slack Notification GitHub Action to run on push events to the main branch and on pull requests. Ensure that the necessary secrets (SLACK_WEBHOOK_URL) are properly configured in your repository settings.

## Workflow Steps

- Check if Slack webhook URL is provided: This step verifies if the Slack webhook URL is provided. If not provided, the notification is skipped.
- Download License Data: Downloads license data from an artifact if the data source is set to 'artifact'.
- Process Data from Different Sources: Processes the license data based on the data source input. The script used for formatting is 'slack_message_format.sh'.
- Notify on Restricted Licenses: Sends a notification to Slack if a Slack webhook URL is provided.

## License

This GitHub Action is licensed under the MIT License.


Please note that the above README assumes the existence of a script named `slack_message_format.sh` for processing and formatting license data. You should replace this with the appropriate script or code for processing license data based on your specific requirements. Additionally, make sure to replace placeholders like `arazutech/action-slack-notification@v10` with the actual reference to your GitHub Action in the GitHub Marketplace.
