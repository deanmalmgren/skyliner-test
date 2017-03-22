FROM python:3.6-alpine
ADD . .

RUN apk add --no-cache supervisor && \

    pip install -r ./requirements.txt && \
    python manage.py collectstatic --noinput

# This is to protect against load balancer keep-alive timeouts; see
# https://github.com/benoitc/gunicorn/issues/1194 and
# https://serverfault.com/questions/782022/keepalive-setting-for-gunicorn-behind-elb-without-nginx
ENV PYTHONUNBUFFERED 1

CMD ["/usr/bin/supervisord", "-c", "supervisord.conf"]
