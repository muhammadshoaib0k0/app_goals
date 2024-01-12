# Using Minio in cargo

Minio is a high performance S3 object storage, which works seamlessly with ActiveStorage and can be easily implemented in Docker environments. If the server runs on Cargo, you can make use of minio by following this instructions:

In your Cargo stack:
* Go to `External Services` and create a new service:
  * Set `type` to `minio`
  * Set name to `minio`.
  * Set `MinIO bucket name in production` to match `stackname-staging/production-minio`. This name can not be changed afterwards.

  Note: If you need multiple minio bucket, you should use distinct namings in the first place.

* Now, go to `Services` and adjust all services which use ActiveStorage or may need access to minio (web, sidekiq, etc.). **Unassign the volume** used for ActiveStorage and **assign the external service** you just created. Make sure, that no service is claiming the storage volume anymore.

* Lastly, go to `Volumes` and remove the volume that is no longer needed. There is an indicator which shows how many services claim that volume. This indicator should be `0`.

This changes will take effect for the next deploy. Make sure, the next deploy includes the following **adjustments in the code**:

* First add the aws sdk gem:

  ```ruby
  # Gemfile

  gem 'aws-sdk-s3', require: false
  ```

* Define a new minio option in `config/storage.yml`. There is a template in Cargo. Just navigate to your external minio service and click on `Show ActiveStorage config`. It should like similiar to the codeblock below. Add these lines to the `config/storage.yml` file. The file now should usually include definition for `:local`, `:test` and `:minio`.

  ```yml
  # config/storage.yml

  minio:
    service: S3
    endpoint: <%= ENV["MINIO_HOST"] %>
    bucket: <%= ENV["MINIO_BUCKET"] %>
    access_key_id: <%= ENV["MINIO_ACCESS_KEY"] %>
    secret_access_key: <%= ENV["MINIO_SECRET_KEY"] %>
    region: eu-central-1
    force_path_style: true
    upload:
      cache_control: "private, max-age=31536000"
  ```

* Now, adjust your rails environment configurations which run in cargo (usually `production` only). Set therefore the active_storage service to `:minio`.

  ```ruby
    config.active_storage.service = :minio
    ```
