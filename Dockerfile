# Base image để chạy app
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80

# Image để build app
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copy file .csproj riêng để restore nhanh và không dính file thừa
COPY Project_BanSach/Project_BanSach.csproj Project_BanSach/
RUN dotnet restore "Project_BanSach/Project_BanSach.csproj"

# Copy phần còn lại
COPY . .

WORKDIR /src/Project_BanSach
RUN dotnet build -c Release -o /app/build
RUN dotnet publish -c Release -o /app/publish

# Final image
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "Project_BanSach.dll"]

