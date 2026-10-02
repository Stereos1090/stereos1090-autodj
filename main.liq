# Script AutoDJ - Stereos 1090

# 1. Definir listas de reproducción de las carpetas
bloque1 = playlist(mode="randomize", "/media/Bloque_1_Energizante_Pop-&-Electronic")
bloque2 = playlist(mode="randomize", "/media/Bloque_2_Atemporal_Rock-&-Grooves")
bloque3 = playlist(mode="randomize", "/media/Bloque_3_Atmosferico_Ambient-&-Synth")
jingles = playlist(mode="randomize", "/media/Jingles_IvanLoscher")

# 2. Rotación de música e intercalado de jingles
radio_musica = rotate(weights=[1, 1, 1], [bloque1, bloque2, bloque3])
radio_completa = rotate(weights=[3, 1], [radio_musica, jingles])

# 3. Fallback seguro: si las carpetas están vacías, emitir tono de prueba en lugar de cerrar el programa
radio_segura = fallback(track_sensitive=false, [radio_completa, sine()])

# 4. Asegurar transmisión continua
fuente_final = mksafe(radio_segura)

# 5. Salida hacia Icecast en Render
output.icecast(%mp3(bitrate=128),
  host = "stereos1090-radio.onrender.com",
  port = 8000,
  password = "Stereos1090Pass",
  mount = "/live",
  name = "Stereos 1090 - La Mejor Música del Planeta",
  description = "Transmisión en vivo 24/7",
  url = "https://radio.stereos1090.com",
  fuente_final
)
