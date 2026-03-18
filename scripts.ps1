docker build -t blog-lari:latest . 

docker run -d -p 80:80 blog-lari:latest

az login

# Create a resource group and an Azure Container Registry (ACR)
az group create --name rg-blog-lari --location eastus

# Create an Azure Container Registry (ACR)
az acr create --resource-group rg-blog-lari --name acrbloglari --sku Basic

# Log in to the ACR
az acr login --name acrbloglari

# Tag the Docker image for ACR
docker tag blog-lari:latest acrbloglari.azurecr.io/blog-lari:latest

# Push the Docker image to ACR
docker push acrbloglari.azurecr.io/blog-lari:latest

#containerID = 
#user = 
#password =

# Create Enveironment container app
az containerapp env create --name env-blog-lari --resource-group rg-blog-lari --location eastus

# Create Container App
az containerapp create --name app-blog-lari --resource-group rg-blog-lari --image acrbloglari.azurecr.io/blog-lari:latest --environment env-blog-lari --ingress external --target-port 80 --registry-server acrbloglari.azurecr.io --registry-username  --registry-password 

