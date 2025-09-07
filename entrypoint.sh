#!/bin/bash
uv run gunicorn -b 0.0.0.0:5080 httpbin:app -k gevent --workers 4
