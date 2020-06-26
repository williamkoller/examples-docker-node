# baixa a imagem e roda
docker run \
    --name mongo \
    -p 27017:27017 \
    -d \
    mongo:4

docker ps # listar os containers ativos    
docker stop # para o container

docker exec -it mongo mongo 

# app
docker volume create --name nodemodules

docker build -t nodejs-with-mongodb-api-example


# running with app

docker run \
    --name app \
    --link mongo \
    -e MONGO_URL=mongo \
    -e PORT=4000 \
    -p 4000:4000 \
    -v `pwd`/nodejs-with-mongodb-api-example:/src \
    -v nodemodules:/src/node_modules \
    app npm run dev:watch 

docker rm app 
docker volume rm nodemodules    
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)

docker-compose up --build
docker-compose down 