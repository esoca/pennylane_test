include .env
export

.PHONY: spec
ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
TAG=$$(git log -1 --pretty=%h)

run server s:
	@echo "$(CYAN_COLOR)==> Starting rails server...$(NO_COLOR)"
	docker-compose up --build api

destroy:
	@echo "$(RED_COLOR)==> Destroying all containers...$(NO_COLOR)"
	@docker rm -f `docker ps -aq`

dbconsole dbc:
	@echo "$(CYAN_COLOR)==> Starting rails database console...$(NO_COLOR)"
	docker-compose exec db psql -d vesto-api_development -U vesto-api

console c:
	@echo "$(CYAN_COLOR)==> Starting rails console...$(NO_COLOR)"
	docker-compose run api rails console

migrate dbmigrate:
	@echo "$(CYAN_COLOR)==> Running database migrations...$(NO_COLOR)"
	docker-compose run --rm api rake db:migrate

seed dbseed:
	@echo "$(CYAN_COLOR)==> Seeding database...$(NO_COLOR)"
	docker-compose run --rm api rake db:seed

reset r: destroy migrate seed

rspec spec test:
	@echo "$(CYAN_COLOR)==> Running tests...$(NO_COLOR)"
	docker-compose run --rm api "RAILS_ENV=test rake db:test:prepare && RAILS_ENV=test bundle exec rspec $(ARGS)"

rails:
	@echo "$(YELLOW_COLOR)==> Execute custom rails command...$(NO_COLOR)"
	docker-compose run --rm api rails $(ARGS)

rake:
	@echo "$(YELLOW_COLOR)==> Execute custom rake command...$(NO_COLOR)"
	docker-compose run --rm api rake $(ARGS)
