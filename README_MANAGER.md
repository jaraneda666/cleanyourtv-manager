# CleanYourTV Manager — Gestión de Televisores Android TV

Proyecto independiente dedicado al mantenimiento, optimización, debloat y gestión del launcher estilo Apple TV en los televisores de la red local.

---

## 1. Dispositivos Gestionados

| Dispositivo | Modelo / Marca | IP | Sistema | Estado |
| :--- | :--- | :--- | :--- | :--- |
| **Living / Principal** | TCL BeyondTV (`BeyondTV`) | `192.168.2.4` | Android TV 11 (API 30) | Debloated, Optimizado, Launcher v3.1 |
| **Dormitorio / Secundario** | JVC SA 2K (`sugamo` / MediaTek) | `192.168.2.12` | Android TV 11 (API 30) | Debloated, Optimizado, Launcher v3.1 |

---

## 2. Aplicaciones Visibles en Pantalla (9 Apps)

1. **TV** (`com.tcl.tv` / `com.mediatek.wwtv.tvcenter`)
2. **YouTube** (`com.google.android.youtube.tv`)
3. **Tele Latino** (`com.global.latinotv`)
4. **Crunchyroll** (`com.crunchyroll.crunchyroid`)
5. **Jellyfin** (`org.jellyfin.androidtv`)
6. **Netflix** (`com.netflix.ninja`)
7. **HBO Max** (`com.wbd.stream`)
8. **Prime Video** (`com.amazon.amazonvideo.livingroom`)
9. **VLC** (`org.videolan.vlc`)

*Las demás aplicaciones del sistema permanecen instaladas pero ocultas de la interfaz (`hidden_apps`).*

---

## 3. Comandos Útiles

### Conectar y Tomar Captura de Pantalla
```powershell
$env:TV_HOST = "192.168.2.4" # O 192.168.2.12
.\tools\venv\Scripts\python.exe tools\tv.py --screenshot captura.png
```

### Re-aplicar Optimización de Rendimiento
```powershell
.\optimize_tv.ps1 -TvHost 192.168.2.4
.\optimize_tv.ps1 -TvHost 192.168.2.12
```

### Re-aplicar Orden y Configuración de Pantalla
```powershell
.\tools\theme.ps1 -TvHost 192.168.2.4 themes\custom-tcl
.\tools\theme.ps1 -TvHost 192.168.2.12 themes\custom-jvc
```

### Restaurar Apps Desactivadas (Rollback)
```powershell
.\tools\restore.ps1 -TvHost 192.168.2.4 tcl_beyondtv_clean.txt
.\tools\restore.ps1 -TvHost 192.168.2.12 jvc_clean.txt
```

---

## 4. Estructura del Proyecto
- `backup_192.168.2.4/`: Respaldo completo del TCL.
- `backup_192.168.2.12/`: Respaldo completo del JVC.
- `build_tools/`: Entorno portable de compilación (OpenJDK 17 y Android SDK 34).
- `launcher/`: Código fuente del launcher compilado.
- `themes/custom-tcl/` y `themes/custom-jvc/`: Configuraciones de los 9 iconos y cuadrícula.
