# Script de optimización de rendimiento para Android TV / CleanYourTV
param(
    [Parameter(Mandatory = $true)][string]$TvHost
)

$ErrorActionPreference = 'Continue'
$repo = "c:\Users\Developer\Documents\Antigravity projects\AI_RedTeam_LLM_Pentest\cleanyourtv"
$py = Join-Path $repo "tools\venv\Scripts\python.exe"
$env:TV_HOST = $TvHost

Write-Host "================================================="
Write-Host "Iniciando optimizacion en $TvHost"
Write-Host "================================================="

# 1. Reducción de latencia en animaciones
Write-Host "[1/4] Ajustando escalas de animacion a 0.5x..."
& $py (Join-Path $repo "tools\tv.py") "settings put global window_animation_scale 0.5" | Out-Null
& $py (Join-Path $repo "tools\tv.py") "settings put global transition_animation_scale 0.5" | Out-Null
& $py (Join-Path $repo "tools\tv.py") "settings put global animator_duration_scale 0.5" | Out-Null

$win = & $py (Join-Path $repo "tools\tv.py") "settings get global window_animation_scale"
$trans = & $py (Join-Path $repo "tools\tv.py") "settings get global transition_animation_scale"
$anim = & $py (Join-Path $repo "tools\tv.py") "settings get global animator_duration_scale"
Write-Host "  -> Escalas verificadas: Ventana=$win, Transicion=$trans, Animador=$anim"

# 2. Configuración de DNS Privado AdGuard
Write-Host "[2/4] Configurando DNS Privado (AdGuard TLS)..."
& $py (Join-Path $repo "tools\tv.py") "settings put global private_dns_mode hostname" | Out-Null
& $py (Join-Path $repo "tools\tv.py") "settings put global private_dns_specifier dns.adguard-dns.com" | Out-Null
$dnsMode = & $py (Join-Path $repo "tools\tv.py") "settings get global private_dns_mode"
$dnsHost = & $py (Join-Path $repo "tools\tv.py") "settings get global private_dns_specifier"
Write-Host "  -> DNS Privado verificado: Modo=$dnsMode, Host=$dnsHost"

# 3. Limpieza de memoria y caché muerta
Write-Host "[3/4] Purgando caches residuales..."
$trim = & $py (Join-Path $repo "tools\tv.py") "pm trim-caches 999M"
Write-Host "  -> $trim"

# 4. Precompilación AOT (speed mode) de aplicaciones instaladas
Write-Host "[4/4] Precompilando aplicaciones en modo AOT nativo (dex2oat speed)..."
$installed = & $py (Join-Path $repo "tools\tv.py") "pm list packages -3" | ForEach-Object { $_ -replace "^package:", "" }

$priorityApps = @(
    "com.netflix.ninja",
    "com.google.android.youtube.tv",
    "com.wbd.stream",
    "com.hbo.hbonow",
    "com.crunchyroll.crunchyroid",
    "org.jellyfin.androidtv",
    "com.amazon.amazonvideo.livingroom",
    "com.global.latinotv",
    "org.videolan.vlc",
    "com.disney.disneyplus",
    "com.spotify.tv.android",
    "tv.twitch.android.app"
)

foreach ($pkg in $priorityApps) {
    if ($installed -contains $pkg) {
        Write-Host "  -> Compilando $pkg..."
        $res = & $py (Join-Path $repo "tools\tv.py") "cmd package compile -m speed -f $pkg"
        Write-Host "     Estado: $res"
    }
}

Write-Host "Optimizacion completada exitosamente en $TvHost.`n"
