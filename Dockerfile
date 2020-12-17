FROM mcr.microsoft.com/dotnet/sdk:5.0.101-buster-slim-amd64 as builder

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash
RUN apt-get update && apt-get install -y nodejs

WORKDIR /workspace
COPY . .

RUN dotnet tool restore && npm install && \
    dotnet publish -c Release -o app src/Server/Server.fsproj && \
    dotnet fable src/Client --run parcel build index.html -d app/wwwroot

FROM mcr.microsoft.com/dotnet/aspnet:5.0.1-alpine3.12-amd64
COPY --from=builder /workspace/app .
EXPOSE 80
ENTRYPOINT [ "dotnet", "Server.dll" ]