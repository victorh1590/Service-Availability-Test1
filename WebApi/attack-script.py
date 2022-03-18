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

def request_loop():
    status_code = 0
    while status_code != 200:
        try:
            response = requests.get("http://localhost:5000/", timeout=3)
            status_code = response.status_code
        except requests.exceptions.ConnectionError:
            print("Connection failed.")
            exit(1)
        status_code = response.status_code
    return response.json()

def shutdown_container(data):
    try:
        client = get_docker_client();
        client.containers.kill(data.ContainerId)
    except:
        print("Docker didn't accept the operation.")
        exit(1)

def attack():
    while True:
        time.sleep(3)
        data = request_loop()
        shutdown_container(data)

# Call
attack()


