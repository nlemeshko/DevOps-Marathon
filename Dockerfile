FROM golang:1.14.3-alpine
RUN mkdir /backend/
WORKDIR /backend
COPY ./backend_go /backend/.
RUN cd /backend/
RUN apk add git bash
RUN go get -u github.com/go-sql-driver/mysql && go get -u github.com/gorilla/mux
ARG username
ENV username=$username
ARG password
ENV password=$password
ARG db_username
ENV db_username=$db_username
ARG db_password
ENV db_password=$db_password
ARG db_host
ENV db_host=$db_host
ARG db_name
ENV db_name=$db_name
RUN go build -ldflags="-X 'main.username=$username' -X 'main.password=$password' -X 'main.db_username=$db_username' -X 'main.db_password=$db_password' -X 'main.db_host=$db_host' -X 'main.db_name=$db_name'"
CMD ./backend