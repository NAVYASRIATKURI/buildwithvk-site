#!/bin/bash

# Deploy VK Engineers website to S3
# Usage: ./deploy-to-s3.sh your-bucket-name

BUCKET_NAME=buildwithvksite

echo "🔨 Building website..."
npm run build

if [ $? -ne 0 ]; then
    echo "❌ Build failed!"
    exit 1
fi

echo "📦 Build successful!"
echo "☁️  Uploading to S3 bucket: $BUCKET_NAME"

# Sync public folder to S3
aws s3 sync public/ s3://$BUCKET_NAME/ --delete --profile pmh

if [ $? -eq 0 ]; then
    echo "✅ Deployment successful!"
    echo "🌐 Your website is live at: http://$BUCKET_NAME.s3-website-us-east-1.amazonaws.com"
    echo "(URL may vary based on your region)"
else
    echo "❌ Deployment failed!"
    exit 1
fi

