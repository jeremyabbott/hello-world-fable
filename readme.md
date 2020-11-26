# Hello World Fable

## Setup

```
dotnet tool restore
npm install
dotnet fable watch src/Client --run parcel watch index.html --hmr-port 1235 -d src/Server/wwwroot
```