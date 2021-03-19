package main

import (
	"database/sql"
	"fmt"
)

func db(shell string, out string) {

	db, err := sql.Open("mysql", db_username+":"+db_password+"@tcp("+db_host+")/"+db_name)

	if err != nil {
		panic(err.Error())
	}

	results, err := db.Query("INSERT INTO `" + db_name + "` (`time`, `shell`, `out`) VALUES (now(),'" + shell + "','" + string(out) + "');")
	if err != nil {
		panic(err.Error())
	}

	fmt.Println(string(shell))
	fmt.Println(string(out))
	fmt.Println(results)

	return
}
