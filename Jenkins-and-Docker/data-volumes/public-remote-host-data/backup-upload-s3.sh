#!/bin/bash

# DB Parameters
HOST=$1
DB_NAME=$2
DB_PASSWORD=$3

# AWS Parameters
AWS_ACCESS_KEY_ID=$4
AWS_SECRET_ACCESS_KEY=$5
BUCKET_NAME=$6

# Computed Parameters
CURRENT_DATE=$(date +%H-%M-%S)
BACKUP=db-$CURRENT_DATE.sql

# Make the Backup of the DB from MySQL container(db-host) and then upload it to AWS S3 Bucket
mysqldump -u root -h $HOST -p$DB_PASSWORD $DB_NAME > /tmp/$BACKUP && \
export AWS_ACCESS_KEY_ID && \
export AWS_SECRET_ACCESS_KEY && \
echo "Uploading your $BACKUP" && \
aws s3 cp /tmp/$BACKUP s3://$BUCKET_NAME/$BACKUP