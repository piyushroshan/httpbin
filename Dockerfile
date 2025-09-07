FROM python:3.12-slim

LABEL name="httpbin"
LABEL version="0.9.2"
LABEL description="A simple HTTP service."
LABEL org.kennethreitz.vendor="Kenneth Reitz"

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

# Set up the project
WORKDIR /httpbin
COPY pyproject.toml uv.lock ./
RUN uv sync --frozen

# Copy the rest of the application
COPY . /httpbin
RUN uv sync --frozen

EXPOSE 80

# Create a startup script
RUN echo '#!/bin/bash\nuv run gunicorn -b 0.0.0.0:80 httpbin:app -k gevent --workers 4' > /start.sh && chmod +x /start.sh

CMD ["/start.sh"]
