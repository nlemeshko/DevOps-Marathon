package main

import (
	"database/sql"
	"net/http"
)

func answer(w http.ResponseWriter, r *http.Request) {

	w.WriteHeader(http.StatusOK)

	db, err := sql.Open("mysql", db_username+":"+db_password+"@tcp("+db_host+")/"+db_name)
	if err != nil {
		panic(err.Error())
	}

	results, err := db.Query("SELECT a.out FROM " + db_name + " a ORDER BY ID DESC LIMIT 1;")
	if err != nil {
		panic(err.Error())
	}

	for results.Next() {
		var tag Tag

		err = results.Scan(&tag.OUT)
		if err != nil {
			panic(err.Error())
		}
		
		w.Write([]byte("Out - " + tag.OUT + "\n"))
	}

	return
}