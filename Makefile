## run: run the cmd/api application
.PHONY: run help checkbalance deposit comment healthcheck all
run: 
	@echo 'Running application...'
	@go run ./cmd/api

# API base URL

API_BASE_URL = http://localhost:4000/v1

# Default JSON bodies

BALANCE_BODY = '{"user_id":1,"bank_number":111111}'
DEPOSIT_BODY  = '{"user_id":1,"bank_number":111111,"deposit_amount":500.75}'
COMMENT_BODY  = '{"content":"This is a test comment","author":"Spector"}'

# Help target

help:
	@echo "Available targets:"
	@echo "  make run            - Run the API server"
	@echo "  make checkbalance   - Test POST /checkbalance"
	@echo "  make deposit        - Test POST /deposit"
	@echo "  make comment        - Test POST /comments"
	@echo "  make healthcheck    - Test GET /healthcheck"
	@echo "  make all            - Run all tests"

# POST /checkbalance
checkbalance:
	@echo "Testing /checkbalance..."
	@body='$(BALANCE_BODY)'; \
	curl -s -X POST $(API_BASE_URL)/checkbalance \
	-H "Content-Type: application/json" \
	-d "$$body" | jq

# POST /deposit
deposit:
	@echo "Testing /deposit..."
	@body='$(DEPOSIT_BODY)'; \
	curl -s -X POST $(API_BASE_URL)/deposit \
	-H "Content-Type: application/json" \
	-d "$$body" | jq

# POST /comments
comment:
	@echo "Testing /comments..."
	@body='$(COMMENT_BODY)'; \
	curl -s -X POST $(API_BASE_URL)/comments \
	-H "Content-Type: application/json" \
	-d "$$body" | jq

# GET /healthcheck
healthcheck:
	@echo "Testing /healthcheck..."
	curl -s -X GET $(API_BASE_URL)/healthcheck | jq

# Run all tests
all: checkbalance deposit comment healthcheck
