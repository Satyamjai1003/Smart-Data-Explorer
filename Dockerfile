FROM python:3.10-slim

WORKDIR /app

# Improve Python behavior
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Upgrade pip
RUN pip install --upgrade pip

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Configure Streamlit
RUN mkdir -p /root/.streamlit && \
    echo "[browser]\ngatherUsageStats=false\n[server]\nheadless=true\nport=8501\nenableCORS=false" > /root/.streamlit/config.toml

EXPOSE 8501

CMD ["streamlit", "run", "app.py", "--server.address=0.0.0.0"]