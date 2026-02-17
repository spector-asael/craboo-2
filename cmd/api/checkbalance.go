// Filename: cmd/api/checkbalance.go
package main

import (
  // "encoding/json"
  "fmt"
  "net/http"
  // import the data package which contains the definition for Comment
  "github.com/spector-asael/craboo-2/internal/data"
)
                 
func (a *applicationDependencies) checkBalanceHandler(
    w http.ResponseWriter,
    r *http.Request,
) {

    var incomingData struct {
        UserID     int64 `json:"user_id"`
        BankNumber int64 `json:"bank_number"`
    }

    err := a.readJSON(w, r, &incomingData)
    if err != nil {
        a.badRequestResponse(w, r, err)
        return
    }

    amount, ok := validateBankAccount(incomingData.UserID, incomingData.BankNumber)
    if !ok {
        a.badRequestResponse(w, r, fmt.Errorf("invalid user_id or bank_number"))
        return
    }

    // Create your data.Balance struct
    balance := data.Balance{
        UserID: incomingData.UserID,
        Amount: amount,
    }

    err = a.writeJSON(
        w,
        http.StatusOK,
        envelope{"balance": balance},
        nil,
    )
    if err != nil {
        a.serverErrorResponse(w, r, err)
    }
}

func validateBankAccount(userID int64, bankNumber int64) (float64, bool) {

    // Fake database of accounts
    accounts := map[int64]struct {
        bankNumber int64
        balance    float64
    }{
        1: {bankNumber: 111111, balance: 2500.75},
        2: {bankNumber: 222222, balance: 980.50},
        3: {bankNumber: 333333, balance: 15000.00},
    }

    account, exists := accounts[userID]
    if !exists {
        return 0, false
    }

    if account.bankNumber != bankNumber {
        return 0, false
    }

    return account.balance, true
}
