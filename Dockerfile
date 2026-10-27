FROM savonet/liquidsoap:v2.1.4

# Cambiar a usuario root para permisos de montaje y directorios
USER root

# Crear los directorios de medios exactamente sincronizados con Cloudflare R2
RUN mkdir -p "/media/01_Ambiental_Tranquilo" \
             "/media/01_Dance_y_electronica_Alegre" \
             "/media/01_Rock_Enfadado" \
             "/media/02_Cinematografica_Dramatico" \
             "/media/02_Jazz_y_blues_Funky" \
             "/media/02_Pop_Inspirador" \
             "/media/03_Dance_y_electronica_Oscuro" \
             "/media/03_Hiphop_y_rap_Tranquilo" \
             "/media/03_R_and_B_y_soul_Positivo" \
             "/media/Jingles_Audio" \
             "/media/Videos_Visuales"

# Asignar la propiedad al usuario interno de liquidsoap
RUN chown -R liquidsoap:liquidsoap /media

# Volver al usuario seguro
USER liquidsoap

# Copiar el script de automatización maestro
COPY main.liq /etc/liquidsoap/main.liq

# Comando de ejecución por defecto
CMD ["liquidsoap", "/etc/liquidsoap/main.liq"]
