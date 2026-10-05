FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY app ./app

# Create an unprivileged user.
RUN useradd --create-home appuser

# Stop the application running as root.
USER appuser

EXPOSE 8080

CMD ["python", "app/app.py"]