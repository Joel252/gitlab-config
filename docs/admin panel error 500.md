# Solve error 500 in the admin area

This error in GitLab is related to problems in the configuration or with data in the system, it usually occurs when you face a problem accessing the `/admin/runners` path in the new GitLab instance that you configured. Below are methods to solve this problem.

> [!note]
> How to reproduce:
>
> 1. login as admin
> 2. go into the admin menu
> 3. click on overview - runners or click save in the settings
>
> **Result:** 500 Error: Whoops, something went wrong on our end.

## Alternative 1: Verify the Database

The error in `/admin/runners` may be related to corrupt or inconsistent data in the GitLab database.

1. Run a database check to ensure that it is healthy and that there are no pending database migrations. To do this, you can run:

    ```bash
    sudo gitlab-rake db:migrate:status
    ```

2. If you find pending migrations, you can run them with:

    ```bash
    sudo gitlab-rake db:migrate
    ```

3. Run the following commands to force GitLab to apply the settings again:

     ```bash
     sudo gitlab-ctl reconfigure
     sudo gitlab-ctl restart
     ```

## Alternative 2: Copy the secrets

Copy the secrets.json of the old instance, that contains keys that are used to decrypt information.

## Alternative 3: Restore application settings

To resolve this issue in GitLab versions 13.0 and later, you can follow the steps below.

```bash
gitlab-rails console
> ApplicationSetting.first.delete
> ApplicationSetting.first
=> nil
```

---

For more information, visit [GitLab issue #57038](https://gitlab.com/gitlab-org/gitlab-foss/-/issues/57038)
