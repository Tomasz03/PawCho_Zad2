#ETAP 1: Builder
FROM alpine:latest AS builder
#Instalacja kompilatora i narzędzi
RUN apk add --no-cache g++ make

WORKDIR /app
COPY main.cpp httplib.h ./

#Kompilacja aplikacji (statyczna)
RUN g++ main.cpp -o app -static -O3 -pthread

#ETAP 2: Finalny obraz
FROM alpine:latest

#Etykiety zgodne z OCI
LABEL org.opencontainers.image.authors="Tomasz Duchnik"
LABEL org.opencontainers.image.title="Weather App CPP"
LABEL org.opencontainers.image.description="Aplikacja pogodowa "
LABEL org.opencontainers.image.version="1.0.0"

WORKDIR /app
#Kopiujemy skompilowany plik z pierwszego etapu
COPY --from=builder /app/app /app/app

#Informacja o porcie
EXPOSE 8080

HEALTHCHECK - używamy wbudowanego wget zamiast dziurawego curl
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost:8080/ || exit 1

#Uruchomienie aplikacji
CMD ["/app/app"]