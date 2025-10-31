docker build -f 4-dev-app.dockerfile -t broken-app .
docker run -p 3000:3000 broken-app