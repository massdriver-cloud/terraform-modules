import logging
import os

import redis
from pyramid.config import Configurator
from pyramid.response import Response

log = logging.getLogger(__name__)
r = redis.Redis(
    host=os.getenv('DB_HOST'),
    port=os.getenv('DB_PORT'),
    password=os.getenv('DB_PASSWORD'),
    db=0)


def hello_world(request):
    print('hello world')
    r.set('hello', 'world')
    return Response('Pyramid! Hello <strong>' + r.get('hello').decode('utf-8') + '</strong>')


def main(global_config, **settings):
    config = Configurator(settings=settings)
    config.add_route('hello', '/')
    config.add_view(hello_world, route_name='hello')
    return config.make_wsgi_app()
