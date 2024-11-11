FROM ruby:3.0

RUN apt-get update -qq && apt-get install -y nodejs

RUN git config --global user.name "jose"
RUN git config --global user.email "jose.pizarro@unas.edu.pe"

WORKDIR /usr/src/app

RUN gem install rails -v 7.0

EXPOSE 3000

# 1. Elaborar el Dockerfile en una carpeta vacía
# 2. Construir la imágen del contenedor
#    docker build -t rubybasico:v1 .
# 3. Montar el contenedor
#    docker run -it --rm -v .:/usr/src/app -p 3000:3000 --name appmvc rubybasico:v1 bash
# 4. Crear un proyecto
#    rails new .
# 5. Establecer permisos desde el anfitrion
#    sudo chown -R jose:root *
# 6. Lanzar el servidor
#    rails server -b 0.0.0.0
# 7. Abrir otra terminal
#    docker exec -it appmvc bash