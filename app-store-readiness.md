name: Release Placeholder
on: workflow_dispatch
jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - run: echo 'Configure production release pipeline'