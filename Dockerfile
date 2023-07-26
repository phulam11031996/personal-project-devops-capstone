# Use the official Node.js 14 image as the base image
FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY /service ./service/
RUN useradd --uid 1000 not-root-user && chown -R not-root-user /app
USER not-root-user
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
