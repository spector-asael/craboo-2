package main

import (
	"fmt"
	"net/http"
	"github.com/spector-asael/craboo-2/internal/data"
)

func (a *applicationDependencies) depositHandler(
	w http.ResponseWriter,
	r *http.Request,
) {

	// Use your data.Deposit struct directly
	var input data.Deposit

	err := a.readJSON(w, r, &input)
	if err != nil {
		a.badRequestResponse(w, r, err)
		return
	}

	// Basic validation
	if input.DepositAmount <= 0 {
		a.badRequestResponse(w, r, fmt.Errorf("deposit_amount must be greater than 0"))
		return
	}

	// Validate account exists (stub)
	_, ok := validateBankAccount(input.UserID, input.BankNumber)
	if !ok {
		a.badRequestResponse(w, r, fmt.Errorf("invalid user_id or bank_number"))
		return
	}

	// For now, just display a success message
	message := fmt.Sprintf(
		"Deposit of %.2f to user %d (bank %d) was successful!",
		input.DepositAmount,
		input.UserID,
		input.BankNumber,
	)

	err = a.writeJSON(
		w,
		http.StatusOK,
		envelope{"message": message},
		nil,
	)
	if err != nil {
		a.serverErrorResponse(w, r, err)
	}
}
