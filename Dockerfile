FROM savonet/liquidsoap:v2.2.4

# Copiar el script
COPY main.liq /app/main.liq

CMD ["liquidsoap", "/app/main.liq"]
