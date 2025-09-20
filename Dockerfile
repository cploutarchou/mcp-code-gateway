FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install ripgrep for code search
RUN apt-get update && apt-get install -y --no-install-recommends \
    ripgrep ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app ./app

ENV PORT=3333
EXPOSE 3333

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "3333"]