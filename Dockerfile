FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore "Project_BanSach/Project_BanSach/Project_BanSach.csproj"
RUN dotnet build "Project_BanSach/Project_BanSach/Project_BanSach.csproj" -c Release -o /app/build
RUN dotnet publish "Project_BanSach/Project_BanSach/Project_BanSach.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "Project_BanSach.dll"]
