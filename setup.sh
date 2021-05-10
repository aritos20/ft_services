# Inicio de minikube
minikube delete;
minikube --vm-driver=virtualbox start

eval $(minikube docker-env)

# Se activan los addons
minikube addons enable metrics-server
minikube addons enable dashboard
minikube addons enable metallb
kubectl apply -f srcs/metallb.yaml

# Se construyen las imagenes
printf "🐳 Building Docker Images...\n"
docker build -t nginx srcs/nginx
printf "🐳 🛠 Nginx Done!\n"
docker build -t wordpress srcs/wordpress
printf "🐳 🛠 Wordpress Done!\n"
docker build -t mysql srcs/mysql
printf "🐳 🛠 Mysql Done!\n"
docker build -t phpmyadmin srcs/phpmyadmin
printf "🐳 🛠 Phpmyadmin Done!\n"


# Se ejecutan los yamls
printf "Deploying Services...\n"
kubectl apply -f srcs/volumes.yaml
kubectl apply -f srcs/nginx.yaml
printf "🛠 Nginx Done!\n"
kubectl apply -f srcs/wordpress.yaml
printf "🛠 Wordpress Done!\n"
kubectl apply -f srcs/mysql.yaml
printf "🛠 Mysql Done!\n"
kubectl apply -f srcs/phpmyadmin.yaml
printf "🛠 Phpmyadmin Done!\n"

# Se inicia el dashboard de minikube
minikube dashboard