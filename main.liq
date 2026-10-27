# ==========================================
# Script AutoDJ PRO - Stereos 1090 (Omnicanal)
# ==========================================

# 1. Definición de listas musicales sincronizadas con R2
cat_ambient   = playlist(mode="randomize", "/media/01_Ambiental_Tranquilo")
cat_dance_leg = playlist(mode="randomize", "/media/01_Dance_y_electronica_Alegre")
cat_rock      = playlist(mode="randomize", "/media/01_Rock_Enfadado")
cat_cine      = playlist(mode="randomize", "/media/02_Cinematografica_Dramatico")
cat_jazz      = playlist(mode="randomize", "/media/02_Jazz_y_blues_Funky")
cat_pop       = playlist(mode="randomize", "/media/02_Pop_Inspirador")
cat_dance_osc = playlist(mode="randomize", "/media/03_Dance_y_electronica_Oscuro")
cat_hiphop    = playlist(mode="randomize", "/media/03_Hiphop_y_rap_Tranquilo")
cat_rnb       = playlist(mode="randomize", "/media/03_R_and_B_y_soul_Positivo")

jingles       = playlist(mode="randomize", "/media/Jingles_Audio")

# 2. Rotación general de géneros
musica_general = rotate(weights=[1, 1, 1, 1, 1, 1, 1, 1, 1], 
                        [cat_ambient, cat_dance_leg, cat_rock, cat_cine, 
                         cat_jazz, cat_pop, cat_dance_osc, cat_hiphop, cat_rnb])

# 3. Regla comercial exacta: 1 Jingle cada 4 pistas musicales (pesos 4 a 1)
radio_con_jingles = rotate(weights=[4, 1], [musica_general, jingles])

# 4. Transición sin baches (Crossfade inteligente de 3 segundos para mezcla continua)
radio_mezclada = crossfade(duration=3.0, radio_con_jingles)

# 5. Seguridad y Mastering Hi-Fi (320 kbps)
radio_segura = fallback(track_sensitive=false, [radio_mezclada, sine()])
fuente_master = compress(id="master_comp", threshold=-12.0, ratio=3.0, radio_segura)

# 6. Salida de Emisión en Alta Fidelidad
output.icecast(
    %mp3(bitrate=320, samplerate=44100, channels=2),
    host = "stereos1090-radio.onrender.com",
    port = 80,
    password = "Stereos1090Pass",
    mount = "/live",
    name = "Stereos 1090 - Pro Broadcast",
    description = "Emisión 24/7 con IA y Audio de Alta Fidelidad",
    url = "https://stereos1090.com",
    fuente_master
)
