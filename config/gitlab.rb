# For more options, visit:
# https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/files/gitlab-config-template/gitlab.rb.template

external_url ENV['GITLAB_EXTERNAL_URL']

# --- SSL Configuration ---
letsencrypt['enable'] = ENV['LETSENCRYPT_ENABLED'] == "true" # true to use Let's Encrypt
letsencrypt['contact_emails'] = ["admin@#{ENV['GITLAB_DOMAIN']}"]
letsencrypt['auto_renew'] = true

nginx['listen_https'] = ENV['ENABLE_SSL'] == "true"
nginx['listen_port'] = 80 unless ENV['ENABLE_SSL'] == "true" # If SSL is disabled, listen on HTTP
nginx['redirect_http_to_https'] = ENV['ENABLE_SSL'] == "true"
nginx['ssl_certificate'] = "/etc/gitlab/ssl/#{ENV['GITLAB_DOMAIN']}.crt"
nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/#{ENV['GITLAB_DOMAIN']}.key"

# --- SSH Configuration ---
gitlab_rails['gitlab_shell_ssh_port'] = 22

# --- Database Configuration ---
postgresql['enable'] = ENV['USE_INTERNAL_DB']
gitlab_rails['db_adapter'] = "postgresql"
gitlab_rails['db_database'] = ENV['DB_NAME']
gitlab_rails['db_host'] = ENV['DB_HOST']
gitlab_rails['db_port'] = 5432
gitlab_rails['db_username'] = ENV['DB_USER']
gitlab_rails['db_password'] = ENV['DB_PASS']

# --- Redis Configuration ---
redis['enable'] = ENV['USE_INTERNAL_REDIS'] == "true"
gitlab_rails['redis_host'] = ENV['REDIS_HOST']
gitlab_rails['redis_port'] = 6379

# --- Object Storage Configuration ---
gitlab_rails['object_store']['enabled'] = ENV['OBJECT_STORAGE_ENABLED'] == "true"
gitlab_rails['object_store']['connection'] = {
  'provider' => 'AWS',
  'region' => ENV['S3_REGION'],
  'aws_access_key_id' => ENV['S3_ACCESS_KEY'],
  'aws_secret_access_key' => ENV['S3_SECRET_KEY'],
  'endpoint' => ENV['S3_ENDPOINT'],
}
gitlab_rails['object_store']['bucket'] = ENV['S3_BUCKET']

# --- Backup Configuration ---
gitlab_rails['backup_keep_time'] = 604800 # Delete backups after 7 days (in seconds)
gitlab_rails['backup_multipart_chunk_size'] = 104857600 # Use multipart uploads for files larger than 100MB

if ENV['BACKUP_METHOD'] == "s3"
  gitlab_rails['backup_upload_connection'] = {
    'provider' => 'AWS',
    'region' => ENV['S3_REGION'],
    'aws_access_key_id' => ENV['S3_ACCESS_KEY'],
    'aws_secret_access_key' => ENV['S3_SECRET_KEY'],
    'endpoint' => ENV['S3_ENDPOINT'],
  }
  gitlab_rails['backup_upload_remote_directory'] = ENV['S3_BACKUP_BUCKET']
elsif ENV['BACKUP_METHOD'] == "local"
  gitlab_rails['backup_path'] = "/var/opt/gitlab/backups"
  gitlab_rails['backup_archive_permissions'] = 0644
end

# --- SMTP Configuration ---
gitlab_rails['smtp_enable'] = true
gitlab_rails['smtp_address'] = ENV['SMTP_HOST']
gitlab_rails['smtp_port'] = 587
gitlab_rails['smtp_user_name'] = ENV['SMTP_USER']
gitlab_rails['smtp_password'] = ENV['SMTP_PASS']
gitlab_rails['smtp_domain'] = ENV['SMTP_DOMAIN']
gitlab_rails['smtp_authentication'] = "login"
gitlab_rails['smtp_enable_starttls_auto'] = true
gitlab_rails['gitlab_email_enabled'] = true
gitlab_rails['gitlab_email_from'] = ENV['SMTP_USER']
gitlab_rails['gitlab_email_display_name'] = ENV['EMAIL_DISPLAY_NAME']
gitlab_rails['gitlab_email_reply_to'] = ENV['SMTP_USER']

# --- Logrotate ---
# See: https://gitlab.com/gitlab-org/omnibus-gitlab/tree/master/README.md#logrotate
logrotate['enable'] = true
logging['logrotate_frequency'] = "daily"
logging['logrotate_size'] = ENV['LOGROTATE_SIZE']
logging['svlogd_filter'] = "gzip" # compress logs with gzip
logging['svlogd_size'] = 200 * 1024 * 1024 # rotate after 200 MB of log data
logging['svlogd_timeout'] = 24 * 60 * 60 # rotate after 24 hours

# --- GitLab Registry ---
registry_external_url ENV['GITLAB_REGISTRY_URL']
gitlab_rails['registry_enabled'] = true
gitlab_rails['registry_host'] = ENV['GITLAB_REGISTRY_DOMAIN']
gitlab_rails['registry_api_url'] = "#{ENV['GITLAB_REGISTRY_URL']}/api"
gitlab_rails['registry_key_path'] = "/etc/gitlab/ssl/registry.key"

# --- GitLab Pages ---
pages_external_url ENV['GITLAB_PAGES_URL']
gitlab_pages['enable'] = true
gitlab_pages['external_http'] = ['0.0.0.0:80'] unless ENV['ENABLE_SSL'] == "true"
gitlab_pages['external_https'] = ['0.0.0.0:443'] if ENV['ENABLE_SSL']  == "true"

# --- Register Token ---
gitlab_rails['initial_shared_runners_registration_token'] = ENV['GITLAB_RUNNER_TOKEN']
