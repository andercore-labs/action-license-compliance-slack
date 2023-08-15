# Flexible Slack Notification

The Flexible Slack Notification GitHub Action allows you to construct and send Slack notifications based on license information from different data sources. It provides flexibility in handling license data in various formats and sending notifications via Slack webhooks.

## Inputs

- slack_webhook_url (required): Slack webhook URL for sending notifications.
- data_source (required): Data source for license information (artifact, csv, json).
- artifact_name (optional): Name of the artifact containing license data (default: 'invalid.csv').

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
    steps:
      - name: Flexible Slack Notification
        uses: arazutech/action-slack-notification@v10
        with:
          slack_webhook_url: ${{ secrets.SLACK_WEBHOOK_URL }}
          data_source: 'csv'
        if: always()
```
This example workflow sets up the Flexible Slack Notification GitHub Action to run on push events to the main branch and on pull requests. Ensure that the necessary secrets (SLACK_WEBHOOK_URL) are properly configured in your repository settings.

## Workflow Steps

- Check if Slack webhook URL is provided: This step verifies if the Slack webhook URL is provided. If not provided, the notification is skipped.
- Download License Data: Downloads license data from an artifact if the data source is set to 'artifact'.
- Process Data from Different Sources: Processes the license data based on the data source input. The script used for formatting is 'slack_message_format.sh'.
- Notify on Restricted Licenses: Sends a notification to Slack if a Slack webhook URL is provided.

## License

This GitHub Action is licensed under the MIT License.


Please note that the above README assumes the existence of a script named `slack_message_format.sh` for processing and formatting license data. You should replace this with the appropriate script or code for processing license data based on your specific requirements. Additionally, make sure to replace placeholders like `arazutech/action-slack-notification@v10` with the actual reference to your GitHub Action in the GitHub Marketplace.
