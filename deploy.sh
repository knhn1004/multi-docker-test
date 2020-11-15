docker build -t chz1004/multi-client:latest -t chz1004/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chz1004/multi-server:latest -t chz1004/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chz1004/multi-worker:latest -t chz1004/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push chz1004/multi-client:latest
docker push chz1004/multi-server:latest
docker push chz1004/multi-worker:latest

docker push chz1004/multi-client:$SHA
docker push chz1004/multi-server:$SHA
docker push chz1004/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=chz1004/multi-client:$SHA
kubectl set image deployments/server-deployment server=chz1004/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=chz1004/multi-worker:$SHA
