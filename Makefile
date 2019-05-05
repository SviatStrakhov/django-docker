.PHONY: run-migrations connect-db-dev connect-db-prod check-volumes down-compose-prod build-compose-prod migrate-prod

restart-container-prod: down-compose-prod build-compose-prod migrate-prod

run-migrations:
    docker-compose exec web python manage.py migrate --noinput

connect-db-dev:
    docker-compose exec db psql --username=hello_django --dbname=hello_django_dev

connect-db-prod:
    docker-compose exec db psql --username=hello_django --dbname=hello_django_prod

check-volumes:
    docker volume inspect django-on-docker_postgres_data

down-compose-prod:
    docker-compose -f docker-compose.prod.yml down -v

build-compose-prod:
    docker-compose -f docker-compose.prod.yml up -d --build

migrate-prod:
    docker-compose -f docker-compose.prod.yml exec web python manage.py migrate --noinput

collect-static-prod:
    docker-compose -f docker-compose.prod.yml exec web python manage.py collectstatic --no-input --clear

container-logs:
    docker-compose logs -f