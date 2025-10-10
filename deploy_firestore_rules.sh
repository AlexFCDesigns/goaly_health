#!/bin/bash

# Script para desplegar las reglas de Firestore
echo "Desplegando reglas de Firestore..."

# Verificar si Firebase CLI está instalado
if ! command -v firebase &> /dev/null; then
    echo "Firebase CLI no está instalado. Instalando..."
    npm install -g firebase-tools
fi

# Iniciar sesión en Firebase (si no está ya logueado)
firebase login

# Desplegar las reglas de Firestore
echo "Desplegando reglas de seguridad..."
firebase deploy --only firestore:rules

echo "Desplegando índices..."
firebase deploy --only firestore:indexes

echo "¡Reglas de Firestore desplegadas exitosamente!"
echo "Ahora los usuarios autenticados pueden leer y escribir sus propios registros de salud."
