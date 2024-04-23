
#Stage 2
FROM nginx:1.17.1-alpine

# Eliminar los archivos predeterminados de Nginx
RUN rm -rf /usr/share/nginx/html/*
# Establecer el directorio de trabajo donde Nginx espera los archivos estáticos
# Esto simplifica las rutas en los comandos subsiguientes
WORKDIR /usr/share/nginx/html/amigos-academicos-front

COPY ./dist/amigos-academicos-front/browser .
COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf
#COPY --from=build /usr/src/app/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

# When the container starts, replace the env.js with values from environment variables
CMD ["/bin/sh",  "-c",  "envsubst < /usr/share/nginx/html/amigos-academicos-front/assets/env.template.js > /usr/share/nginx/html/amigos-academicos-front/assets/env.js && exec nginx -g 'daemon off;'"]
