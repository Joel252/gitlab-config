# GitLab CE + Runner with Docker compose

Easily deploy **GitLab Community Edition** and **GitLab Runner** using Docker Compose. This project is designed to be user-friendly and customizable, offering the following benefits:

- A preconfigured GitLab CE instance with web, SSH, and container registry services.
- A flexible GitLab Runner setup supporting Docker and shell executors.
- Easy configuration via a `.env` file.
- Persistent data storage using Docker volumes.
- Quick deployment with a single command: `docker-compose up -d`.

![overview](images/overview.png)

## Requirements

Before starting, ensure your system meets the following requirements:

### System Requirements

| **Component** | **Minimum**        | **Recommended**      |
|---------------|--------------------|----------------------|
| **RAM**       | 4 GB               | 8 GB                 |
| **CPU**       | 2 cores            | 4+ cores             |
| **Storage**   | 20 GB              | 50+ GB               |

### Network Requirements

| **Port** | **Purpose**           |
|----------|-----------------------|
| `80`     | HTTP                  |
| `443`    | HTTPS                 |
| `22`     | SSH                   |
| `5050`   | GitLab Registry       |

> [!note]
> **Local Domain or DNS**: Required for web access (use `localhost` for development).

### Optional Requirements

- **SMTP Server**: For email notifications.
- **SSL Certificate**: For HTTPS.

## How to run it?

1. Run the following commands to clone the repository and navigate to the project directory:

   ```bash
   git clone https://Joel252/gitlab-config.git
   cd gitlab-config/
   ```

2. Create the `.env` file with your settings.

3. Use Docker Compose to build and start the containers:

   ```bash
   docker compose up -d
   ```

   > Check the status of the services using `docker container ps`.

4. Once the containers are running, acces GitLab using the URL
specified in `GITLAB_EXTERNAL_URL`. For example: <https://git.example.com>.

> [!note]
> The initial user is `root`, and the password is automatically generated. To obtain it, run: `docker exec -it gitlab-ce grep 'Password:' /etc/gitlab/initial_root_password`.
> Remember to change this **root password** immediately after logging in to avoid security issues.
> You also need to reset the runners' **register token**.

---

## Additional information

- [Install GitLab documentation](https://docs.gitlab.com/ee/install/aws/)
- [GitLab Runner Autoscaling](https://docs.gitlab.com/runner/runner_autoscale/)
- [GitLab Runner](https://docs.gitlab.com/runner/commands/)
- [Install GitLab in Docker container](https://docs.gitlab.com/ee/install/docker/)
- [Managing PostgreSQL extensions](https://docs.gitlab.com/ee/install/postgresql_extensions.html)
- [Object storage](https://docs.gitlab.com/ee/administration/object_storage.html)
