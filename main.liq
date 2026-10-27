# ==========================================
# Script AutoDJ Pro - Stereos 1090 (Hi-Fi)
# ==========================================

# 1. Definir listas de reproducción por cada categoría real en R2
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

# 2. Rotación musical balanceada de todos los bloques e intercalado inteligente de jingles
musica_general = rotate(weights=[1, 1, 1, 1, 1, 1, 1, 1, 1], 
                        [cat_ambient, cat_dance_leg, cat_rock, cat_cine, 
                         cat_jazz, cat_pop, cat_dance_osc, cat_hiphop, cat_rnb])

# Intercalar jingles comercialmente (1 jingle cada 4 pistas musicales)
radio_completa = rotate(weights=[4, 1], [musica_general, jingles])

# 3. Fallback de seguridad ultra robusto ante carpetas vacías o interrupciones
radio_segura = fallback(track_sensitive=false, [radio_completa, sine()])
fuente_final = mksafe(radio_segura)

# 4. Procesamiento de Audio Profesional (Mastering Dinámico en vivo)
# Aplicamos compresión y limitación para competir con las grandes cadenas radiales
fuente_master = compress(id="master_comp", threshold=-12.0, ratio=3.0, fuente_final)

# 5. Salida de Emisión en Alta Fidelidad (320 kbps para máxima nitidez sonora)
output.icecast(
    %mp3(bitrate=320, samplerate=44100, channels=2),
    host = "stereos1090-radio.onrender.com",
    port = 80,
    password = "Stereos1090Pass",
    mount = "/live",
    name = "Stereos 1090 - Hi-Fi Broadcast",
    description = "Emisión Oficial 24/7 en Alta Fidelidad",
    url = "https://stereos1090.com",
    fuente_master
)
