require 'aws-sdk-s3'

Aws.config.update({
                    region: ENV['S3_MINIO_REGION'],
                    credentials: Aws::Credentials.new(ENV['S3_MINIO_KEY_ID'], ENV['S3_MINIO_SECRET_KEY'])
                  })

S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['S3_MINIO_BUCKET'])