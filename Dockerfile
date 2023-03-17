FROM python:3.10

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc \
        python3-dev \
        libpq-dev \
        nginx && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /home/ubuntu/app


RUN git clone https://github.com/Waji-97/My-Website.git /home/ubuntu/app

COPY requirements.txt /home/ubuntu/app/

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt


WORKDIR /home/ubuntu/app/My-Website

COPY nginx.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/

EXPOSE 80

CMD ["sh", "-c", "nginx && python manage.py runserver 0.0.0.0:8000"]
