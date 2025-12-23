# stage 1:
# ubuntu based
FROM python:3.13-bookworm as builder
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y \
  libmariadb-dev \
  libmariadb-dev-compat \
  python3-dev \
  build-essential \
  pkg-config

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 8000
COPY . ./
RUN chmod +x runApp.sh

# stage 2:
FROM mysql:9.5
WORKDIR /app
COPY --from=builder /app/mysql_setup.sh /mysql_setup.sh
CMD ["./mysql_setup.sh"]
