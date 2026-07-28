name: Final Release
on: workflow_dispatch
jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - run: echo 'Build, test, sign and publish release'