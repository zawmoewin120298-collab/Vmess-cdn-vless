# CDN Demo (Railway + CloudFront)

## Run locally
npm install
npm start

## Docker
docker build -t cdn-demo .
docker run -p 3000:3000 cdn-demo

## Routes
/        → homepage  
/api/time → API endpoint
