FROM savonet/liquidsoap:v2.1.4

# Cambiar a usuario administrador para tener permisos
USER root

# Crear los directorios de medios
RUN mkdir -p "/media/Bloque_1_Energizante_Pop-&-Electronic" \
             "/media/Bloque_2_Atemporal_Rock-&-Grooves" \
             "/media/Bloque_3_Atmosferico_Ambient-&-Synth" \
             "/media/Jingles_IvanLoscher"

# Asignar la propiedad de las carpetas al usuario liquidsoap
RUN chown -R liquidsoap:liquidsoap /media

# Volver al usuario seguro de liquidsoap
USER liquidsoap

# Copiar el script principal
COPY main.liq /etc/liquidsoap/main.liq

# Comando de arranque
CMD ["liquidsoap", "/etc/liquidsoap/main.liq"]
