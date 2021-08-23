docker build -t andrewresmed/multi-client:latest -t andrewresmed/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t andrewresmed/multi-server:latest -t andrewresmed/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t andrewresmed/multi-worker:latest -t andrewresmed/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push andrewresmed/multi-client:latest
docker push andrewresmed/multi-server:latest
docker push andrewresmed/multi-worker:latest

docker push andrewresmed/multi-client:$SHA
docker push andrewresmed/multi-server:$SHA
docker push andrewresmed/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=andrewresmed/multi-server:$SHA
kubectl set image deployments/client-deployment server=andrewresmed/multi-client:$SHA
kubectl set image deployments/worker-deployment server=andrewresmed/multi-worker:$SHA