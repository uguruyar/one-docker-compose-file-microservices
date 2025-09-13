# Backend Services Docker Compose Setup

This repository contains a **Docker Compose** setup for running essential backend services in a development environment. It includes MSSQL, MongoDB, RabbitMQ, Redis, Kafka, Grafana, and related services.

---

## Contents

- [Services](#services)
- [Setup](#setup)
- [Service UIs and Access](#service-uis-and-access)
- [Additional Configuration](#additional-configuration)

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

```

---


## Service UIs and Access

You can access the management UIs of the services using the following URLs and credentials:

| Service           | UI URL                     | Username | Password          |
|------------------|----------------------------|----------|-----------------|
| RabbitMQ          | [http://localhost:15672](http://localhost:15672) | admin    | D3v3l0pm3nt!   |
| Redis Insight     | [http://localhost:8001](http://localhost:8001)  | N/A      | N/A             |
| Kafka UI          | [http://localhost:8080](http://localhost:8080)  | N/A      | N/A             |
| Grafana           | [http://localhost:3000](http://localhost:3000)  | admin    | admin           |

> Note:
> - MSSQL, MongoDB, Redis, Zookeeper, and Kafka do not have native UIs exposed in this setup except through the above management tools.
> - For database access (MSSQL, MongoDB, Redis), use your preferred client with the credentials provided in the [Services](#services) section.

## Additional Configuration

This section provides additional configuration tips and notes for the backend services:

### 1. MSSQL
- Default SA password is set to `D3v3l0pm3nt!`. Change it for production.
- You can connect using SQL Server Management Studio (SSMS) or Azure Data Studio.
- Databases and tables should be created manually or using migration scripts.

### 2. MongoDB
- Root user: `admin`, Password: `D3v3l0pm3nt!`
- Use `mongo` shell or any MongoDB client to connect.
- Optional: You can add initialization scripts in `docker-entrypoint-initdb.d` folder if needed.

### 3. RabbitMQ
- Default user: `admin`, Password: `D3v3l0pm3nt!`
- Use management UI to create exchanges, queues, and bindings.
- Optionally, configure policies or plugins in the RabbitMQ container.

### 4. Redis
- Config file is mounted from `./redis.conf`.
- Password is `D3v3l0pm3nt!`.
- Redis Insight can be used to explore data and monitor keyspace.
- Adjust memory limits and eviction policies in `redis.conf` if needed.

### 5. Kafka & Zookeeper
- Kafka broker is configured to run on `kafka:9092`.
- Zookeeper client port: `2181`.
- Kafka UI can be used to monitor topics, consumer groups, and messages.
- For production, consider SSL/SASL authentication and replication setup.

### 6. Grafana
- Admin credentials: `admin/admin`.
- Add MSSQL or MongoDB as datasource.
- You can import or create dashboards to visualize metrics from other services.

### Notes
- Timezone for services is set to `Europe/Istanbul`. Change if needed.
- All services are connected via `backend-network` bridge network.
- Data volumes ensure persistence across container restarts.
- Containers restart automatically unless stopped manually.