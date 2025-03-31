# Verify the S3 setup

GitLab provided commands to verify the S3 status. In the GitLab container run the following commnads:

1. **Verify artifacs remote storage**

    ```bash
    gitlab-rake gitlab:artifacts:check
    ```

2. **Verify Large Files (LFS) remote storage**

    ```bash
    gitlab-rake gitlab:lfs:check
    ```

3. **Verify backup remote storage**

    ```bash
    gitlab-rake gitlab:uploads:check
    ```

> [!note]
> Use the `docker exec -it <container_name> bash` command to interact with the container.
