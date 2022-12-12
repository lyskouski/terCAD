#!/bin/sh

set -e

if [ -z "$AWS-S3-BUCKET" ]; then
  echo "AWS-S3-BUCKET is not set. Quitting."
  exit 1
fi

if [ -z "$AWS-ACCESS-KEY-ID" ]; then
  echo "AWS-ACCESS-KEY-ID is not set. Quitting."
  exit 1
fi

if [ -z "$AWS-SECRET-ACCESS-KEY" ]; then
  echo "AWS-SECRET-ACCESS-KEY is not set. Quitting."
  exit 1
fi

# Default to us-east-1 if AWS_REGION not set.
if [ -z "$AWS_REGION" ]; then
  AWS_REGION="us-east-1"
fi

# Override default AWS endpoint if user sets AWS_S3_ENDPOINT.
if [ -n "$AWS_S3_ENDPOINT" ]; then
  ENDPOINT_APPEND="--endpoint-url $AWS_S3_ENDPOINT"
fi

# Create a dedicated profile for this action to avoid conflicts
# with past/future actions.
# https://github.com/lyskouski/terCAD/issues/1
aws configure --profile terCAD <<-EOF > /dev/null 2>&1
${AWS-ACCESS-KEY-ID}
${AWS-SECRET-ACCESS-KEY}
${AWS_REGION}
text
EOF

# Sync using our dedicated profile and suppress verbose messages.
# All other flags are optional via the `args:` directive.
sh -c "aws s3 sync ${SOURCE_DIR:-.} s3://${AWS-S3-BUCKET}/${DEST_DIR} \
              --profile terCAD \
              --no-progress \
              ${ENDPOINT_APPEND} $*"

# Clear out credentials after we're done.
# We need to re-run `aws configure` with bogus input instead of
# deleting ~/.aws in case there are other credentials living there.
# https://forums.aws.amazon.com/thread.jspa?threadID=148833
aws configure --profile terCAD <<-EOF > /dev/null 2>&1
null
null
null
text
EOF