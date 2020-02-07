FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
COPY ["Client/workspace.Client.csproj", "Client/"]
COPY ["Server/workspace.Server.csproj", "Server/"]
COPY ["Shared/workspace.Shared.csproj", "Shared/"]
RUN dotnet restore "Client/workspace.Client.csproj"
RUN dotnet restore "Server/workspace.Server.csproj"
RUN dotnet restore "Shared/workspace.Shared.csproj"
COPY . .
WORKDIR "/src/Server"
RUN dotnet build "workspace.Server.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "workspace.Server.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "workspace.Server.dll"]
