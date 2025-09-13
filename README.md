# Backend Services Docker Compose Setup

This repository contains a **Docker Compose** setup for running essential backend services in a development environment. It includes MSSQL, MongoDB, RabbitMQ, Redis, Kafka, Grafana, and related services.

---

## Contents

- [Services](#services)
- [Setup](#setup)
- [Service UIs and Access](#service-uis-and-access)
- [Additional Configuration](#additional-configuration)
- [Data Persistence](#data-persistence)
- [Network Configuration](#network-configuration)

---

## Services

### 1. MSSQL (Azure SQL Edge)

- **Image:** `mcr.microsoft.com/azure-sql-edge:latest`
- **Port:** `1433`
- **User:** `SA`
- **Password:** `D3v3l0pm3nt!`
- **Volume:** `mssql-data:/var/opt/mssql`
- **Healthcheck:** Checks SQL connection and runs `SELECT 1`.

> After MSSQL is up, you need to create databases and tables as required.

---

### 2. MongoDB

- **Image:** `mongo:latest`
- **Port:** `27017`
- **Root User:** `admin`
- **Root Password:** `D3v3l0pm3nt!`
- **Volume:** `mongo_data:/data/db`
- **Healthcheck:** Runs MongoDB `ping` command to verify availability.

> You can create additional users or initial data using `mongo-init.js` scripts if needed.

---

### 3. RabbitMQ

- **Image:** `rabbitmq:latest`
- **Ports:** `5672` (AMQP), `15672` (Management UI)
- **User:** `admin`
- **Password:** `D3v3l0pm3nt!`
- **Volume:** `rabbitmq_data:/var/lib/rabbitmq`
- **UI:** [http://localhost:15672](http://localhost:15672)

> Use the management panel to create exchanges, queues, and bindings.

---

### 4. Redis

- **Image:** `redis:latest`
- **Port:** `6379`
- **Volume:** `redis_data:/data`
- **Config:** `./redis.conf`
- **Password:** `D3v3l0pm3nt!`
- **Healthcheck:** Checks connection with `redis-cli ping`.

#### Redis Insight

- **Image:** `redis/redisinsight:latest`
- **Port:** `8001`
- **UI:** [http://localhost:8001](http://localhost:8001)

> Redis Insight allows you to visualize and manage Redis data structures.

---

### 5. Zookeeper

- **Image:** `confluentinc/cp-zookeeper:latest`
- **Port:** `2181`
- **Healthcheck:** `echo ruok | nc localhost 2181`
- **Volume:** `zookeeper_data:/var/lib/zookeeper`

---

### 6. Kafka

- **Image:** `confluentinc/cp-kafka:latest`
- **Port:** `9092`
- **Healthcheck:** `kafka-broker-api-versions --bootstrap-server localhost:9092`
- **Volume:** `kafka_data:/var/lib/kafka/data`

#### Kafka UI

- **Image:** `provectuslabs/kafka-ui:latest`
- **Port:** `8080`
- **UI:** [http://localhost:8080](http://localhost:8080)
- **Connection:** Kafka broker: `kafka:9092`

> Use Kafka UI to monitor topics, consumer groups, and message flows.

---

### 7. Grafana

- **Image:** `grafana/grafana:latest`
- **Port:** `3000`
- **Admin User:** `admin`
- **Password:** `admin`
- **Volume:** `grafana-data:/var/lib/grafana`
- **UI:** [http://localhost:3000](http://localhost:3000)

> Add datasources such as MSSQL or MongoDB and create dashboards in Grafana.

---

## Setup

Clone the repository:

```bash
git clone https://github.com/uguruyar/one-docker-compose-file-microservices.git
cd one-docker-compose-file-microservices

docker compose up -d

- **Rebuild and start updated application:**  
  If you have made changes to the Docker Compose file or any Dockerfile, use the following command to rebuild the images and start the containers with the updated configuration:

docker compose up -d --build