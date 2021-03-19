package main

import (
	"encoding/json"
	"fmt"
	"net/http"
)

type Code struct {
	Name  string
	Email string
}

func api(w http.ResponseWriter, r *http.Request) {
	var p Code

	err := json.NewDecoder(r.Body).Decode(&p)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	fmt.Fprintf(w, p.Name)
	exe_cmd(p.Name)
	return
}
