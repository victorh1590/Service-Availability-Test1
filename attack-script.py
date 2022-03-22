import docker
import requests
import time

def get_docker_client():
    try:
        client = docker.from_env()
        return client;
    except:
        print("Failed to connect to Docker Client.")
        exit(1)
        
def attack():
	counter = 0
	while counter < 10:
		client = get_docker_client()
		containers = client.containers.list()
		if len(containers) < 1:
			continue
		else:
			containers[0].kill()
			counter += 1
			print("Container killed: " + str(counter))
			time.sleep(3)
# Call
attack()


