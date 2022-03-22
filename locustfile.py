from locust import HttpUser, task

class ServiceUser(HttpUser):
    @task
    def test(self):
        self.client.get("/ContainerResponse/")