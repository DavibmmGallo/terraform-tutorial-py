FROM python:3.8

WORKDIR /app

# Install pip requirements
COPY ./src/main.py /app
COPY requirements.txt /app
RUN python -m pip install -r requirements.txt

ENTRYPOINT ["python", "main.py"]
