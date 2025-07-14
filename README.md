# GitLab CE + Runner with Docker compose

Easily deploy **GitLab Community Edition** and **GitLab Runner** using Docker Compose. This project is designed to be user-friendly and customizable, offering the following benefits:

- A preconfigured GitLab CE instance.
- A flexible GitLab Runner setup supporting Docker and shell executors.
- Easy configuration via a `.env` file.
- Persistent data storage using Docker volumes.
- Quick deployment with a single command: `docker-compose up -d`.

![overview](images/overview.png)

## Requirements

You must have [Docker and Docker Compose](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository) installed and running on your system.

Ensure your system meets the following requirements:

| **Component** | **Minimum**        | **Recommended**      |
|---------------|--------------------|----------------------|
| **RAM**       | 4 GB               | 8+ GB                |
| **CPU**       | 2 cores            | 4+ cores             |
| **Storage**   | 20 GB              | 50+ GB               |

If you are using a firewall, ensure to allow traffic for these ports:

| **Port** | **Purpose**           |
|----------|-----------------------|
| `80`     | HTTP                  |
| `443`    | HTTPS                 |
| `22`     | SSH                   |
| `8443`   | GitLab Registry       |

## How to run it?

Before you begin, clone the repository and navigate to the project directory:

```bash
git clone https://github.com/Joel252/gitlab-config.git

cd gitlab-config/
```

Now, follow the steps for both GitLab and Runner:

1. Navigate to the resource (`gitlab` or `runner`) directory.

2. Create the `.env` file base on `.env.example` file and replace the values with your own settings.

3. Use Docker Compose to build and start the container:

   ```bash
   docker compose up -d
   ```

   > Verify the status of the services using `docker container ps`.

4. In the case of Gitlab, you access GitLab using the URL specified in `GITLAB_URL` variable. For example: <https://git.example.com>.

   For the Runner, go to the CI/CD section of the admin panel and verify that it has been successfully registered.

> [!note]
> The initial user is `root`, and the password is automatically generated. To obtain it, run: `docker exec -it gitlab-ce grep 'Password:' /etc/gitlab/initial_root_password`.

## Additional information

- [Install GitLab in Docker container](https://docs.gitlab.com/ee/install/docker/)
- [Managing PostgreSQL extensions](https://docs.gitlab.com/ee/install/postgresql_extensions.html)
- [Object storage](https://docs.gitlab.com/ee/administration/object_storage.html)
- [GitLab Runner Autoscaling](https://docs.gitlab.com/runner/runner_autoscale/)
- [GitLab Runner](https://docs.gitlab.com/runner/commands/)
- [Automate runner creation and registration](https://docs.gitlab.com/tutorials/automate_runner_creation/?tab=Shared)
