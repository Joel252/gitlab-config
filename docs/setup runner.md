# Setup Runners

Setting up **Runners in GitLAb** allows you to run CI/CD pipelines on your own servers or machines.

## Getting start

Before setting up a Runner, you can view the necessary information directly in GitLab:

- **For shared Runners**: `Admin > CI/CD > Runners`
- **For specific project Runner**: `Project > Setting > CI/CD > Runners`

### In Linux

1. In both settings, you can open the option `Show runner installation and registration instructions` to get the following commands and the registration token.

   ```bash
   # Download the binary for your system
   sudo curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64

   # Give it permission to execute
   sudo chmod +x /usr/local/bin/gitlab-runner

   # Create a GitLab Runner user
   sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash

   # Install and run as a service
   sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
   sudo gitlab-runner start

   # If using a `deb` package based distribution
   curl -s https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
   apt install -y gitlab-runner

   # If using an `rpm` package based distribution
   curl -s https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.rpm.sh | sudo bash
   dnf install -y gitlab-runner
   ```

   > [!note]
   > Install docker and git before entering the commands to register the runner.

2. After configuring the Runners, in GitLab, open the Runners section of the panel to display the configuration for all Runners and their statuses.

## Updgrade GitLab Runner

To install the latest version of GitLab Runner use the following commands:

```bash
sudo apt update
sudo apt install -y gitlab-runner
```

---

- For more information about the process to setup Runners, see the [Install GitLab Runner documentation](https://docs.gitlab.com/runner/install/).
- See [Executors](https://docs.gitlab.com/runner/executors/) to know more about the types of executors and their functions.
