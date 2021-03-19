package main

import (
	"database/sql"
	"fmt"
	"net/http"
)

var db_username string
var db_password string
var db_host string
var db_name string

type Tag struct {
	ID    string `json:"id"`
	TIME  string `json:"time"`
	SHELL string `json:"shell"`
	OUT   string `json:"out"`
}

func logs(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	fmt.Println("Log's entered")

	db, err := sql.Open("mysql", db_username+":"+db_password+"@tcp("+db_host+")/"+db_name)
	if err != nil {
		panic(err.Error())
	}

	results, err := db.Query("SELECT * FROM " + db_name)
	if err != nil {
		panic(err.Error())
	}

	for results.Next() {
		var tag Tag

		err = results.Scan(&tag.ID, &tag.TIME, &tag.SHELL, &tag.OUT)
		if err != nil {
			panic(err.Error())
		}

		w.Write([]byte("--------------------------------------------------------------------------------------\n"))
		w.Write([]byte("ID - " + tag.ID + "\n"))
		w.Write([]byte("Time - " + tag.TIME + "\n"))
		w.Write([]byte("------------\n"))
		w.Write([]byte("Shell - " + tag.SHELL + "\n"))
		w.Write([]byte("Out - " + tag.OUT + "\n"))
		w.Write([]byte("--------------------------------------------------------------------------------------\n"))
	}

	return
}
