import socket
import sys

def lookup(domain):
	try:
		return socket.gethostbyname(domain)
	except:
		return "-"

if __name__ == "__main__":
	print(lookup(sys.argv[1]))
