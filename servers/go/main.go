// Simple HTTP Server
package main

import (
    "fmt"
    "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Language", "Go")
    fmt.Fprintf(w, "Hola desde Go!")
}

func main() {
	fmt.Println("Starting server on port 8080")
    http.HandleFunc("/", handler)
    http.ListenAndServe(":8080", nil)
}

