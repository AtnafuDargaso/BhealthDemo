FROM python:3.10-slim

WORKDIR /app

COPY apps/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY apps/ .

EXPOSE 8080
CMD ["python", "main.py"]
