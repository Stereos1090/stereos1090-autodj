# Script AutoDJ - Stereos 1090

# 1. Intentar cargar playlists si existen archivos, de lo contrario usar tono de prueba
bloque1 = playlist(default=sine(), mode="randomize", "/media/Bloque_1_Energizante_Pop-&-Electronic")
bloque2 = playlist(default=sine(), mode="randomize", "/media/Bloque_2_Atemporal_Rock-&-Grooves")
bloque3 = playlist(default=sine(), mode="randomize", "/media/Bloque_3_Atmosferico_Ambient-&-Synth")
jingles = playlist(default=sine(), mode="randomize", "/media/Jingles_IvanLoscher")

# 2. Rotación de música
radio_musica = rotate(weights=[1, 1, 1], [bloque1, bloque2, bloque3])

# 3. Intercalar 1 Jingle cada 3 canciones
radio_completa = rotate(weights=[3, 1], [radio_musica, jingles])

# 4. Asegurar la transmisión
fuente_segura = mksafe(radio_completa)

# 5. Conexión a Icecast
output.icecast(%mp3(bitrate=128),
  host = "stereos1090-radio.onrender.com",
  port = 8000,
  password = "Stereos1090Pass",
  mount = "/live",
  name = "Stereos 1090 - La Mejor Música del Planeta",
  description = "Transmisión en vivo 24/7",
  url = "https://radio.stereos1090.com",
  fuente_segura
)
