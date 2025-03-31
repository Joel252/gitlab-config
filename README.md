# GitLab CE + Runner with Docker compose

This project offers a ready to deploy configuration for **GitLab Community Edition** alongside a **GitLab Runner** in Docker containers using docker-compose. Ideal for development environments, CI/CD testing, or local deployments.

Key features:

- **Preconfigured GitLab CE** (web, SSH, registries).
- **Customizable runner** (docker, shell, tags, etc.).
- **Easy configuration** (editable variables in .env).
- **Data persistence** (Docker volumes)
- **One-command execution** (docker-compose up -d).

![overview](images/overview.png)

## Getting Started

### Requirements

#### System requirements

- **Docker + Docker compose**.
- **4 GB of RAM minimun** (recommended 8 GB).
- **2 CPU cores** (recommended 4+ cores).
- **20 GB of storage** (for persistent data).

#### Necessary ports

- `80`: HTTP.
- `443`: HTTPS.
- `22`: SSH.
- `5050`: Auxiliar services (e.g. GitLab Registry).

#### Other requirements

- **Local domain or DNS**: For web access (localhost can be used in development).
- **SMTP server** (Only if you need to send notifications).
- **SSL certificate** (Only if you use HTTPS).

### How to run it?

1. **Clone the repository**, enter the following commands to clone the repository and access the directory that contains the files with the configurations needed to run the service.

   ```bash
   git clone https://Joel252/gitlab-config.git
   cd gitlab-config/
   ```

2. **Create the `.env` file with your settings**.

3. Use **Docker Compose to build the containers** specified in the `docker-compose.yml` file.

   ```bash
   docker compose up -d
   ```

> [!note]
> Once the container is running, you can check the status of the services using `docker container ps`.

### Access to GitLab

When the container is running, access to GitLab using the URL specified in `external_url option` in the **gitlab.rb** file, for example: <https://git.example.com>.

Now, login using the credentials specified in `gitlab_rails['initial_root_password']` option in the previous file.

---

- For more information about the process to setup GitLab, see the [Install GitLab documentation](https://docs.gitlab.com/ee/install/aws/).
- For more information about the GitLab autoscale, see the [GitLab Runner Autoscaling](https://docs.gitlab.com/runner/runner_autoscale/).
- To know more about GitLab runner commands, see [GitLab Runner](https://docs.gitlab.com/runner/commands/).
- See [Install GitLab in Docker container](https://docs.gitlab.com/ee/install/docker/) to know more about the steps to install GitLab in a docker container.
- See [Managing PostgreSQL extensions](https://docs.gitlab.com/ee/install/postgresql_extensions.html) to know how to manage PostgreSQL extensions.
- For more information about the object store, see [Object storage](https://docs.gitlab.com/ee/administration/object_storage.html).
