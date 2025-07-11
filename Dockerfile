# Usa la imagen oficial de Maven con JDK 17
FROM maven:3.9.6-eclipse-temurin-17

# Define el directorio de trabajo dentro del contenedor
WORKDIR /app

# Instalar dependencias necesarias para Chrome
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    wget \
    xvfb \
    nano \
    gnupg \
    ca-certificates \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libatspi2.0-0 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libgbm1 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libvulkan1 \
    libxcomposite1 \
    libxdamage1 \
    libxkbcommon0 \
    libxrandr2 \
    xdg-utils \
    && rm -rf /var/lib/apt/lists/*

# Agregar la clave de firma de Google Chrome
RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | tee /etc/apt/keyrings/google-chrome.asc > /dev/null

# Descargar e instalar Google Chrome versión 133
RUN wget -q "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" \
    && apt-get install -y ./google-chrome-stable_current_amd64.deb \
    && rm google-chrome-stable_current_amd64.deb

# Descargar ChromeDriver versión 133.0.6943.141
RUN wget -q "https://storage.googleapis.com/chrome-for-testing-public/138.0.7204.94/linux64/chromedriver-linux64.zip" \
    && unzip chromedriver-linux64.zip \
    && mv chromedriver-linux64/chromedriver /usr/local/bin/ \
    && chmod +x /usr/local/bin/chromedriver \
    && rm -rf chromedriver-linux64.zip chromedriver-linux64

# Copiar el código del proyecto
COPY . /app

# Definir variables de entorno
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="$JAVA_HOME/bin:$PATH"
ENV CHROME_BIN=/usr/bin/google-chrome-stable
ENV CHROMEDRIVER_PATH=/usr/local/bin/chromedriver
ENV DISPLAY=:99

# Verificar las versiones instaladas
RUN echo "Java Version:" && java -version \
    && echo "Chrome Version:" && $CHROME_BIN --version \
    && echo "ChromeDriver Version:" && chromedriver --version

# Ejecutar Maven para compilar y ejecutar pruebas
CMD ["mvn", "test"]
