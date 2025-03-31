external_url 'https://${GITLAB_DOMAIN}'
nginx['listen_https'] = true
nginx['redirect_http_to_https'] = true

{% if SSL_MODE == "letsencrypt" %}
letsencrypt['enable'] = true
letsencrypt['contact_emails'] = ['${LETSENCRYPT_EMAIL}']
letsencrypt['auto_renew'] = true
{% elif SSL_MODE == "custom" %}
nginx['ssl_certificate'] = "/etc/gitlab/ssl/${SSL_CERT_FILE}"
nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/${SSL_KEY_FILE}"
{% else %}
nginx['listen_https'] = false
nginx['redirect_http_to_https'] = false
nginx['listen_port'] = 80
gitlab_rails['gitlab_https'] = true
{% endif %}


#############################
# GitLab Database
#############################

{% if USE_EXTERNAL_DB == "true" %}
postgresql['enable'] = false
gitlab_rails['db_adapter'] = 'postgresql'
gitlab_rails['db_encoding'] = 'unicode'
gitlab_rails['db_database'] = '${EXTERNAL_DB_NAME}'
gitlab_rails['db_host'] = '${EXTERNAL_DB_HOST}'
gitlab_rails['db_username'] = '${EXTERNAL_DB_USER}'
gitlab_rails['db_password'] = '${EXTERNAL_DB_PASS}'
{% else %}
postgresql['enable'] = true
{% endif %}

#############################
# S3 BUCKET STORAGES
#############################

# Setup S3 connection for object storage
gitlab_rails[́́́'object_store']['enabled'] = true
gitlab_rails['object_store']['connection'] = {
    'provider' => 'AWS',
    'region' => '${AWS_REGION}',
    'use_iam_profile' => true
}
gitlab_rails['object_store']['objects']['artifacts']['enabled'] = true
gitlab_rails['object_store']['objects']['artifacts']['bucket'] = '${S3_BUCKET_ARTIFACTS}'
gitlab_rails['object_store']['objects']['lfs']['enabled'] = true
gitlab_rails['object_store']['objects']['lfs']['bucket'] = '${S3_BUCKET_LFS}'

# Setup Backup configuration
gitlab_rails['backup_upload'] = true
gitlab_rails['backup_upload_connection'] = {
    'provider' => 'AWS',
    'region' => '${AWS_REGION}',
    'use_iam_profile' => true
}
gitlab_rails['backup_upload_remote_directory'] = '${S3_BUCKET_BACKUPS}'
gitlab_rails['backup_keep_time'] = 604800 # Delete backups after 7 days (in seconds)
gitlab_rails['backup_multipart_chunk_size'] = 104857600 # Use multipart uploads for files larger than 100MB


#############################
# SMTP SETTINGS
#############################

# Setup SMTP connection for email notifications
gitlab_rails['smtp_enable'] = true
gitlab_rails['smtp_address'] = '${SMTP_SERVER}'
gitlab_rails['smtp_domain'] = '${SMTP_DOMAIN}'
gitlab_rails['smtp_port'] = '${SMTP_PORT}'
gitlab_rails['smtp_user_name'] = '${SMTP_USER}'
gitlab_rails['smtp_password'] = '${SMTP_PASS}'
gitlab_rails['smtp_authentication'] = '${SMTP_AUTH}'
gitlab_rails['smtp_enable_starttls_auto'] = true
gitlab_rails['smtp_tls'] = false
gitlab_rails['smtp_openssl_verify_mode'] = 'peer'
gitlab_rails['gitlab_email_enabled'] = true
gitlab_rails['gitlab_email_from'] = '${SMTP_USER}'
gitlab_rails['gitlab_email_reply_to'] = '${SMTP_USER}'


#############################
# GitLab Logging 
#############################

logging['svlogd_size'] = 200 * 1024 * 1024 # rotate after 200 MB of log data
logging['svlogd_num'] = 30 # keep 30 rotated log files
logging['svlogd_timeout'] = 24 * 60 * 60 # rotate after 24 hours
logging['svlogd_filter'] = "gzip" # compress logs with gzip
logging['svlogd_udp'] = nil # transmit log messages via UDP
logging['svlogd_prefix'] = nil # custom prefix for log messages
logging['logrotate_frequency'] = "daily" # rotate logs daily
logging['logrotate_maxsize'] = nil # logs will be rotated when they grow bigger than size specified for `maxsize`, even before the specified time interval (daily, weekly, monthly, or yearly)
logging['logrotate_size'] = nil # do not rotate by size by default
logging['logrotate_rotate'] = 30 # keep 30 rotated logs
logging['logrotate_compress'] = "compress" # see 'man logrotate'
logging['logrotate_method'] = "copytruncate" # see 'man logrotate'
logging['logrotate_postrotate'] = nil # no post-rotate command by default
logging['logrotate_dateformat'] = nil # use date extensions for rotated files rather than numbers e.g. a value of "-%Y-%m-%d" would give rotated files like production.log-2016-03-09.gz


#############################
# GitLab Container Registry
#############################

gitlab_rails['registry_enabled'] = true
registry_external_url 'https://registry-${GITLAB_DOMAIN}'
registry_nginx['listen_https'] = true
registry_nginx['redirect_http_to_https'] = true

{% if SSL_MODE == "letsencrypt" %}
letsencrypt['enable'] = true
letsencrypt['contact_emails'] = ['${LETSENCRYPT_EMAIL}']
letsencrypt['auto_renew'] = true
{% elif SSL_MODE == "custom" %}
registry_nginx['ssl_certificate'] = "/etc/gitlab/ssl/${SSL_CERT_FILE}"
registry_nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/${SSL_KEY_FILE}"
{% else %}
registry_nginx['listen_https'] = false
registry_nginx['redirect_http_to_https'] = false
registry_nginx['listen_port'] = 5050
{% endif %}


#############################
# GitLab Runner
#############################

# Register token for runners
gitlab_rails['ci_runner_registration_token'] = '${GITLAB_RUNNER_TOKEN}'