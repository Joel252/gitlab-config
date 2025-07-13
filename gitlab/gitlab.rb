# For more options, visit:
# https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/files/gitlab-config-template/gitlab.rb.template

external_url ENV['GITLAB_URL']

# --- Database Configuration ---
# Use PostgreSQL as the database backend
postgresql['enable'] = ENV.fetch('USE_INTERNAL_DB', 'true') == 'true'
gitlab_rails['db_adapter'] = 'postgresql'
gitlab_rails['db_database'] = ENV.fetch('DB_NAME', 'gitlabhq_production')
gitlab_rails['db_host'] = ENV.fetch('DB_HOST', 'postgresql')
gitlab_rails['db_port'] = ENV.fetch('DB_PORT', '5432').to_i
gitlab_rails['db_username'] = ENV.fetch('DB_USER', 'gitlab')
gitlab_rails['db_password'] = ENV.fetch('DB_PASS', 'gitlab123')

# --- Backup Configuration ---
# Delete backups after 7 days (in seconds)
gitlab_rails['backup_keep_time'] = 604800
# Use multipart uploads for files larger than 100MB
gitlab_rails['backup_multipart_chunk_size'] = 104857600

# --- SMTP Configuration ---
gitlab_rails['smtp_enable'] = true
gitlab_rails['smtp_address'] = ENV.fetch('SMTP_HOST', 'smtp.gmail.com')
gitlab_rails['smtp_domain'] = ENV.fetch('SMTP_DOMAIN', 'gmail.com')
gitlab_rails['smtp_port'] = ENV.fetch('SMTP_PORT', '587').to_i
gitlab_rails['smtp_user_name'] = ENV.fetch('SMTP_USER', '')
gitlab_rails['smtp_password'] = ENV.fetch('SMTP_PASS', '')
gitlab_rails['smtp_authentication'] = ENV.fetch('SMTP_AUTH_METHOD', 'login')
gitlab_rails['smtp_enable_starttls_auto'] = true
gitlab_rails['smtp_tls'] = false
gitlab_rails['smtp_openssl_verify_mode'] = 'peer'
gitlab_rails['gitlab_email_enabled'] = true
gitlab_rails['gitlab_email_from'] = ENV.fetch('SMTP_USER', '')
gitlab_rails['gitlab_email_reply_to'] = ENV.fetch('SMTP_USER', '')
gitlab_rails['gitlab_email_display_name'] = ENV.fetch('EMAIL_DISPLAY_NAME', 'GitLab')

# --- Object Storage Configuration ---
# Use MinIO as the object storage backend
gitlab_rails['object_store']['enabled'] = ENV.fetch('OBJECT_STORAGE_ENABLED', 'true') == 'true'
gitlab_rails['object_store']['proxy_download'] = false
gitlab_rails['object_store']['connection'] = {
    'provider' => 'AWS',
    'region' => ENV.fetch('S3_REGION', 'us-east-1'),
    'aws_access_key_id' => ENV.fetch('S3_ACCESS_KEY', 'minioadmin'),
    'aws_secret_access_key' => ENV.fetch('S3_SECRET_KEY', 'minioadmin'),
    'endpoint' => ENV['S3_ENDPOINT'],
    'path_style' => true
}
gitlab_rails['object_store']['objects']['artifacts']['bucket'] = ENV.fetch('S3_BUCKET_ARTIFACTS', 'gitlab-bucket-artifacts')
gitlab_rails['object_store']['objects']['external_diffs']['bucket'] = ENV.fetch('S3_BUCKET_MR_DIFFS', 'gitlab-bucket-mr-diffs')
gitlab_rails['object_store']['objects']['lfs']['bucket'] = ENV.fetch('S3_BUCKET_LFS', 'gitlab-bucket-lfs')
gitlab_rails['object_store']['objects']['uploads']['bucket'] = ENV.fetch('S3_BUCKET_UPLOADS', 'gitlab-bucket-uploads')
gitlab_rails['object_store']['objects']['packages']['bucket'] = ENV.fetch('S3_BUCKET_PACKAGES', 'gitlab-bucket-packages')
gitlab_rails['object_store']['objects']['dependency_proxy']['bucket'] = ENV.fetch('S3_BUCKET_DEP_PROXY', 'gitlab-bucket-dependency-proxy')
gitlab_rails['object_store']['objects']['terraform_state']['bucket'] = ENV.fetch('S3_BUCKET_TF_STATE', 'gitlab-bucket-terraform-state')
gitlab_rails['object_store']['objects']['ci_secure_files']['bucket'] = ENV.fetch('S3_BUCKET_CI_SECURE', 'gitlab-bucket-ci-secure-files')
gitlab_rails['object_store']['objects']['pages']['bucket'] = ENV.fetch('S3_BUCKET_PAGES', 'gitlab-bucket-pages')

# --- Logrotate ---
# See: https://gitlab.com/gitlab-org/omnibus-gitlab/tree/master/README.md#logrotate
logrotate['enable'] = true
# rotate after 200 MB of log data
logging['svlogd_size'] = ENV.fetch('LOG_SIZE', '200').to_i * 1024 * 1024
# rotate after 24 hours
logging['svlogd_timeout'] = ENV.fetch('LOG_TIMEOUT', '86400').to_i
# rotate after 5 log files
logging['svlogd_num'] = ENV.fetch('SVLOGD_NUM', '5').to_i
logging['svlogd_filter'] = "gzip"
logging['logrotate_frequency'] = "daily"
logging['logrotate_compress'] = "compress"
logging['logrotate_method'] = "copytruncate"

# --- GitLab Registry ---
# Use GitLab's built-in container registry
gitlab_rails['registry_enabled'] = true
registry_external_url ENV['GITLAB_REGISTRY_URL']
gitlab_rails['registry_api_url'] = "#{ENV['GITLAB_REGISTRY_URL']}/api"
registry_nginx['listen_port'] = ENV.fetch('GITLAB_REGISTRY_PORT', '8443').to_i