docker build -t namlt3820/multi-client:latest -t namlt3820/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t namlt3820/multi-server:latest -t namlt3820/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t namlt3820/multi-worker:latest -t namlt3820/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push namlt3820/multi-client:latest
docker push namlt3820/multi-server:latest
docker push namlt3820/multi-worker:latest
docker push namlt3820/multi-client:$SHA
docker push namlt3820/multi-server:$SHA
docker push namlt3820/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=namlt3820/multi-server:$SHA
kubectl set image deployments/client-deployment client=namlt3820/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=namlt3820/multi-worker:$SHA
