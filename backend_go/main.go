package main

import (
	"encoding/base64"
	"net/http"
	"strings"

	_ "github.com/go-sql-driver/mysql"
	"github.com/gorilla/mux"
)

var username string
var password string

func main() {

	r := mux.NewRouter()
	r.HandleFunc("/logs", use(logs, basicAuth))
	r.HandleFunc("/api", use(api, basicAuth))
	r.HandleFunc("/createdb", use(createdb, basicAuth))
	r.HandleFunc("/answer", use(answer, basicAuth))
	http.Handle("/", r)

	http.ListenAndServe(":9900", nil)
}

func use(h http.HandlerFunc, middleware ...func(http.HandlerFunc) http.HandlerFunc) http.HandlerFunc {
	for _, m := range middleware {
		h = m(h)
	}

	return h
}

func myHandler(w http.ResponseWriter, r *http.Request) {

	w.Write([]byte("Authenticated!"))
	return
}

func basicAuth(h http.HandlerFunc) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {

		w.Header().Set("WWW-Authenticate", `Basic realm="Restricted"`)

		s := strings.SplitN(r.Header.Get("Authorization"), " ", 2)
		if len(s) != 2 {
			http.Error(w, "Not authorized", 401)
			return
		}

		b, err := base64.StdEncoding.DecodeString(s[1])
		if err != nil {
			http.Error(w, err.Error(), 401)
			return
		}

		pair := strings.SplitN(string(b), ":", 2)
		if len(pair) != 2 {
			http.Error(w, "Not authorized", 401)
			return
		}

		if pair[0] != username || pair[1] != password {
			http.Error(w, "Not authorized", 401)
			return
		}

		h.ServeHTTP(w, r)
	}
}