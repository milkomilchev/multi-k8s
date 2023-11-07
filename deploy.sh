docker build -t milkomilchev/multi-client:latest -t milkomilchev/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t milkomilchev/multi-server:latest -t milkomilchev/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t milkomilchev/multi-worker:latest -t milkomilchev/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push milkomilchev/multi-client:latest
docker push milkomilchev/multi-server:latest
docker push milkomilchev/multi-worker:latest

docker push milkomilchev/multi-client:$SHA
docker push milkomilchev/multi-server:$SHA
docker push milkomilchev/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server-milkomilchev/multi-server:$SHA
kubectl set image deployments/client-deployment client-milkomilchev/multi-client:$SHA
kubectl set image deployments/worker-deployment worker-milkomilchev/multi-worker:$SHA

