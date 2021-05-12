eval $(minikube docker-env)
kubectl delete -f srcs/$1.yaml
docker rmi $1      
docker build -t $1 srcs/$1    
kubectl apply -f srcs/$1.yaml
