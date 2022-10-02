FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY HostingAsp.csproj .
RUN dotnet restore "HostingAsp.csproj"
COPY . .
RUN dotnet publish "HostingAsp.csproj" -c Release -o /publish

FROM mcr.microsoft.com/dotnet/aspnet:6.0 as final
WORKDIR /app
COPY --from=build /publish .

ENTRYPOINT [ "dotnet", "HostingAsp.dll" ]