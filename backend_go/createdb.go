package main

import (
	"database/sql"
	"fmt"
	"net/http"
)

func createdb(w http.ResponseWriter, r *http.Request) {

	db, err := sql.Open("mysql", db_username+":"+db_password+"@tcp("+db_host+")/"+db_name)

	if err != nil {
		panic(err.Error())
	}

	results, err := db.Query("CREATE TABLE `" + db_name + "` (`id` int NOT NULL AUTO_INCREMENT,`time` datetime NOT NULL,`shell` text NOT NULL,`out` text NOT NULL,PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;")
	if err != nil {
		panic(err.Error())
	}
	fmt.Println(results)

	w.Write([]byte("Success"))

	return
}
