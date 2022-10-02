# FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
# WORKDIR /src
# COPY HostingAsp.csproj .
# RUN dotnet restore "HostingAsp.csproj"
# COPY . .
# RUN dotnet publish "HostingAsp.csproj" -c Release -o /publish

# FROM mcr.microsoft.com/dotnet/aspnet:6.0 as final
# WORKDIR /app
# COPY --from=build /publish .

# ENTRYPOINT [ "dotnet", "HostingAsp.dll" ]

#Get Base SDK image from Microsoft
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

#Copy the CSPROJ file and restore any dependicies via NUGET
COPY *.csproj ./
RUN dotnet restore

#Copy the project files and build our release
COPY . ./
RUN dotnet publish -c Release -o out

#Genereate the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
EXPOSE 80
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "HostingAsp.dll"]