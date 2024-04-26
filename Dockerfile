# Usar una imagen base de Node.js
FROM --platform=linux/arm64 node:20 as build

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app

# Copiar los archivos del proyecto al contenedor
COPY . .

# Instalar las dependencias del proyecto
RUN npm install

# Construir la aplicación para producción
RUN npm run build -- --output-path=./dist/out

# Usar una imagen base de Nginx para servir la aplicación
FROM nginx:alpine
COPY --from=build /app/dist/out/ /usr/share/nginx/html

# Exponer el puerto 80
EXPOSE 80
