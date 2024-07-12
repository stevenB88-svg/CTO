#!/bin/bash

# Variables de configuración
SONARQUBE_VERSION="8.9.2.46101"
SONARQUBE_HOME="/opt/sonarqube"
SONARQUBE_PORT="9000"

# Descargar SonarQube
echo "Descargando SonarQube ${SONARQUBE_VERSION}..."
wget -q "https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-${SONARQUBE_VERSION}.zip" -P /tmp

# Descomprimir SonarQube
echo "Descomprimiendo SonarQube..."
sudo unzip -q /tmp/sonarqube-${SONARQUBE_VERSION}.zip -d /opt
sudo mv /opt/sonarqube-${SONARQUBE_VERSION} ${SONARQUBE_HOME}

# Configurar base de datos H2 (embebida)
echo "Configurando base de datos H2..."
cp ${SONARQUBE_HOME}/conf/sonar.properties ${SONARQUBE_HOME}/conf/sonar.properties.bak
sed -i 's/#sonar.jdbc.username=/sonar.jdbc.username=sonarqube/' ${SONARQUBE_HOME}/conf/sonar.properties
sed -i 's/#sonar.jdbc.password=/sonar.jdbc.password=sonarqube/' ${SONARQUBE_HOME}/conf/sonar.properties
sed -i 's/#sonar.jdbc.url=jdbc:h2.*/sonar.jdbc.url=jdbc:h2:tcp:\/\/localhost:9092\/sonar/' ${SONARQUBE_HOME}/conf/sonar.properties

# Configurar puerto de SonarQube
echo "Configurando puerto de SonarQube en ${SONARQUBE_PORT}..."
sed -i "s/#sonar.web.port=9000/sonar.web.port=${SONARQUBE_PORT}/" ${SONARQUBE_HOME}/conf/sonar.properties

# Iniciar SonarQube como servicio
echo "Iniciando SonarQube..."
${SONARQUBE_HOME}/bin/linux-x86-64/sonar.sh start

# Verificar estado de SonarQube
echo "Verificando estado de SonarQube..."
sleep 10  # Esperar unos segundos para asegurar que SonarQube se inicie completamente
${SONARQUBE_HOME}/bin/linux-x86-64/sonar.sh status

echo "Instalación y configuración completadas. SonarQube está listo para ser utilizado."
