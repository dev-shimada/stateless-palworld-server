# build
- build
  ```bash
  docker buildx build --platform=linux/amd64 server -t palworld-server:`date "+%Y%m%d"`
  ```

# run
- run
  ```bash
  docker run -it --name palworld -p 8211:8211/udp -e STORE=s3://example/data0 palworld-server:`date "+%Y%m%d"`
  ```
