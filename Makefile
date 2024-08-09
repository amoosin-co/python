######################################################
#            Docker Container Management             #
######################################################
# Build the Docker containers using the specified configuration file and run them in detached mode, 
# removing any orphan containers and forcing recreation if necessary.
build:
	USER_ID=$$(id -u) docker compose up --build -d --remove-orphans --force-recreate

# Start the Docker containers defined in the specified configuration file in detached mode.
up:
	USER_ID=$$(id -u) docker compose up -d

# Stop and remove the Docker containers defined in the specified configuration file.
down:
	USER_ID=$$(id -u) docker compose down

# Stop and remove the Docker containers defined in the specified configuration file, including any volumes.
down_v:
	USER_ID=$$(id -u) docker compose down -v

# Display the logs of the Docker containers defined in the specified configuration file.
logs: up
	USER_ID=$$(id -u) docker compose logs

# Run bash in the notebook container
bash: up
	USER_ID=$$(id -u) docker compose exec notebook bash 

configs:
	USER_ID=$$(id -u) docker compose config

.PHONY: build up down down_v logs configs
