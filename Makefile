up:
	USER_ID=$$(id -u) docker compose up -d
stop:
	USER_ID=$$(id -u) docker compose stop
down:
	USER_ID=$$(id -u) docker compose down
down-v:
	USER_ID=$$(id -u) docker compose down -v
bash: up
	USER_ID=$$(id -u) docker compose exec notebook bash 
show_logs:
	USER_ID=$$(id -u) docker compose logs
configs:
	USER_ID=$$(id -u) docker compose config
