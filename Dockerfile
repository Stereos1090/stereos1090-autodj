FROM savonet/liquidsoap:v2.2.4

# Crear directorios de medios
RUN mkdir -p /media/Bloque_1_Energizante_Pop-&-Electronic \
             /media/Bloque_2_Atemporal_Rock-&-Grooves \
             /media/Bloque_3_Atmosferico_Ambient-&-Synth \
             /media/Jingles_IvanLoscher

# Copiar el script
COPY main.liq /app/main.liq

CMD ["liquidsoap", "/app/main.liq"]
