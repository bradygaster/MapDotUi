FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
COPY ["MapDotUi.sln", "."]
COPY ["Client/MapDotUi.Client.csproj", "Client/"]
COPY ["Server/MapDotUi.Server.csproj", "Server/"]
COPY ["Shared/MapDotUi.Shared.csproj", "Shared/"]
COPY . .
WORKDIR "/src"
RUN dotnet build -c Release -o /app/build

FROM build AS publish
RUN dotnet publish -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "MapDotUi.Server.dll"]
