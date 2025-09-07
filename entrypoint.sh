#!/bin/bash
uv run gunicorn -b 0.0.0.0:80 httpbin:app -k gevent --workers 4
