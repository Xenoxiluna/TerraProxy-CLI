FROM swift
WORKDIR /app
COPY . ./
RUN swift package clean
RUN swift build -c release
EXPOSE 7777
ENTRYPOINT /bin/bash && ./.build/release/TerraProxy-CLI --proxy-source 0.0.0.0 --source-port 7777 --proxy-target 10.0.0.4 --target-port 7777 --service-only
