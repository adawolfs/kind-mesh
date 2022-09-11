# Simple HTTP Server

import http.server
import socketserver
import re

PORT = 8080

class Handler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if re.search(".*\.html$", self.path):
            http.server.SimpleHTTPRequestHandler.do_GET(self)
        else:
            self.send_response(200)
            self.send_header("Language", "Python")
            self.end_headers()
            self.wfile.write(bytes("Hola desde Python!", "utf-8"))

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print("Starting Server on port", PORT)
    httpd.serve_forever()
