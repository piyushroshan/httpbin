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

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]
