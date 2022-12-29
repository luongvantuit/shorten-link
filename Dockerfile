FROM python:3-alpine3.9 AS Env

WORKDIR /app/venv

RUN apt-get update -y 

RUN apt-get install -y python3-venv

COPY ./requirements.txt ./requirements.txt

RUN python3 -m venv ./venv

RUN source ./venv/bin/activate

RUN pip install -r ./requirements.txt

RUN python -m pip install --upgrade pip

FROM python:3-alpine3.9 AS Builder

WORKDIR /app/runner

COPY . .

COPY --from=Env /app/venv/venv ./menv

RUN source ./venv/bin/activate 

EXPOSE 8000
