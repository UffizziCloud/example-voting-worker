FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as builder

WORKDIR /Worker
COPY src/Worker/Worker.csproj Worker.csproj
RUN dotnet restore

COPY src/Worker/Worker.csproj Worker.csproj
COPY src/Worker/Program.cs Program.cs
RUN dotnet publish -c Release -o /out Worker.csproj

# app image
FROM mcr.microsoft.com/dotnet/core/runtime:3.1

WORKDIR /app
ENTRYPOINT ["dotnet", "Worker.dll"]

COPY --from=builder /out .

RUN echo "TEST CP"
RUN echo "TEST CP 1"
RUN echo "TEST CP 2"
