#!/bin/bash

# Archivo de salida
OUTPUT_FILE="diagnostico_maquina_$(date +%Y%m%d_%H%M%S).txt"

echo "Inicio del diagnóstico del sistema: $(date)" > $OUTPUT_FILE

# Información general del sistema
echo -e "\n--- Información General del Sistema ---\n" >> $OUTPUT_FILE
echo "Nombre del Host:" >> $OUTPUT_FILE
hostnamectl >> $OUTPUT_FILE
echo -e "\nInformación del sistema operativo:" >> $OUTPUT_FILE
cat /etc/os-release >> $OUTPUT_FILE

# Información del hardware
echo -e "\n--- Información del Hardware ---\n" >> $OUTPUT_FILE
echo "Procesador:" >> $OUTPUT_FILE
lscpu >> $OUTPUT_FILE
echo -e "\nMemoria RAM:" >> $OUTPUT_FILE
free -h >> $OUTPUT_FILE
echo -e "\nEspacio en disco:" >> $OUTPUT_FILE
df -h >> $OUTPUT_FILE
echo -e "\nDispositivos conectados:" >> $OUTPUT_FILE
lsblk >> $OUTPUT_FILE
echo -e "\nInformación PCI:" >> $OUTPUT_FILE
lspci >> $OUTPUT_FILE
echo -e "\nInformación USB:" >> $OUTPUT_FILE
lsusb >> $OUTPUT_FILE

# Estado de la red
echo -e "\n--- Información de Red ---\n" >> $OUTPUT_FILE
echo "Interfaces de red:" >> $OUTPUT_FILE
ip a >> $OUTPUT_FILE
echo -e "\nRutas de red:" >> $OUTPUT_FILE
ip route >> $OUTPUT_FILE
echo -e "\nPuertas de enlace activas:" >> $OUTPUT_FILE
netstat -rn >> $OUTPUT_FILE
echo -e "\nConexiones activas:" >> $OUTPUT_FILE
ss -tuln >> $OUTPUT_FILE

# Estado del sistema
echo -e "\n--- Estado del Sistema ---\n" >> $OUTPUT_FILE
echo "Carga del sistema:" >> $OUTPUT_FILE
uptime >> $OUTPUT_FILE
echo -e "\nProcesos en ejecución:" >> $OUTPUT_FILE
ps aux --sort=-%cpu >> $OUTPUT_FILE
echo -e "\nRegistros recientes del sistema:" >> $OUTPUT_FILE
dmesg | tail -n 50 >> $OUTPUT_FILE

# Información de salud del disco
echo -e "\n--- Información de Salud del Disco ---\n" >> $OUTPUT_FILE
echo "Estado SMART:" >> $OUTPUT_FILE
for disk in $(ls /dev/sd?); do
  echo -e "\nDisco: $disk" >> $OUTPUT_FILE
  sudo smartctl -H $disk >> $OUTPUT_FILE
done

# Información de temperatura (si disponible)
echo -e "\n--- Temperaturas de Hardware ---\n" >> $OUTPUT_FILE
sensors >> $OUTPUT_FILE

# Información del kernel y módulos
echo -e "\n--- Información del Kernel y Módulos ---\n" >> $OUTPUT_FILE
uname -a >> $OUTPUT_FILE
echo -e "\nMódulos del Kernel cargados:" >> $OUTPUT_FILE
lsmod >> $OUTPUT_FILE

# Resumen del informe
echo -e "\n--- Resumen del Diagnóstico ---\n" >> $OUTPUT_FILE
echo "El diagnóstico del sistema se completó exitosamente en $(date)." >> $OUTPUT_FILE
echo "Archivo generado: $OUTPUT_FILE" >> $OUTPUT_FILE

echo "Diagnóstico completo exportado a: $OUTPUT_FILE"
