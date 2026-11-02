# CleanYourTV Manager

Herramienta de mantenimiento, optimización y depuración de aplicaciones para televisores y dispositivos Android TV vía conexión de depuración remota ADB (Android Debug Bridge).

---

## Arquitectura y Componentes

- **Conexión:** ADB inalámbrico sobre protocolo TCP/IP (puerto 5555).
- **Scripts de control:** Detección de paquetes, deshabilitación de telemetría y liberación de memoria RAM.
- **Interfaz:** Menús interactivos para diagnóstico rápido de estado.

---

## Instrucciones de Uso

```bash
# Conexión al televisor e inicio de optimización
python launcher/main.py --ip 192.168.1.100
```

---

## Consideraciones de Seguridad

- Este repositorio almacena código fuente, utilitarios de prueba y documentación técnica de ingeniería.
- Todas las credenciales, llaves privadas y variables de entorno deben suministrarse de forma local mediante archivos no versionados.
- Las herramientas de auditoría contenidas deben utilizarse exclusivamente en entornos autorizados y laboratorios de prueba.

---

**Autor:** Security Analyst  
**Licencia:** Uso Privado / Propietario
