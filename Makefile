## run: run the cmd/api application
.PHONY: run help checkbalance deposit comment healthcheck all
run: 
	@echo 'Running application...'
	@go run ./cmd/api

# -------------------------------
# Help target
# -------------------------------
help:
	@echo "Available targets:"
	@echo "  make run            - Run the API server"
	@echo "  make checkbalance   - Test POST /balance"
	@echo "  make deposit        - Test POST /deposit"
	@echo "  make comment        - Test POST /comments"
	@echo "  make healthcheck    - Test GET /healthcheck"
	@echo "  make all            - Run all tests"

# -------------------------------
# POST /balance
# -------------------------------
checkbalance:
	@echo "Testing /balance..."
	curl -X POST http://localhost:4000/v1/balance \
	-H "Content-Type: application/json" \
	-d '{"user_id":1,"bank_number":111111}'

checkbalance2:
	@echo "Testing /balance..."
	curl -X POST http://localhost:4000/v1/balance \
	-H "Content-Type: application/json" \
	-d '{"user_id":2,"bank_number":111111}'
# -------------------------------
# POST /deposit
# -------------------------------
deposit:
	@echo "Testing /deposit..."
	curl -X POST http://localhost:4000/v1/deposit \
	-H "Content-Type: application/json" \
	-d '{"user_id":1,"bank_number":111111,"deposit_amount":500.75}'

deposit2:
	@echo "Testing /deposit..."
	curl -X POST http://localhost:4000/v1/deposit \
	-H "Content-Type: application/json" \
	-d '{"user_id":1,"bank_number":111111,"deposit_amount":500 75}'
# -------------------------------
# POST /comments
# -------------------------------
comment:
	@echo "Testing /comments..."
	curl -X POST http://localhost:4000/v1/comments \
	-H "Content-Type: application/json" \
	-d '{"content":"This is a test comment","author":"Spector"}'

# -------------------------------
# GET /healthcheck
# -------------------------------
healthcheck:
	@echo "Testing /healthcheck..."
	curl -X GET http://localhost:4000/v1/healthcheck

# -------------------------------
# Run all tests
# -------------------------------
all: checkbalance deposit comment healthcheck
